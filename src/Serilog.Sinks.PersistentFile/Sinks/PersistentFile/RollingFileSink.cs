// Copyright 2013-2017 Serilog Contributors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

using System;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using Serilog.Core;
using Serilog.Debugging;
using Serilog.Events;
using Serilog.Formatting;

namespace Serilog.Sinks.PersistentFile
{
    sealed class RollingFileSink : ILogEventSink, IFlushableFileSink, IDisposable
    {
        readonly PathRoller _roller;
        readonly ITextFormatter _textFormatter;
        readonly long? _fileSizeLimitBytes;
        readonly int? _retainedFileCountLimit;
        readonly Encoding? _encoding;
        readonly bool _buffered;
        readonly bool _shared;
        readonly bool _rollOnFileSizeLimit;
        readonly FileLifecycleHooks? _hooks;
        readonly bool _keepFilename;
        readonly bool _rollOnEachProcessRun;
        readonly bool _useLastWriteAsTimestamp;

        readonly object _syncRoot = new object();
        bool _isDisposed;
        DateTime? _nextCheckpoint;
        IFileSink? _currentFile;

        private readonly object _syncLock = new object();


        public RollingFileSink(string path,
            ITextFormatter textFormatter,
            long? fileSizeLimitBytes,
            int? retainedFileCountLimit,
            Encoding? encoding,
            bool buffered,
            bool shared,
            PersistentFileRollingInterval persistentFileRollingInterval,
            bool rollOnFileSizeLimit,
            FileLifecycleHooks? hooks,
            bool keepFilename = false,
            bool rollOnEachProcessRun = true,
            bool useLastWriteAsTimestamp = false)
        {
            if (path == null) throw new ArgumentNullException(nameof(path));
            if (fileSizeLimitBytes.HasValue && fileSizeLimitBytes < 0)
                throw new ArgumentException("Negative value provided; file size limit must be non-negative.");
            if (retainedFileCountLimit.HasValue && retainedFileCountLimit < 1)
                throw new ArgumentException(
                    "Zero or negative value provided; retained file count limit must be at least 1.");

            _roller = new PathRoller(path, persistentFileRollingInterval);
            _textFormatter = textFormatter;
            _fileSizeLimitBytes = fileSizeLimitBytes;
            _retainedFileCountLimit = retainedFileCountLimit;
            _encoding = encoding;
            _buffered = buffered;
            _shared = shared;
            _rollOnFileSizeLimit = rollOnFileSizeLimit;
            _hooks = hooks;
            _keepFilename = keepFilename;
            _rollOnEachProcessRun = rollOnEachProcessRun;
            _useLastWriteAsTimestamp = useLastWriteAsTimestamp;
        }

        public void Emit(LogEvent logEvent)
        {
            if (logEvent == null) throw new ArgumentNullException(nameof(logEvent));

            lock (_syncRoot)
            {
                if (_isDisposed) throw new ObjectDisposedException("The log file has been disposed.");

                var now = Clock.DateTimeNow;
                AlignCurrentFileTo(now);

                while (_currentFile?.EmitOrOverflow(logEvent) == false && _rollOnFileSizeLimit)
                {
                    AlignCurrentFileTo(now, nextSequence: true);
                }
            }
        }

        void AlignCurrentFileTo(DateTime now, bool nextSequence = false)
        {
            if (!_nextCheckpoint.HasValue)
            {
                OpenFile(now);
            }
            else if (nextSequence || now >= _nextCheckpoint.Value)
            {
                CloseFile();
                OpenFile(now);
            }
        }

