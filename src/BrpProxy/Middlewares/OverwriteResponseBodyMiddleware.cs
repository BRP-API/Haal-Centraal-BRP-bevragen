using HaalCentraal.BrpProxy.Generated;
using Newtonsoft.Json;
using System.Globalization;
using System.IO.Compression;
using System.Text.RegularExpressions;

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
            string retval;

            var personen = JsonConvert.DeserializeObject<IngeschrevenPersoonBeperktHalCollectie>(payload);

            foreach(var persoon in personen?._embedded.Ingeschrevenpersonen)
            {
                if(persoon.Geboortedatum is GbaDatum datum)
                {
                    persoon.Geboortedatum = datum.Map();
                }
            }

            retval = JsonConvert.SerializeObject(personen);

            return retval;
        }
    }

    public static class GbaDatumMapper
    {
        private static Regex GbaDatumRegex = new Regex("^(?<jaar>[0-9]{4})(?<maand>[0-9]{2})(?<dag>[0-9]{2})$");

        public static AbstractDatum Map(this GbaDatum datum)
        {
            if (GbaDatumRegex.IsMatch(datum.Waarde))
            {
                var match = GbaDatumRegex.Match(datum.Waarde);
                var jaar = int.Parse(match.Groups["jaar"].Value, CultureInfo.InvariantCulture);
                var maand = int.Parse(match.Groups["maand"].Value, CultureInfo.InvariantCulture);
                var dag = int.Parse(match.Groups["dag"].Value, CultureInfo.InvariantCulture);

                if (jaar != 0 && maand != 0 && dag != 0)
                {
                    return new Datum { Waarde = new DateTime(jaar, maand, dag) };
                }
                if (jaar == 0 && maand == 0 && dag == 0)
                {
                    return new OnbekendDatum();
                }
                if (jaar != 0 && maand != 0 && dag == 0)
                {
                    return new JaarMaandDatum { Jaar = jaar, Maand = maand };
                }
                if (jaar != 0 && maand == 0 && dag == 0)
                {
                    return new JaarDatum { Jaar = jaar };
                }
            }
            return datum;
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
