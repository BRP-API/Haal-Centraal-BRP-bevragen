using Brp.Shared.Infrastructure.Http;
using Brp.Shared.Infrastructure.ProblemDetails;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Serilog;
using System.Text.RegularExpressions;

namespace Brp.Shared.Infrastructure.Validatie;

public static class InvalidJsonHandler
{
    private static readonly Regex NotValidClosingForArrayRegex = new(@"JsonToken EndObject is not valid for closing JsonType Array. Path '(?<name>.*)'");
    private static readonly Regex NotValidClosingForObjectRegex = new(@"JsonToken EndArray is not valid for closing JsonType Object. Path '(?<name>.*)'");
    private static readonly Regex UnterminatedStringRegex = new(@"Unterminated string. Expected delimiter: \"". Path '(?<name>.*)'");
    private static readonly Regex UnexpectedCharacterEncounteredWhileParsing = new(@"Unexpected character encountered while parsing (value|number): (.*). Path '(?<name>.*)'");
    private static readonly Regex UnexpectedCharacterEncounteredAfterParsingRegex = new(@"After parsing a value an unexpected character was encountered: (.*). Path '(?<name>.*)'");

    private static (string name, string code, string reason) Parse(this Exception ex)
    {
        var match = NotValidClosingForArrayRegex.Match(ex.Message);
        if (match.Success)
        {
            return (match.Groups["name"].Value, string.Empty, "Parameter is geen array");
        }
        match = NotValidClosingForObjectRegex.Match(ex.Message);
        if (match.Success)
        {
            return (match.Groups["name"].Value, string.Empty, "Parameter is geen array");
        }
        match = UnterminatedStringRegex.Match(ex.Message);
        if (match.Success)
        {
            return (match.Groups["name"].Value, string.Empty, "waarde is niet valide");
        }
        match = UnexpectedCharacterEncounteredWhileParsing.Match(ex.Message);
        if (match.Success)
        {
            return (match.Groups["name"].Value, string.Empty, "waarde is niet valide");
        }
        match = UnexpectedCharacterEncounteredAfterParsingRegex.Match(ex.Message);
        if (match.Success)
        {
            return (match.Groups["name"].Value, string.Empty, "waarde is niet valide");
        }

        return (string.Empty, string.Empty, string.Empty);
    }

    private static bool AreNullOrWhiteSpace(string? name, string? code, string? reason) =>
        string.IsNullOrWhiteSpace(name) &&
        string.IsNullOrWhiteSpace(code) &&
        string.IsNullOrWhiteSpace(reason);

    public static async ValueTask<bool> HandleRequestBodyIsValidJson(this HttpContext context, string requestBody, IRequestBodyValidator requestBodyValidator, IDiagnosticContext diagnosticContext)
    {
        try
        {
            // catch invalid JSON
            JObject.Parse(requestBody);

            var result = requestBodyValidator.ValidateRequestBody(requestBody);

            if (!result.IsValid)
            {
                var problemDetails = context.Request.CreateProblemDetailsFor(result);

                await context.Response.WriteProblemDetailsAsync(problemDetails, diagnosticContext);

                return false;
            }
        }
        catch(JsonReaderException ex)
        {
            (string name, string code, string reason) = ex.Parse();

            if(AreNullOrWhiteSpace(name, code, reason))
            {
                diagnosticContext.SetException(ex);
            }

            var problemDetails = context.Request.CreateProblemDetailsFor(name, code, reason);

            await context.Response.WriteProblemDetailsAsync(problemDetails, diagnosticContext);

            return false;
        }

        return true;
    }
}