        void OpenFile(DateTime now)
        {
            var currentCheckpoint = _roller.GetCurrentCheckpoint(now);

            // We only try periodically because repeated failures
            // to open log files REALLY slow an app down.

            var existingFiles = Enumerable.Empty<string>();
            if (Directory.Exists(_roller.LogFileDirectory))
            {
                existingFiles = Directory.GetFiles(_roller.LogFileDirectory, _roller.DirectorySearchPattern)
                    .Select(p => Path.GetFileName(p));
            }

            if (_keepFilename)
            {
                const int maxAttempts = 3;

                // if current file exists we rename it with rolling date
                //we lock this portion of the code to avoid another process in shared mode to move the file
                //at the same time we are moving it. It might result in a missing file exception, because the second thread will try to move a file that has
                //been already moved.
                lock (_syncLock)
                {
                    _roller.GetLogFilePath(out var currentPath);
                    var fileInfo = new FileInfo(currentPath);

                    var latestForThisCheckpoint = _roller
                        .SelectMatches(existingFiles)
                        .Where(m => m.DateTime == currentCheckpoint || _useLastWriteAsTimestamp && m.DateTime == fileInfo.LastWriteTime)
                        .OrderByDescending(m => m.SequenceNumber)
                        .FirstOrDefault();

                    //int? sequence = latestForThisCheckpoint is null ? null : latestForThisCheckpoint.SequenceNumber ?? 1;
                    int? sequence = latestForThisCheckpoint?.SequenceNumber;

                    //we check of we have reach file size limit, if not we keep the same file. If we dont have roll on file size enable, we will create a new file as soon as one exists even if it is empty.
                    if (File.Exists(currentPath) && MustRoll(now) && (_rollOnFileSizeLimit ? fileInfo.Length >= _fileSizeLimitBytes : fileInfo.Length > 0))
                    {

                        for (var attempt = 0; attempt < maxAttempts; attempt++)
                        {
                            for (var i = sequence - 1; i > 0; i--)
                            {
                                _roller.GetLogFilePath(_useLastWriteAsTimestamp ? fileInfo.LastWriteTime : now,
                                i + 1, out var newPath);
                                _roller.GetLogFilePath(_useLastWriteAsTimestamp ? fileInfo.LastWriteTime : now,
                                i, out var oldPath);
                                try
                                {
                                    System.IO.File.Move(oldPath, newPath);
                                }
                                catch (FileNotFoundException)
                                {
                                    SelfLog.WriteLine("File {0 not found, skipping it}", oldPath);
                                }
                                catch (IOException ex)
                                {
                                    if (IOErrors.IsLockedFile(ex) || File.Exists(newPath))
                                    {
                                        SelfLog.WriteLine(
                                            "File target {0} was locked or exists, attempting to open next in sequence (attempt {1})",
                                            newPath, attempt + 1);
                                    }
                                }
                            }

                            //check if we have a date roll that has to get an index
                            if (latestForThisCheckpoint is not null && latestForThisCheckpoint.SequenceNumber is null && !latestForThisCheckpoint.Filename.Equals(new FileInfo(currentPath).Name))
                            {
                                _roller.GetLogFilePath(_useLastWriteAsTimestamp ? fileInfo.LastWriteTime : now,
                                1, out var dateRolledFile);
                                _roller.GetLogFilePath(_useLastWriteAsTimestamp ? fileInfo.LastWriteTime : now,
                                latestForThisCheckpoint.SequenceNumber, out var latestForThisCheckPointFile);
                                System.IO.File.Move(latestForThisCheckPointFile, dateRolledFile);
                            }

                            // move current file to datetime formatted file or first backup file
                            _roller.GetLogFilePath(_useLastWriteAsTimestamp ? fileInfo.LastWriteTime : now,
                                sequence > 1 ? 1 : sequence, out var path);
                            try
                            {
                                System.IO.File.Move(currentPath, path);
                            }
                            catch (IOException ex)
                            {
                                if (IOErrors.IsLockedFile(ex) || File.Exists(path))
                                {
                                    SelfLog.WriteLine(
                                        "File target {0} was locked or exists, attempting to open next in sequence (attempt {1})",
                                        path, attempt + 1);
                                    sequence = (sequence ?? 0) + 1;
                                    continue;
                                }

                                throw;
                            }

                            break;
                        }
                    }

                    //now we open the current file
                    try
                    {

                        _currentFile = _shared
                            ?
#pragma warning disable 618
                            (IFileSink)new SharedFileSink(currentPath, _textFormatter, _fileSizeLimitBytes, _encoding)
                            :
#pragma warning restore 618
                            new FileSink(currentPath, _textFormatter, _fileSizeLimitBytes, _encoding, _buffered, _hooks);
                    }
                    catch (IOException ex)
                    {
                        if (IOErrors.IsLockedFile(ex))
                        {
                            SelfLog.WriteLine("File target {0} was locked, this should not happen", currentPath);
                        }

                        throw;
                    }

                    ApplyRetentionPolicy(currentPath);
                }
            }
            else
            {
                var latestForThisCheckpoint = _roller
                    .SelectMatches(existingFiles)
                    .Where(m => m.DateTime == currentCheckpoint)
                    .OrderByDescending(m => m.SequenceNumber)
                    .FirstOrDefault();

                var sequence = latestForThisCheckpoint?.SequenceNumber;
                const int maxAttempts = 3;
                for (var attempt = 0; attempt < maxAttempts; attempt++)
                {
                    _roller.GetLogFilePath(now, sequence, out var path);

                    try
                    {
                        _currentFile = _shared
                            ?
#pragma warning disable 618
                            (IFileSink)new SharedFileSink(path, _textFormatter, _fileSizeLimitBytes, _encoding)
                            :
#pragma warning restore 618
                            new FileSink(path, _textFormatter, _fileSizeLimitBytes, _encoding, _buffered, _hooks);

                    }
                    catch (IOException ex)
                    {
                        if (IOErrors.IsLockedFile(ex))
                        {
                            SelfLog.WriteLine(
                                "File target {0} was locked, attempting to open next in sequence (attempt {1})", path,
                                attempt + 1);
                            sequence = (sequence ?? 0) + 1;
                            continue;
                        }

                        throw;
                    }

                    ApplyRetentionPolicy(path);
                    return;
                }
            }

            _nextCheckpoint = _roller.GetNextCheckpoint(now) ?? now.AddMinutes(30);
        }

