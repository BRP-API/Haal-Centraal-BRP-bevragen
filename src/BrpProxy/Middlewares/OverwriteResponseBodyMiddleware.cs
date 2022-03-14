using HaalCentraal.BrpProxy.Generated;
using Gba = HaalCentraal.BrpProxy.Generated.Gba;
using Newtonsoft.Json;
using System.IO.Compression;
using AutoMapper;

namespace BrpProxy.Middlewares
{
    public class OverwriteResponseBodyMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<OverwriteResponseBodyMiddleware> _logger;
        private readonly IMapper _mapper;

        public OverwriteResponseBodyMiddleware(RequestDelegate next, ILogger<OverwriteResponseBodyMiddleware> logger, IMapper mapper)
        {
            _next = next;
            _logger = logger;
            _mapper = mapper;
        }

        public async Task Invoke(HttpContext context)
        {
            var requestBody = await context.Request.ReadBodyAsync();
            _logger.LogDebug("original requestBody: {requestBody}", requestBody);
            var modifiedRequestBody = requestBody.Replace("\"fields\": \"\"", "\"fields\": \"aanschrijfwijze\"");
            using var requestBodyStream = modifiedRequestBody.ToMemoryStream();
            context.Request.Body = requestBodyStream;

            var orgBodyStream = context.Response.Body;

            using var newBodyStream = new MemoryStream();
            context.Response.Body = newBodyStream;

            await _next(context);

            var body = await context.Response.ReadBodyAsync();

            _logger.LogDebug("original responseBody: {body}", body);

            var modifiedBody = context.Response.StatusCode == StatusCodes.Status200OK
                ? body.Transform(_mapper)
                : body;

            _logger.LogDebug("transformed responseBody: {modifiedBody}", modifiedBody);

            using var bodyStream = modifiedBody.ToMemoryStream();

            context.Response.ContentLength = bodyStream.Length;
            await bodyStream.CopyToAsync(orgBodyStream);
        }
    }

    public static class BrpHelpers
    {
        public static string Transform(this string payload, IMapper mapper)
        {
            PersonenQueryResponse retval = null;
            var response = JsonConvert.DeserializeObject<Gba.PersonenQueryResponse>(payload);

            switch (response)
            {
                case Gba.RaadpleegMetBurgerservicenummerResponse p:
                    retval = mapper.Map<RaadpleegMetBurgerservicenummerResponse>(p);
                    break;
                case Gba.ZoekMetGeslachtsnaamEnGeboortedatumResponse pb:
                    retval = mapper.Map<ZoekMetGeslachtsnaamEnGeboortedatumResponse>(pb);
                    break;
                case Gba.ZoekMetNaamEnGemeenteVanInschrijvingResponse pb:
                    retval = mapper.Map<ZoekMetNaamEnGemeenteVanInschrijvingResponse>(pb);
                    break;
                case Gba.ZoekMetPostcodeEnHuisnummerResponse pb:
                    retval = mapper.Map<ZoekMetPostcodeEnHuisnummerResponse>(pb);
                    break;
            }

            return JsonConvert.SerializeObject(retval, new JsonSerializerSettings
            {
                NullValueHandling = NullValueHandling.Ignore,
                DefaultValueHandling = DefaultValueHandling.Ignore
            });
        }
    }

    public static class HttpResponseHelpers
    {
        public static async Task<string> ReadBodyAsync(this HttpRequest request)
        {
            request.EnableBuffering();

            request.Body.Seek(0, SeekOrigin.Begin);

            //var gzipStream = new GZipStream(response.Body, CompressionMode.Decompress);
            //var streamReader = new StreamReader(gzipStream);
            var streamReader = new StreamReader(request.Body, leaveOpen: true);

            var retval = await streamReader.ReadToEndAsync();

            request.Body.Seek(0, SeekOrigin.Begin);

            return retval;
        }

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
