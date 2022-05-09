using HaalCentraal.BrpProxy.Generated;
using Gba = HaalCentraal.BrpProxy.Generated.Gba;
using Newtonsoft.Json;
using System.IO.Compression;
using AutoMapper;
using System.Linq;
using BrpProxy.Validators;
using FluentValidation.Results;
using Newtonsoft.Json.Linq;

namespace BrpProxy.Middlewares
{
    public class OverwriteResponseBodyMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<OverwriteResponseBodyMiddleware> _logger;
        private readonly IMapper _mapper;
        private readonly FieldsHelper _fieldsHelper;

        public OverwriteResponseBodyMiddleware(RequestDelegate next, ILogger<OverwriteResponseBodyMiddleware> logger, IMapper mapper, FieldsHelper fieldsHelper)
        {
            _next = next;
            _logger = logger;
            _mapper = mapper;
            _fieldsHelper = fieldsHelper;
        }

        public async Task Invoke(HttpContext context)
        {
            var orgBodyStream = context.Response.Body;
            string requestBody = string.Empty;
            try
            {
                requestBody = await context.Request.ReadBodyAsync();

                _logger.LogDebug("original requestBody: {@requestBody}", requestBody);
                var personenQuery = JsonConvert.DeserializeObject<PersonenQuery>(requestBody);
                _logger.LogDebug("original requestBody: {@personenQuery}", personenQuery);
                var result = personenQuery.Validate(context, requestBody, _fieldsHelper);
                if (!result.IsValid)
                {
                    using var bodyStream = JsonConvert.SerializeObject(result.Foutbericht).ToMemoryStream();

                    context.Response.StatusCode = StatusCodes.Status400BadRequest;
                    context.Response.ContentLength = bodyStream.Length;
                    await bodyStream.CopyToAsync(orgBodyStream);
                }
                else
                {
                    personenQuery!.Fields = personenQuery.Fields!.Split(',').MapFields();
                    var modifiedRequestBody = JsonConvert.SerializeObject(personenQuery);
                    using var requestBodyStream = modifiedRequestBody.ToMemoryStream();
                    context.Request.Body = requestBodyStream;

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

                    _logger.LogDebug("transformed responseBody: {modifiedBody}", modifiedBody);

                    using var bodyStream = modifiedBody.ToMemoryStream();

                    context.Response.ContentLength = bodyStream.Length;
                    await bodyStream.CopyToAsync(orgBodyStream);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, message: $"requestBody: {requestBody}");

                using var bodyStream = JsonConvert.SerializeObject(new Foutbericht
                {
                    Status = StatusCodes.Status500InternalServerError,
                    //Detail = ex.Message,
                    Instance = new Uri(context.Request.Path, UriKind.Relative),
                    Title = "Internal Server error.",
                    Type = new Uri("https://datatracker.ietf.org/doc/html/rfc7231#section-6.6.1")
                }).ToMemoryStream();

                context.Response.StatusCode = StatusCodes.Status500InternalServerError;
                context.Response.ContentLength = bodyStream.Length;
                await bodyStream.CopyToAsync(orgBodyStream);
            }
        }
    }

    public class ValidatePersonenQueryResult
    {
        public static ValidatePersonenQueryResult CreateFrom(ValidationResult result, string? fields, HttpContext context)
        {
            if (result.IsValid)
            {
                return new ValidatePersonenQueryResult(fields!.Split(','));
            }

            var invalidParams = from error in result.Errors
                                select new InvalidParams
                                {
                                    Name = "fields",
                                    Code = error.ErrorMessage.Split("||")[0],
                                    Reason = error.ErrorMessage.Split("||")[1]
                                };
            var titel = invalidParams.Any(x => x.Code == "required")
                ? "Minimale combinatie van parameters moet worden opgegeven."
                : "Een of meerdere parameters zijn niet correct.";
            var code = invalidParams.Any(x => x.Code == "required")
                ? "paramsCombination"
                : "paramsValidation";

            return new ValidatePersonenQueryResult(new BadRequestFoutbericht
            {
                Instance = new Uri(context.Request.Path, UriKind.Relative),
                Status = StatusCodes.Status400BadRequest,
                Title = titel,
                Type = new Uri("https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest"),
                Code = code,
                Detail = $"De foutieve parameter(s) zijn: {string.Join(", ", invalidParams.Select(x => x.Name))}.",
                InvalidParams = new List<InvalidParams>(invalidParams)
            });
        }

        public static ValidatePersonenQueryResult CreateFrom(ValidationResult result, HttpContext context)
        {
            var invalidParams = from error in result.Errors
                                select new InvalidParams
                                {
                                    Name = "type",
                                    Code = error.ErrorMessage.Split("||")[0],
                                    Reason = error.ErrorMessage.Split("||")[1]
                                };
            var titel = invalidParams.Any(x => x.Code == "required")
                ? "Minimale combinatie van parameters moet worden opgegeven."
                : "Een of meerdere parameters zijn niet correct.";
            var code = invalidParams.Any(x => x.Code == "required")
                ? "paramsCombination"
                : "paramsValidation";

            return new ValidatePersonenQueryResult(new BadRequestFoutbericht
            {
                Instance = new Uri(context.Request.Path, UriKind.Relative),
                Status = StatusCodes.Status400BadRequest,
                Title = titel,
                Type = new Uri("https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest"),
                Code = code,
                Detail = $"De foutieve parameter(s) zijn: {string.Join(", ", invalidParams.Select(x => x.Name))}.",
                InvalidParams = new List<InvalidParams>(invalidParams)
            });
        }

        private ValidatePersonenQueryResult(string[] fields)
        {
            IsValid = true;
            Fields = fields;
        }

        private ValidatePersonenQueryResult(BadRequestFoutbericht foutbericht)
        {
            IsValid = false;
            Foutbericht = foutbericht;
        }

        public bool IsValid { get; }
        public ICollection<string>? Fields { get; }
        public BadRequestFoutbericht? Foutbericht { get; }
    }

    public static class BrpHelpers
    {
        private static readonly Dictionary<string, string[]> fieldsMapping = new()
        {
            { "naam", new[] { "naam", "geslachtsaanduiding", "partners.naam" } },
            { "naam.voorletters", new[] { "naam.voornamen" } },
            { "volledigeNaam", new[] { "naam" } },
            { "naam.volledigeNaam", new[] { "naam" } },
            { "aanhef", new[] { "naam", "geslachtsaanduiding", "partners.naam" } },
            { "aanschrijfwijze", new[] { "naam", "geslachtsaanduiding", "partners.naam" } },
            { "aanschrijfwijze.naam", new[] { "naam", "geslachtsaanduiding", "partners.naam" } },
            { "aanschrijfwijze.aanspreekvorm", new[] { "naam.adellijkeTitelPredicaat", "aanduidingNaamgebruik", "geslachtsaanduiding" } },
            { "gebruikInLopendeTekst", new[] { "naam", "geslachtsaanduiding", "partners.naam" } },
            { "leeftijd", new[] { "geboorte.datum" } },
            { "ouders.geslachtsaanduiding", new[] { "ouders.geslachtsaanduiding,ouders.naam.geslachtsnaam" } },
            { "ouders.naam.voorletters", new[] { "ouders.naam.voornamen" } },
            { "nationaliteiten.nationaliteit", new[] { "nationaliteit" } },
            { "nationaliteiten.type", new[] { "nationaliteit", "aanduidingBijzonderNederlanderschap" } },
            { "aangaanHuwelijkPartnerschap", new[] { "aangaanHuwelijkPartnerschap", "partners.naam.geslachtsnaam" } },
            { "partners.aangaanHuwelijkPartnerschap", new[] { "partners.aangaanHuwelijkPartnerschap", "partners.naam.geslachtsnaam" } },
            { "partners.naam.voorletters", new[] { "partners.naam.voornamen" } },
            { "kinderen.naam.voorletters", new[] { "kinderen.naam.voornamen" } },
            { "indicatieOverleden", new[] { "overlijden.datum" } },
            { "overlijden.indicatieOverleden", new[] { "overlijden.datum" } },
            { "verblijfplaats.datumVan", new[] { "datumAanvangAdreshouding", "datumAanvangAdresBuitenland" } },
            { "korteNaam", new[] { "straat" } },
            { "straat", new[] { "straat", "naamOpenbareRuimte" } },
            { "woonplaats", new[] { "woonplaats", "gemeenteVanInschrijving" } },
            { "adresregel1", new[] { "adresregel1", "straat", "locatiebeschrijving", "huisnummer", "huisletter", "huisnummertoevoeging", "aanduidingBijHuisnummer" } },
            { "adresregel2", new[] { "adresregel2", "postcode", "woonplaats", "gemeenteVanInschrijving" } },
            { "vanuitVerblijfplaatsOnbekend", new[] { "landVanwaarIngeschreven" } },
            { "indicatieVestigingVanuitBuitenland", new[] { "datumVestigingInNederland" } }
        };

        public static ValidatePersonenQueryResult Validate(this PersonenQuery? personenQuery, HttpContext context, string requestBody, FieldsHelper fieldsHelper)
        {
            var result = personenQuery switch
            {
                RaadpleegMetBurgerservicenummer query => new RaadpleegMetBurgerservicenummerQueryValidator(fieldsHelper).Validate(query),
                ZoekMetGeslachtsnaamEnGeboortedatum query => new ZoekMetGeslachtsnaamEnGeboortedatumQueryValidator(fieldsHelper).Validate(query),
                ZoekMetPostcodeEnHuisnummer query => new ZoekMetPostcodeEnHuisnummerQueryValidator(fieldsHelper).Validate(query),
                ZoekMetNaamEnGemeenteVanInschrijving query => new ZoekMetNaamEnGemeenteVanInschrijvingQueryValidator(fieldsHelper).Validate(query),
                _ => null
            };

            return result != null
                ? ValidatePersonenQueryResult.CreateFrom(result, personenQuery?.Fields, context)
                : ValidatePersonenQueryResult.CreateFrom(new PersonenQueryRequestBodyValidator().Validate(JObject.Parse(requestBody)), context);
        }

        public static string MapFields(this string[] fields)
        {
            List<string> retval = new();
            foreach (var field in fields)
            {
                if(fieldsMapping.ContainsKey(field))
                {
                    retval.AddRange(fieldsMapping[field]);
                }
                else
                {
                    retval.Add(field);
                }
            }

            return string.Join(',', retval.Distinct());
        }

        public static string Transform(this string payload, IMapper mapper, ICollection<string> fields, ILogger logger)
        {
            PersonenQueryResponse retval = null;
            var response = JsonConvert.DeserializeObject<Gba.PersonenQueryResponse>(payload);

            switch (response)
            {
                case Gba.RaadpleegMetBurgerservicenummerResponse p:
                    var result = mapper.Map<RaadpleegMetBurgerservicenummerResponse>(p);
                    logger.LogDebug("Before fields filtering {@result}", result);
                    result.Personen = (from persoon in result.Personen.FilterList(fields)
                                      where persoon.ShouldSerialize()
                                      select persoon).ToList();
                    retval = result;
                    break;
                case Gba.ZoekMetGeslachtsnaamEnGeboortedatumResponse pb:
                    var result1 = mapper.Map<ZoekMetGeslachtsnaamEnGeboortedatumResponse>(pb);
                    result1.Personen = result1.Personen.FilterList(fields);
                    retval = result1;
                    break;
                case Gba.ZoekMetNaamEnGemeenteVanInschrijvingResponse pb:
                    var result3 = mapper.Map<ZoekMetNaamEnGemeenteVanInschrijvingResponse>(pb);
                    result3.Personen = result3.Personen.FilterList(fields);
                    retval = result3;
                    break;
                case Gba.ZoekMetPostcodeEnHuisnummerResponse pb:
                    var result2 = mapper.Map<ZoekMetPostcodeEnHuisnummerResponse>(pb);
                    result2.Personen = result2.Personen.FilterList(fields);
                    retval = result2;
                    break;
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
