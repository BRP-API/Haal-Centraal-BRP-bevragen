using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using Newtonsoft.Json;
using System.IO.Compression;

namespace BrpProxy.Middlewares
{
    public class OverwriteResponseBodyMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<OverwriteResponseBodyMiddleware> _logger;

        public OverwriteResponseBodyMiddleware(RequestDelegate next, ILogger<OverwriteResponseBodyMiddleware> logger)
        {
            _next = next;
            _logger = logger;
        }

        public async Task Invoke(HttpContext context)
        {
            var orgBodyStream = context.Response.Body;

            using var newBodyStream = new MemoryStream();
            context.Response.Body = newBodyStream;

            await _next(context);

            var body = await context.Response.ReadBodyAsync();

            _logger.LogInformation($"original: {body}");

            var modifiedBody = body.Transform(context.Request.Method == "GET");

            using var bodyStream = modifiedBody.ToMemoryStream();

            context.Response.ContentLength = bodyStream.Length;
            await bodyStream.CopyToAsync(orgBodyStream);
        }
    }

    public static class BrpHelpers
    {
        public static string Transform(this string payload, bool isRaadpleegPersoon)
        {
            string retval = payload;

            if(isRaadpleegPersoon)
            {
                var persoon = JsonConvert.DeserializeObject<PersoonHal>(payload);
                if(persoon != null)
                {
                    persoon.Geboorte.Map();
                    persoon.Naam.Map();
                    persoon.Verblijfplaats = persoon.Verblijfplaats.Map();

                    retval = JsonConvert.SerializeObject(persoon);
                }
            }
            else
            {
                var personen = JsonConvert.DeserializeObject<PersoonBeperktHalCollectie>(payload);

                foreach (var persoon in personen?._embedded.Personen)
                {
                    persoon?.Geboorte.Map();
                    persoon?.Naam.Map();
                }

                retval = JsonConvert.SerializeObject(personen);
            }

            return retval;
        }
    }
    public static class HttpResponseHelpers
    {
        public static async Task<string> ReadBodyAsync(this HttpResponse response)
        {
            response.Body.Seek(0, SeekOrigin.Begin);

            //var gzipStream = new GZipStream(response.Body, CompressionMode.Decompress);
            //var streamReader = new StreamReader(gzipStream);
            var streamReader = new StreamReader(response.Body);

            var retval = await streamReader.ReadToEndAsync();

            response.Body.Seek(0, SeekOrigin.Begin);

            return retval;
        }
    }

    public static class MemoryStreamHelpers
    {
        public static MemoryStream ToMemoryStream(this string data)
        {
            var retval = new MemoryStream();

            //var gzipStream = new GZipStream(retval, CompressionMode.Compress);
            //var streamWriter = new StreamWriter(gzipStream);
            var streamWriter = new StreamWriter(retval);

            streamWriter.Write(data);
            streamWriter.Flush();

            retval.Seek(0, SeekOrigin.Begin);

            return retval;
        }
    }
}
