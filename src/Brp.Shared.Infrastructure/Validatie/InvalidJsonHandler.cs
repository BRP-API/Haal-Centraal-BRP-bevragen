using Brp.Shared.Infrastructure.Http;
using Brp.Shared.Infrastructure.ProblemDetails;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Infrastructure.Validatie;

public static class InvalidJsonHandler
{
    public static async ValueTask<bool> HandleRequestBodyIsValidJson(this HttpContext context, string requestBody, IRequestBodyValidator requestBodyValidator)
    {
        try
        {
            // catch invalid JSON
            JObject.Parse(requestBody);

            var result = requestBodyValidator.ValidateRequestBody(requestBody);

            if (!result.IsValid)
            {
                var problemDetails = context.Request.CreateProblemDetailsFor(result);

                await context.Response.WriteProblemDetailsAsync(problemDetails);

                return false;
            }

            context.Items.Add("RequestBody", requestBody);
        }
        catch (JsonReaderException)
        {
            var problemDetails = context.Request.CreateProblemDetails(StatusCodes.Status400BadRequest, "De bevraging bevat een fout.", "Request body is geen geldige JSON.");

            await context.Response.WriteProblemDetailsAsync(problemDetails);

            return false;
        }

        return true;
    }
}
