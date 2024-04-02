using Brp.Shared.Infrastructure.Http;
using Brp.Shared.Infrastructure.ProblemDetails;
using Microsoft.AspNetCore.Http;

namespace Brp.Shared.Infrastructure.Validatie;

public static class MethodNotAllowedHandler
{
    public static async ValueTask<bool> HandleRequestMethodIsAllowed(this HttpContext context)
    {
        if (context.Request.Method == HttpMethod.Post.Method) return true;

        var problemDetails = context.Request.CreateProblemDetailsFor(StatusCodes.Status405MethodNotAllowed);

        await context.Response.WriteProblemDetailsAsync(problemDetails);

        return false;
    }
}
