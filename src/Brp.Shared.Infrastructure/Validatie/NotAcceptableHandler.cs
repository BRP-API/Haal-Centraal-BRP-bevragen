using Brp.Shared.Infrastructure.Http;
using Brp.Shared.Infrastructure.ProblemDetails;
using Brp.Shared.Infrastructure.Text;
using Microsoft.AspNetCore.Http;

namespace Brp.Shared.Infrastructure.Validatie;

public static class NotAcceptableHandler
{
    private static readonly List<string> SupportedAcceptValues = new()
    {
        "*/*",
        "*/*;charset=utf-8",
        "application/json",
        "application/json;charset=utf-8"
    };

    private static bool IsSupportedAcceptValue(this string? acceptValue) =>
        string.IsNullOrWhiteSpace(acceptValue) ||
        SupportedAcceptValues.Contains(acceptValue.ToLowerInvariant().RemoveAllWhitespace());

    public static async ValueTask<bool> HandleRequestAcceptIsSupported(this HttpContext context)
    {
        foreach (var acceptValue in context.Request.Headers.Accept)
        {
            if (!acceptValue.IsSupportedAcceptValue())
            {
                var problemDetails = context.Request.CreateProblemDetailsFor(StatusCodes.Status406NotAcceptable);

                await context.Response.WriteProblemDetailsAsync(problemDetails);

                return false;
            }
        }

        return true;
    }
}
