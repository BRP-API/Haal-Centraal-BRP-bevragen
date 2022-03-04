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

            var modifiedBody = body.Transform();

            using var bodyStream = modifiedBody.ToMemoryStream();

            context.Response.ContentLength = bodyStream.Length;
            await bodyStream.CopyToAsync(orgBodyStream);
        }
    }

    public static class BrpHelpers
    {
        public static string Transform(this string payload)
        {
            var personen = JsonConvert.DeserializeObject<PersonenQueryResponse>(payload);

            switch (personen)
            {
                case RaadpleegMetBurgerservicenummerResponse p:
                    p.Personen.Map();
                    break;
                case ZoekMetGeslachtsnaamEnGeboortedatumResponse pb:
                    pb.Personen.Map();
                    break;
                case ZoekMetGeslachtsnaamEnGemeenteVanInschrijvingResponse pb:
                    pb.Personen.Map();
                    break;
                case ZoekMetPostcodeEnHuisnummerResponse pb:
                    pb.Personen.Map();
                    break;
            }

            return JsonConvert.SerializeObject(personen);
        }

        private static void Map(this ICollection<Persoon> personen)
        {
            foreach (var persoon in personen)
            {
                persoon?.Geboorte.Map();
                persoon?.Naam.Map();
            }
        }

        private static void Map(this ICollection<PersoonBeperkt> personen)
        {
            foreach (var persoon in personen)
            {
                persoon?.Geboorte.Map();
                persoon?.Naam.Map();
            }
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
