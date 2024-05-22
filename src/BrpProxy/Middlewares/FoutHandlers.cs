using Brp.Shared.Infrastructure.Http;
using Brp.Shared.Infrastructure.Stream;
using HaalCentraal.BrpProxy.Generated;
using Newtonsoft.Json;
using Serilog;
using System.Text.RegularExpressions;

namespace BrpProxy.Middlewares
{
    public static class FoutHandlers
    {
        private const string ProblemJsonContentType = "application/problem+json";

        private const string BadRequestIdentifier = "https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1";
        private const string NotFoundIdentifier = "https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.4";
        private const string InternalServerErrorIdentifier = "https://datatracker.ietf.org/doc/html/rfc7231#section-6.6.1";

        private static readonly Regex ConvertPropertyValueRegex = new(@"^Could not convert string to (?<code>.*):(.*). Path '(?<name>.*)'.$", RegexOptions.None, TimeSpan.FromMilliseconds(100));
        private static readonly Regex RequiredPropertyRegex = new(@"^Required property '(?<name>.*)' expects a non-null value. Path ''.$", RegexOptions.None, TimeSpan.FromMilliseconds(100));
        private static readonly Regex ConvertValueToCollectionRegex = new(@"^Error converting value ""(.*)"" to type '(.*)'. Path '(?<name>.*)'.$", RegexOptions.None, TimeSpan.FromMilliseconds(100));

        private static Foutbericht CreateNotFoundFoutbericht(this HttpContext context)
        {
            return new Foutbericht
            {
                Status = StatusCodes.Status404NotFound,
                Instance = new Uri(context.Request.Path, UriKind.Relative),
                Title = "Opgevraagde resource bestaat niet.",
                Type = new Uri(NotFoundIdentifier)
            };
        }


        private static Foutbericht CreateInternalServerErrorFoutbericht(this HttpContext context)
        {
            return new Foutbericht
            {
                Status = StatusCodes.Status500InternalServerError,
                Instance = new Uri(context.Request.Path, UriKind.Relative),
                Title = "Internal Server error.",
                Type = new Uri(InternalServerErrorIdentifier)
            };
        }

        private static BadRequestFoutbericht CreateJsonSerializationExceptionFoutbericht(this HttpContext context, JsonSerializationException ex)
        {
            var name = string.Empty;
            var code = string.Empty;
            var reason = string.Empty;

            var match = ConvertValueToCollectionRegex.Match(ex.Message);
            if (match.Success)
            {
                name = match.Groups["name"].Value;
                if (new[] { "fields", "burgerservicenummer" }.Contains(name))
                {
                    code = "array";
                    reason = "Parameter is geen array.";
                }
            }
            match = RequiredPropertyRegex.Match(ex.Message);
            if (match.Success)
            {
                name = match.Groups["name"].Value;
                if (name == "inclusiefOverledenPersonen")
                {
                    code = "boolean";
                    reason = "Waarde is geen boolean.";
                }
                else
                {
                    code = "required";
                    reason = "Parameter is verplicht.";
                }
            }

            return new BadRequestFoutbericht
            {
                Instance = new Uri(context.Request.Path, UriKind.Relative),
                Status = StatusCodes.Status400BadRequest,
                Title = "Een of meerdere parameters zijn niet correct.",
                Type = new Uri(BadRequestIdentifier),
                Code = "paramsValidation",
                Detail = $"De foutieve parameter(s) zijn: {name}.",
                InvalidParams = new List<InvalidParams>
                    {
                        new InvalidParams
                        {
                            Code = code,
                            Name = name,
                            Reason = reason
                        }
                    }
            };
        }

        private static BadRequestFoutbericht CreateJsonReaderExceptionFoutbericht(this HttpContext context, JsonReaderException? ex)
        {
            var name = string.Empty;
            var code = string.Empty;
            var reason = string.Empty;

            var match = ConvertPropertyValueRegex.Match(ex != null ? ex.Message : string.Empty);
            if (match.Success)
            {
                name = match.Groups["name"].Value;
                code = match.Groups["code"].Value;
                reason = $"Waarde is geen {match.Groups["code"].Value}.";
            }

            var retval = new BadRequestFoutbericht
            {
                Instance = new Uri(context.Request.Path, UriKind.Relative),
                Status = StatusCodes.Status400BadRequest,
                Title = "Een of meerdere parameters zijn niet correct.",
                Type = new Uri(BadRequestIdentifier),
                Code = "paramsValidation",
                Detail = $"De foutieve parameter(s) zijn: {name}."
            };
            if (!string.IsNullOrEmpty(name) ||
                !string.IsNullOrEmpty(code) ||
                !string.IsNullOrEmpty(reason))
            {
                retval.InvalidParams = new List<InvalidParams>
                        {
                            new InvalidParams
                            {
                                Code = code,
                                Name = name,
                                Reason = reason
                            }
                        };
            }
            return retval;
        }

