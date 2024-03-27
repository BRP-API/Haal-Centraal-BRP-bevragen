using System.IO.Compression;

namespace Brp.Shared.Infrastructure.Stream;

public static class MemoryStreamExtensions
{
    public static async Task<string> ReadAsync(this MemoryStream stream, bool useGzip)
    {
        if (useGzip)
        {
            return await stream.ReadCompressedAsync();
        }
        else
        {
            return await stream.ReadUncompressedAsync();
        }
    }

    private static async Task<string> ReadCompressedAsync(this MemoryStream stream)
    {
        try
        {
            stream.Seek(0, SeekOrigin.Begin);

            GZipStream gzipStream = new(stream, CompressionMode.Decompress);
            StreamReader streamReader = new(gzipStream);

            return await streamReader.ReadToEndAsync();
        }
        finally
        {
            stream.Seek(0, SeekOrigin.Begin);
        }
    }

    private static async Task<string> ReadUncompressedAsync(this MemoryStream stream)
    {
        try
        {
            stream.Seek(0, SeekOrigin.Begin);

            StreamReader streamReader = new(stream);

            return await streamReader.ReadToEndAsync();
        }
        finally
        {
            stream.Seek(0, SeekOrigin.Begin);
        }
    }
}
