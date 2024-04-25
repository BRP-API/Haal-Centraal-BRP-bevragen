using Brp.Shared.Infrastructure.Http;
using Brp.Shared.Infrastructure.ProblemDetails;
using Microsoft.AspNetCore.Http;

namespace Brp.Shared.Infrastructure.Validatie;

public static class ServiceUnavailableHandler
{
    public static async ValueTask<bool> HandleServiceIsAvailable(this HttpContext context)
    {
        if(context.Response.StatusCode == StatusCodes.Status502BadGateway)
        {
            var problemDetails = context.Request.CreateProblemDetailsFor(StatusCodes.Status502BadGateway);

            await context.Response.WriteProblemDetailsAsync(problemDetails);

            return false;
        }

        return true;
    }
}
