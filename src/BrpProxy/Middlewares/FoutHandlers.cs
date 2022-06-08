using HaalCentraal.BrpProxy.Generated;
using Newtonsoft.Json;
using System.Text.RegularExpressions;

namespace BrpProxy.Middlewares
{
    public static class FoutHandlers
    {
        private const string ProblemJsonContentType = "application/problem+json";

        private const string BadRequestIdentifier = "https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1";
        private const string MethodNotAllowedIdentifier = "https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.5";
        private const string NotAcceptableIdentifier = "https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.6";
        private const string InternalServerErrorIdentifier = "https://datatracker.ietf.org/doc/html/rfc7231#section-6.6.1";

        private static readonly Regex ConvertPropertyValueRegex = new(@"^Could not convert string to (?<code>.*):(.*). Path '(?<name>.*)'.$");
        private static readonly Regex RequiredPropertyRegex = new(@"^Required property '(?<name>.*)' expects a non-null value. Path ''.$");
        private static readonly Regex ConvertValueToCollectionRegex = new(@"^Error converting value ""(.*)"" to type '(.*)'. Path '(?<name>.*)'.$");

        private static Foutbericht CreateMethodNotAllowedFoutbericht(this HttpContext context)
        {
            return new Foutbericht
            {
                Status = StatusCodes.Status405MethodNotAllowed,
                Instance = new Uri(context.Request.Path, UriKind.Relative),
                Title = "Method not allowed.",
                Type = new Uri(MethodNotAllowedIdentifier)
            };
        }

        private static Foutbericht CreateNotAcceptableFoutbericht(this HttpContext context)
        {
            return new Foutbericht
            {
                Status = StatusCodes.Status406NotAcceptable,
                Instance = new Uri(context.Request.Path, UriKind.Relative),
                Title = "Gevraagde contenttype wordt niet ondersteund.",
                Type = new Uri(NotAcceptableIdentifier)
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
                if(new []{ "fields", "burgerservicenummer" }.Contains(name))
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

        private static BadRequestFoutbericht CreateJsonReaderExceptionFoutbericht(this HttpContext context, JsonReaderException ex)
        {
            var name = string.Empty;
            var code = string.Empty;
            var reason = string.Empty;

            var match = ConvertPropertyValueRegex.Match(ex.Message);
            if (match.Success)
            {
                name = match.Groups["name"].Value;
                code = match.Groups["code"].Value;
                reason = $"Waarde is geen {match.Groups["code"].Value}.";
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

        public static async Task<bool> MethodIsAllowed(this HttpContext context, Stream orgResponseBodyStream, ILogger logger)
        {
            if (context.Request.Method == HttpMethod.Post.Method) return true;

            logger.LogWarning("method not allowed: {@requestMethod}", context.Request.Method);

            var foutbericht = context.CreateMethodNotAllowedFoutbericht();

            using var bodyStream = foutbericht.ToJson().ToMemoryStream(context.Response);

            context.SetResponseProperties(foutbericht, bodyStream);

            await bodyStream.CopyToAsync(orgResponseBodyStream);

            return false;
        }

        public static async Task<bool> AcceptIsAllowed(this HttpContext context, Stream orgResponseBodyStream, ILogger logger)
        {
            if (context.Request.Headers.Accept[0].Contains("application/json")) return true;

            logger.LogWarning("Not supported Accept values: {@acceptHeader}", context.Request.Headers.Accept);

            var foutbericht = context.CreateNotAcceptableFoutbericht();

            using var bodyStream = foutbericht.ToJson().ToMemoryStream(context.Response);

            context.SetResponseProperties(foutbericht, bodyStream);

            await bodyStream.CopyToAsync(orgResponseBodyStream);

            return false;
        }

        public static async Task HandleJsonSerializationException(this HttpContext context, JsonSerializationException ex, Stream orgResponseBodyStream, ILogger logger)
        {
            var requestBody = await context.Request.ReadBodyAsync();

            logger.LogWarning("JsonSerializationException. {@requestBody} {@exception}", requestBody, ex);

            var foutbericht = context.CreateJsonSerializationExceptionFoutbericht(ex);

            using var bodyStream = foutbericht.ToJson().ToMemoryStream(context.Response);

            context.SetResponseProperties(foutbericht, bodyStream);

            await bodyStream.CopyToAsync(orgResponseBodyStream);
        }

        public static async Task HandleJsonReaderException(this HttpContext context, JsonReaderException ex, Stream orgResponseBodyStream, ILogger logger)
        {
            var requestBody = await context.Request.ReadBodyAsync();

            logger.LogWarning("JsonReaderException. {@requestBody} {@exception}", requestBody, ex);

            var foutbericht = context.CreateJsonReaderExceptionFoutbericht(ex);

            using var bodyStream = foutbericht.ToJson().ToMemoryStream(context.Response);

            context.SetResponseProperties(foutbericht, bodyStream);

            await bodyStream.CopyToAsync(orgResponseBodyStream);
        }

        public static async Task HandleValidationErrors(this HttpContext context, BadRequestFoutbericht foutbericht, Stream orgResponseBodyStream)
        {
            using var bodyStream = foutbericht.ToJson().ToMemoryStream(context.Response);

            context.SetResponseProperties(foutbericht, bodyStream);

            await bodyStream.CopyToAsync(orgResponseBodyStream);
        }

        public static async Task HandleUnhandledException(this HttpContext context, Exception ex, Stream orgResponseBodyStream)
        {
            var foutbericht = context.CreateInternalServerErrorFoutbericht();

            using var bodyStream = foutbericht.ToJson().ToMemoryStream(context.Response);

            context.SetResponseProperties(foutbericht, bodyStream);

            await bodyStream.CopyToAsync(orgResponseBodyStream);
        }
    }
}