        private bool MustRoll(DateTime now)
        {
            if (_rollOnEachProcessRun)
                return true;

            var currentCheckpoint = _roller.GetCurrentCheckpoint(now);
            if (!currentCheckpoint.HasValue)
                return false;

            _roller.GetLogFilePath(out var currentPath);
            var fileInfo = new FileInfo(currentPath);
            return fileInfo.Exists && fileInfo.LastWriteTime < currentCheckpoint;
        }

        void ApplyRetentionPolicy(string currentFilePath)
        {
            if (_retainedFileCountLimit == null) return;

            var currentFileName = Path.GetFileName(currentFilePath);


            // We consider the current file to exist, even if nothing's been written yet,
            // because files are only opened on response to an event being processed.
            var potentialMatches = Directory.GetFiles(_roller.LogFileDirectory, _roller.DirectorySearchPattern)
                .Select(p => Path.GetFileName(p))
                .Union(new[] { currentFileName });

            var newestFirst = _roller
                .SelectMatches(potentialMatches)
                .OrderByDescending(m => m.DateTime ?? DateTime.MaxValue)
                .ThenBy(m => m.SequenceNumber ?? int.MinValue)
                .Select(m => m.Filename);

            var toRemove = newestFirst
                .Where(n => _keepFilename || StringComparer.OrdinalIgnoreCase.Compare(currentFileName, n) != 0)
                .Skip(_retainedFileCountLimit.Value)
                .ToList();

            foreach (var obsolete in toRemove)
            {
                var fullPath = Path.Combine(_roller.LogFileDirectory, obsolete);
                try
                {
                    System.IO.File.Delete(fullPath);
                }
                catch (Exception ex)
                {
                    SelfLog.WriteLine("Error {0} while removing obsolete log file {1}", ex, fullPath);
                }
            }
        }

        public void Dispose()
        {
            lock (_syncRoot)
            {
                if (_currentFile == null) return;
                CloseFile();
                _isDisposed = true;
            }
        }

        void CloseFile()
        {
            if (_currentFile != null)
            {
                (_currentFile as IDisposable)?.Dispose();
                _currentFile = null;
            }

            _nextCheckpoint = null;
        }

        public void FlushToDisk()
        {
            lock (_syncRoot)
            {
                _currentFile?.FlushToDisk();
            }
        }
    }
}
