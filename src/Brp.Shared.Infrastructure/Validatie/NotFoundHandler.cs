using Brp.Shared.Infrastructure.Http;
using Brp.Shared.Infrastructure.ProblemDetails;
using Microsoft.AspNetCore.Http;

namespace Brp.Shared.Infrastructure.Validatie;

public static class NotFoundHandler
{
    public static async ValueTask<bool> HandleNotFound(this HttpContext context)
    {
        if(context.Response.StatusCode == StatusCodes.Status404NotFound)
        {
            var problemDetails = context.Request.CreateProblemDetailsFor(StatusCodes.Status404NotFound);

            await context.Response.WriteProblemDetailsAsync(problemDetails);

            return false;
        }

        return true;
    }
}
