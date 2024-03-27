using Brp.Shared.Infrastructure.Http;
using Brp.Shared.Infrastructure.ProblemDetails;
using Microsoft.AspNetCore.Http;
using Serilog;

namespace Brp.Shared.Infrastructure.Validatie;

public static class MethodNotAllowedHandler
{
    public static async ValueTask<bool> HandleRequestMethodIsAllowed(this HttpContext context, IDiagnosticContext diagnosticContext)
    {
        if (context.Request.Method == HttpMethod.Post.Method) return true;

        var problemDetails = context.Request.CreateProblemDetailsFor(StatusCodes.Status405MethodNotAllowed);

        await context.Response.WriteProblemDetailsAsync(problemDetails, diagnosticContext);

        return false;
    }
}
