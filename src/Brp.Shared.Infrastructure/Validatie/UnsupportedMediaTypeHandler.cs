using Brp.Shared.Infrastructure.Http;
using Brp.Shared.Infrastructure.ProblemDetails;
using Brp.Shared.Infrastructure.Text;
using Microsoft.AspNetCore.Http;

namespace Brp.Shared.Infrastructure.Validatie;

public static class UnsupportedMediaTypeHandler
{
    private static readonly List<string> SupportedMediaTypes = new()
    {
        "application/json",
        "application/json;charset=utf-8"
    };

    private static bool IsSupportedMediaType(this string? contentType) =>
        string.IsNullOrWhiteSpace(contentType) ||
        SupportedMediaTypes.Contains(contentType.ToLowerInvariant().RemoveAllWhitespace());

    public static async ValueTask<bool> HandleMediaTypeIsSupported(this HttpContext context)
    {
        foreach (var contentTypeValue in context.Request.Headers.ContentType)
        {
            if (!contentTypeValue.IsSupportedMediaType())
            {
                var problemDetails = context.Request.CreateProblemDetailsFor(StatusCodes.Status415UnsupportedMediaType);

                await context.Response.WriteProblemDetailsAsync(problemDetails);

                return false;
            }
        }

        return true;
    }
}