        public static BadRequestFoutbericht CreateBadRequestFoutbericht(this HttpContext context, string titel, string code, IEnumerable<InvalidParams> invalidParams)
        {
            return new BadRequestFoutbericht
            {
                Instance = new Uri(context.Request.Path, UriKind.Relative),
                Status = StatusCodes.Status400BadRequest,
                Title = titel,
                Type = new Uri(BadRequestIdentifier),
                Code = code,
                Detail = $"De foutieve parameter(s) zijn: {string.Join(", ", invalidParams.Select(x => x.Name))}.",
                InvalidParams = new List<InvalidParams>(invalidParams)
            };
        }

        private static void SetResponseProperties(this HttpContext context, Foutbericht foutbericht, Stream bodyStream)
        {
            context.Response.StatusCode = foutbericht.Status!.Value;
            context.Response.ContentLength = bodyStream.Length;
            context.Response.ContentType = ProblemJsonContentType;
        }

        public static async Task<bool> HandleNotFound(this HttpContext context, Stream orgResponseBodyStream, IDiagnosticContext diagnosticContext)
        {
            var foutbericht = context.CreateNotFoundFoutbericht();

            diagnosticContext.Set("ResponseBody", foutbericht, true);

            using var bodyStream = foutbericht.ToJson().ToMemoryStream(context.Response.UseGzip());

            context.SetResponseProperties(foutbericht, bodyStream);

            await bodyStream.CopyToAsync(orgResponseBodyStream);

            return false;
        }

        public static async Task<bool> RequestBodyIsValid(this HttpContext context, string requestBody, Stream orgResponseBodyStream, IDiagnosticContext diagnosticContext)
        {
            if (!string.IsNullOrWhiteSpace(requestBody))
            {
                return true;
            }

            var foutbericht = context.CreateJsonReaderExceptionFoutbericht(null);

            diagnosticContext.Set("ResponseBody", foutbericht, true);

            using var bodyStream = foutbericht.ToJson().ToMemoryStream(context.Response.UseGzip());

            context.SetResponseProperties(foutbericht, bodyStream);

            await bodyStream.CopyToAsync(orgResponseBodyStream);

            return false;
        }

        public static async Task HandleJsonSerializationException(this HttpContext context, JsonSerializationException ex, Stream orgResponseBodyStream, IDiagnosticContext diagnosticContext)
        {
            diagnosticContext.SetException(ex);

            var foutbericht = context.CreateJsonSerializationExceptionFoutbericht(ex);

            diagnosticContext.Set("ResponseBody", foutbericht, true);

            using var bodyStream = foutbericht.ToJson().ToMemoryStream(context.Response.UseGzip());

            context.SetResponseProperties(foutbericht, bodyStream);

            await bodyStream.CopyToAsync(orgResponseBodyStream);
        }

        public static async Task HandleJsonReaderException(this HttpContext context, JsonReaderException ex, Stream orgResponseBodyStream, IDiagnosticContext diagnosticContext)
        {
            diagnosticContext.SetException(ex);

            var foutbericht = context.CreateJsonReaderExceptionFoutbericht(ex);

            diagnosticContext.Set("ResponseBody", foutbericht, true);

            using var bodyStream = foutbericht.ToJson().ToMemoryStream(context.Response.UseGzip());

            context.SetResponseProperties(foutbericht, bodyStream);

            await bodyStream.CopyToAsync(orgResponseBodyStream);
        }

        public static async Task HandleValidationErrors(this HttpContext context, BadRequestFoutbericht foutbericht, Stream orgResponseBodyStream, IDiagnosticContext diagnosticContext)
        {
            diagnosticContext.Set("ResponseBody", foutbericht, true);

            using var bodyStream = foutbericht.ToJson().ToMemoryStream(context.Response.UseGzip());

            context.SetResponseProperties(foutbericht, bodyStream);

            await bodyStream.CopyToAsync(orgResponseBodyStream);
        }

        public static async Task HandleUnhandledException(this HttpContext context, string requestBody, Exception ex, Stream orgResponseBodyStream, IDiagnosticContext diagnosticContext)
        {

            var foutbericht = context.CreateInternalServerErrorFoutbericht();
            using var bodyStream = foutbericht.ToJson().ToMemoryStream(context.Response.UseGzip());

            context.SetResponseProperties(foutbericht, bodyStream);

            await bodyStream.CopyToAsync(orgResponseBodyStream);
        }
    }
}
