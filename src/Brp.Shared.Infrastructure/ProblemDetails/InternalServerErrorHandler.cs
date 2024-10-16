using Brp.Shared.Infrastructure.Http;
using Microsoft.AspNetCore.Http;

namespace Brp.Shared.Infrastructure.ProblemDetails;

public static class InternalServerErrorHandler
{
    public static async Task HandleInternalServerError(this HttpContext context)
    {
        var problemDetails = context.Request.CreateProblemDetailsFor(StatusCodes.Status500InternalServerError);

        context.Response.Clear();

        await context.Response.WriteProblemDetailsAsync(problemDetails);
    }
}
