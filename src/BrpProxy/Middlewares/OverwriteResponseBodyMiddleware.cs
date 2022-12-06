using HaalCentraal.BrpProxy.Generated;
using Gba = HaalCentraal.BrpProxy.Generated.Gba;
using Newtonsoft.Json;
using System.IO.Compression;
using AutoMapper;
using System.Linq;
using BrpProxy.Validators;
using Newtonsoft.Json.Linq;

namespace BrpProxy.Middlewares
{
    public class OverwriteResponseBodyMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly IConfiguration _configuration;
        private readonly ILogger<OverwriteResponseBodyMiddleware> _logger;
        private readonly IMapper _mapper;
        private readonly FieldsHelper _fieldsHelper;

        public OverwriteResponseBodyMiddleware(RequestDelegate next, IConfiguration configuration, ILogger<OverwriteResponseBodyMiddleware> logger, IMapper mapper, FieldsHelper fieldsHelper)
        {
            _next = next;
            _configuration = configuration;
            _logger = logger;
            _mapper = mapper;
            _fieldsHelper = fieldsHelper;
        }

        public async Task Invoke(HttpContext context)
        {
            _logger.LogDebug("TimeZone: {@localTimeZone}. Now: {@now}", TimeZoneInfo.Local.StandardName, DateTime.Now);

            var orgBodyStream = context.Response.Body;
            string requestBody = string.Empty;
            try
            {
                _logger.LogDebug("request headers: {@requestHeaders}", context.Request.Headers);
                _logger.LogDebug("original requestBody: {@requestBody}", requestBody);

                if (! await context.MethodIsAllowed(orgBodyStream, _logger))
                {
                    return;
                }
                if(! await context.AcceptIsAllowed(orgBodyStream, _logger))
                {
                    return;
                }
                if(! await context.ContentTypeIsAllowed(orgBodyStream, _logger))
                {
                    return;
                }

                requestBody = await context.Request.ReadBodyAsync();

                PersonenQuery? personenQuery = null;

                try
                {
                    personenQuery = JsonConvert.DeserializeObject<PersonenQuery>(requestBody);

                    _logger.LogDebug("original deserialized requestBody: {@personenQuery}", personenQuery);
                }
                catch (JsonSerializationException ex)
                {
                    await context.HandleJsonSerializationException(ex, orgBodyStream, _logger);
                    return;
                }
                catch (JsonReaderException ex)
                {
                    await context.HandleJsonReaderException(ex, orgBodyStream, _logger);
                    return;
                }

                var result = personenQuery.Validate(context, requestBody, _fieldsHelper);
                if (!result.IsValid)
                {
                    await context.HandleValidationErrors(result.Foutbericht!, orgBodyStream, _logger);
                    return;
                }

                using var newBodyStream = new MemoryStream();
                context.Response.Body = newBodyStream;

                await _next(context);

                var body = await context.Response.ReadBodyAsync();

                _logger.LogDebug("original responseBody: {@body}", body);

                var resultFields = personenQuery is RaadpleegMetBurgerservicenummer
                            ? _fieldsHelper.AddExtraPersoonFields(result.Fields!)
                            : _fieldsHelper.AddExtraPersoonBeperktFields(result.Fields!);

                var modifiedBody = context.Response.StatusCode == StatusCodes.Status200OK
                    ? body.Transform(_mapper, resultFields, _logger)
                    : body;

                _logger.LogDebug("transformed responseBody: {@modifiedBody}", modifiedBody);

                using var bodyStream = modifiedBody.ToMemoryStream(context.Response);

                context.Response.ContentLength = bodyStream.Length;
                await bodyStream.CopyToAsync(orgBodyStream);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, message: "requestBody: {@requestBody}", requestBody);

                await context.HandleUnhandledException(ex, orgBodyStream);
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

        public static string Transform(this string payload, IMapper mapper, ICollection<string> fields, ILogger logger)
        {
            PersonenQueryResponse retval;
            var response = JsonConvert.DeserializeObject<Gba.PersonenQueryResponse>(payload);
            logger.LogDebug("Original response: {@response}", response);

            switch (response)
            {
                case Gba.RaadpleegMetBurgerservicenummerResponse p:
                    var result = mapper.Map<RaadpleegMetBurgerservicenummerResponse>(p);
                    logger.LogDebug("Before fields filtering {@result}", result);
                    foreach (var persoon in result.Personen)
                    {
                        if(persoon.Partners != null &&
                            persoon.Partners.Any(p => p.OntbindingHuwelijkPartnerschap == null))
                        {
                            persoon.Partners = (from partner in persoon.Partners
                                                where partner.OntbindingHuwelijkPartnerschap == null
                                                select partner).ToList();
                        }
                    }
                    result.Personen = result.Personen.FilterAfgevoerdePersoon().FilterList(fields);
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
                    logger.LogDebug("Before fields filtering {@result}", result2);
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

            logger.LogDebug("After fields filtering {@retval}", retval);
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

            StreamReader streamReader;
            if (response.Headers.ContentEncoding.Contains("gzip"))
            {
                var gzipStream = new GZipStream(response.Body, CompressionMode.Decompress);
                streamReader = new StreamReader(gzipStream);
            }
            else
            {
                streamReader = new StreamReader(response.Body);
            }

            var retval = await streamReader.ReadToEndAsync();

            response.Body.Seek(0, SeekOrigin.Begin);

            return retval;
        }
    }

    public static class MemoryStreamHelpers
    {
        public static MemoryStream ToMemoryStream(this string data, HttpResponse response)
        {
            var retval = new MemoryStream();

            StreamWriter streamWriter;
            if (response.Headers.ContentEncoding.Contains("gzip"))
            {
                var gzipStream = new GZipStream(retval, CompressionMode.Compress);
                streamWriter = new StreamWriter(gzipStream);
            }
            else
            {
                streamWriter = new StreamWriter(retval);
            }

            streamWriter.Write(data);
            streamWriter.Flush();

            retval.Seek(0, SeekOrigin.Begin);

            return retval;
        }
    }
}
