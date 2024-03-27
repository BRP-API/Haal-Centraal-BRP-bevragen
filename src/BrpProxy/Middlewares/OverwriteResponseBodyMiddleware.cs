using Brp.Shared.Infrastructure.Http;
using Brp.Shared.Infrastructure.Stream;
using Brp.Shared.Infrastructure.Validatie;
using HaalCentraal.BrpProxy.Generated;
using Gba = HaalCentraal.BrpProxy.Generated.Gba;
using Newtonsoft.Json;
using System.IO.Compression;
using AutoMapper;
using BrpProxy.Validators;
using Newtonsoft.Json.Linq;
using Serilog;
using Brp.Shared.Infrastructure.ProblemDetails;

namespace BrpProxy.Middlewares
{
    public class OverwriteResponseBodyMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly IDiagnosticContext _diagnosticContext;
        private readonly IMapper _mapper;
        private readonly FieldsHelper _fieldsHelper;

        public OverwriteResponseBodyMiddleware(RequestDelegate next, IDiagnosticContext diagnosticContext, IMapper mapper, FieldsHelper fieldsHelper)
        {
            _next = next;
            _diagnosticContext = diagnosticContext;
            _mapper = mapper;
            _fieldsHelper = fieldsHelper;
        }

        public async Task Invoke(HttpContext context)
        {
            var orgBodyStream = context.Response.Body;
            string requestBody = string.Empty;
            try
            {
                if (!await context.HandleRequestMethodIsAllowed(_diagnosticContext))
                {
                    return;
                }
                if (!await context.HandleRequestAcceptIsSupported(_diagnosticContext))
                {
                    return;
                }
                if (!await context.HandleMediaTypeIsSupported(_diagnosticContext))
                {
                    return;
                }

                requestBody = await context.Request.ReadBodyAsync();

                if (!await context.RequestBodyIsValid(requestBody, orgBodyStream, _diagnosticContext))
                {
                    return;
                }

                PersonenQuery? personenQuery = null;
                try
                {
                    personenQuery = JsonConvert.DeserializeObject<PersonenQuery>(requestBody);
                }
                catch (JsonSerializationException ex)
                {
                    await context.HandleJsonSerializationException(ex, orgBodyStream, _diagnosticContext);
                    return;
                }
                catch (JsonReaderException ex)
                {
                    await context.HandleJsonReaderException(ex, orgBodyStream, _diagnosticContext);
                    return;
                }

                var result = personenQuery.Validate(context, requestBody, _fieldsHelper);
                if (!result.IsValid)
                {
                    await context.HandleValidationErrors(result.Foutbericht!, orgBodyStream, _diagnosticContext);
                    return;
                }

                using var newBodyStream = new MemoryStream();
                context.Response.Body = newBodyStream;

                await _next(context);

                if (context.Response.StatusCode == StatusCodes.Status404NotFound)
                {
                    await context.HandleNotFound(orgBodyStream, _diagnosticContext);
                    return;
                }

                var body = await context.Response.ReadBodyAsync();

                if (Log.IsEnabled(Serilog.Events.LogEventLevel.Debug))
                {
                    _diagnosticContext.Set("original responseBody", body);
                }

                var resultFields = personenQuery is RaadpleegMetBurgerservicenummer
                            ? _fieldsHelper.AddExtraPersoonFields(result.Fields!)
                            : _fieldsHelper.AddExtraPersoonBeperktFields(result.Fields!);

                var modifiedBody = context.Response.StatusCode == StatusCodes.Status200OK
                    ? body.Transform(_mapper, resultFields, result.Fields!, _diagnosticContext)
                    : body;

                if (Log.IsEnabled(Serilog.Events.LogEventLevel.Debug))
                {
                    _diagnosticContext.Set("transformed responseBody", modifiedBody);
                }

                using var bodyStream = modifiedBody.ToMemoryStream(context.Response.UseGzip());

                context.Response.ContentLength = bodyStream.Length;
                await bodyStream.CopyToAsync(orgBodyStream);
            }
            catch (Exception ex)
            {
                _diagnosticContext.SetException(ex);

                await context.HandleInternalServerError();
            }
        }
    }

    public static class BrpHelpers
    {
        public static ValidatePersonenQueryResult Validate(this PersonenQuery? personenQuery, HttpContext context, string requestBody, FieldsHelper fieldsHelper)
        {
            var result = personenQuery switch
            {
                RaadpleegMetBurgerservicenummer query => new RaadpleegMetBurgerservicenummerQueryValidator(fieldsHelper).Validate(query),
                ZoekMetGeslachtsnaamEnGeboortedatum query => new ZoekMetGeslachtsnaamEnGeboortedatumQueryValidator(fieldsHelper).Validate(query),
                ZoekMetPostcodeEnHuisnummer query => new ZoekMetPostcodeEnHuisnummerQueryValidator(fieldsHelper).Validate(query),
                ZoekMetNaamEnGemeenteVanInschrijving query => new ZoekMetNaamEnGemeenteVanInschrijvingQueryValidator(fieldsHelper).Validate(query),
                ZoekMetNummeraanduidingIdentificatie query => new ZoekMetNummeraanduidingIdentificatieQueryValidator(fieldsHelper).Validate(query),
                ZoekMetStraatHuisnummerEnGemeenteVanInschrijving query => new ZoekMetStraatHuisnummerEnGemeenteVanInschrijvingQueryValidator(fieldsHelper).Validate(query),
                _ => null
            };

            return result != null
                ? ValidatePersonenQueryResult.CreateFrom(result, personenQuery?.Fields, context)
                : ValidatePersonenQueryResult.CreateFrom(new PersonenQueryRequestBodyValidator().Validate(JObject.Parse(requestBody)), context);
        }

        private static bool IsProxyResponse(this string payload)
        {
            var proxyTokens = new List<string>
            {
                "adressering",
                "\"type\":\"Adres\"",
                "\"type\":\"Locatie\"",
                "\"type\":\"VerblijfplaatsBuitenland\"",
                "\"type\":\"VerblijfplaatsOnbekend\"",
                "langFormaat",
                "\"geheimhoudingPersoonsgegevens\":true",
                "\"vanuitVerblijfplaatsOnbekend\":true",
                "\"indicatieVestigingVanuitBuitenland\":true",
                "voorletters",
                "leeftijd",
                "volledigeNaam",
                "\"type\":\"Nationaliteit\"",
                "BehandeldAlsNederlander",
                "VastgesteldNietNederlander",
                "\"type\":\"Staatloos\"",
                "NationaliteitOnbekend",
                "\"verblijfstitel\":{}"
            };
            return proxyTokens.Exists(t => payload.Contains(t));
        }

        public static string Transform(this string payload, IMapper mapper, ICollection<string> fields, ICollection<string> originalFields, IDiagnosticContext diagnosticContext)
        {
            if(payload.IsProxyResponse())
            {
                diagnosticContext.Set("proxy2proxy aanroep", true);
                return payload;
            }

            PersonenQueryResponse retval;
            var response = JsonConvert.DeserializeObject<Gba.PersonenQueryResponse>(payload);

            switch (response)
            {
                case Gba.RaadpleegMetBurgerservicenummerResponse p:
                    var result = mapper.Map<RaadpleegMetBurgerservicenummerResponse>(p);
                    result.Personen = result.Personen.FilterAfgevoerdePersoon().ExcludeAdresregelsEnVerblijfplaatsBuitenland(originalFields).FilterList(fields);
                    retval = result;
                    break;
                case Gba.ZoekMetGeslachtsnaamEnGeboortedatumResponse pb:
                    var result1 = mapper.Map<ZoekMetGeslachtsnaamEnGeboortedatumResponse>(pb);
                    result1.Personen = result1.Personen.ExcludeAfgevoerdePersoon().FilterList(fields);
                    retval = result1;
                    break;
                case Gba.ZoekMetNaamEnGemeenteVanInschrijvingResponse pb:
                    var result3 = mapper.Map<ZoekMetNaamEnGemeenteVanInschrijvingResponse>(pb);
                    result3.Personen = result3.Personen.ExcludeAfgevoerdePersoon().FilterList(fields);
                    retval = result3;
                    break;
                case Gba.ZoekMetPostcodeEnHuisnummerResponse pb:
                    var result2 = mapper.Map<ZoekMetPostcodeEnHuisnummerResponse>(pb);
                    result2.Personen = result2.Personen.ExcludeAfgevoerdePersoon().FilterList(fields);
                    retval = result2;
                    break;
                case Gba.ZoekMetNummeraanduidingIdentificatieResponse pb:
                    var result4 = mapper.Map<ZoekMetNummeraanduidingIdentificatieResponse>(pb);
                    result4.Personen = result4.Personen.ExcludeAfgevoerdePersoon().FilterList(fields);
                    retval = result4;
                    break;
                case Gba.ZoekMetStraatHuisnummerEnGemeenteVanInschrijvingResponse pb:
                    var result5 = mapper.Map<ZoekMetStraatHuisnummerEnGemeenteVanInschrijvingResponse>(pb);
                    result5.Personen = result5.Personen.ExcludeAfgevoerdePersoon().FilterList(fields);
                    retval = result5;
                    break;
                default:
                    throw new NotSupportedException();
            }

            return JsonConvert.SerializeObject(retval, new JsonSerializerSettings
            {
                NullValueHandling = NullValueHandling.Ignore,
                DefaultValueHandling = DefaultValueHandling.Ignore
            });
        }
    }

    //public static class HttpResponseHelpers
    //{
    //    private static async Task<string> ReadCompressedBodyAsync(this HttpRequest request)
    //    {

    //        try
    //        {
    //            request.Body.Seek(0, SeekOrigin.Begin);

    //            var gzipStream = new GZipStream(request.Body, CompressionMode.Decompress);
    //            StreamReader streamReader = new(gzipStream, leaveOpen: true);

    //            return await streamReader.ReadToEndAsync();
    //        }
    //        finally
    //        {
    //            request.Body.Seek(0, SeekOrigin.Begin);
    //        }

    //    }

    //    private static async Task<string> ReadUncompressedBodyAsync(this HttpRequest request)
    //    {
    //        try
    //        {
    //            request.Body.Seek(0, SeekOrigin.Begin);

    //            StreamReader streamReader = new StreamReader(request.Body, leaveOpen: true);

    //            return await streamReader.ReadToEndAsync();
    //        }
    //        finally
    //        {
    //            request.Body.Seek(0, SeekOrigin.Begin);
    //        }
    //    }

    //    public static async Task<string> ReadBodyAsync(this HttpRequest request)
    //    {
    //        request.EnableBuffering();

    //        try
    //        {
    //            if (request.Headers.ContentEncoding.Contains("gzip"))
    //            {
    //                return await ReadCompressedBodyAsync(request);
    //            }
    //            else
    //            {
    //                return await ReadUncompressedBodyAsync(request);
    //            }
    //        }
    //        catch (InvalidDataException)
    //        {
    //            return await ReadUncompressedBodyAsync(request);
    //        }
    //    }

    //    public static async Task<string> ReadBodyAsync(this HttpResponse response)
    //    {
    //        response.Body.Seek(0, SeekOrigin.Begin);

    //        StreamReader streamReader;
    //        if (response.Headers.ContentEncoding.Contains("gzip"))
    //        {
    //            var gzipStream = new GZipStream(response.Body, CompressionMode.Decompress);
    //            streamReader = new StreamReader(gzipStream);
    //        }
    //        else
    //        {
    //            streamReader = new StreamReader(response.Body);
    //        }

    //        var retval = await streamReader.ReadToEndAsync();

    //        response.Body.Seek(0, SeekOrigin.Begin);

    //        return retval;
    //    }
    //}

    //public static class MemoryStreamHelpers
    //{
    //    public static MemoryStream ToMemoryStream(this string data, HttpResponse response)
    //    {
    //        var retval = new MemoryStream();

    //        StreamWriter streamWriter;
    //        if (response.Headers.ContentEncoding.Contains("gzip"))
    //        {
    //            var gzipStream = new GZipStream(retval, CompressionMode.Compress);
    //            streamWriter = new StreamWriter(gzipStream);
    //        }
    //        else
    //        {
    //            streamWriter = new StreamWriter(retval);
    //        }

    //        streamWriter.Write(data);
    //        streamWriter.Flush();

    //        retval.Seek(0, SeekOrigin.Begin);

    //        return retval;
    //    }
    //}
}
