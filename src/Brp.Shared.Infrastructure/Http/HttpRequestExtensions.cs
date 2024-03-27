using Microsoft.AspNetCore.Http;
using System.IO.Compression;

namespace Brp.Shared.Infrastructure.Http;

public static class HttpRequestExtensions
{
    public static bool UseGzip(this HttpRequest request) => request.Headers.ContentEncoding.Contains("gzip");

    public static async Task<string> ReadBodyAsync(this HttpRequest request)
    {
        if (!request.Body.CanSeek)
        {
            request.EnableBuffering();
        }

        try
        {
            if (request.UseGzip())
            {
                return await ReadCompressedBodyAsync(request);
            }
            else
            {
                return await ReadUncompressedBodyAsync(request);
            }
        }
        catch (InvalidDataException)
        {
            return await ReadUncompressedBodyAsync(request);
        }
    }

    private static async Task<string> ReadCompressedBodyAsync(this HttpRequest request)
    {

        try
        {
            request.Body.Seek(0, SeekOrigin.Begin);

            GZipStream gzipStream = new(request.Body, CompressionMode.Decompress);
            StreamReader streamReader = new(gzipStream, leaveOpen: true);

            return await streamReader.ReadToEndAsync();
        }
        finally
        {
            request.Body.Seek(0, SeekOrigin.Begin);
        }

    }

    private static async Task<string> ReadUncompressedBodyAsync(this HttpRequest request)
    {
        try
        {
            request.Body.Seek(0, SeekOrigin.Begin);

            StreamReader streamReader = new(request.Body, leaveOpen: true);

            return await streamReader.ReadToEndAsync();
        }
        finally
        {
            request.Body.Seek(0, SeekOrigin.Begin);
        }
    }
}
