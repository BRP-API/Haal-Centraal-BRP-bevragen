using Brp.Shared.Infrastructure.Http;
using Brp.Shared.Infrastructure.ProblemDetails;
using Microsoft.AspNetCore.Http;
using Serilog;

namespace Brp.Shared.Infrastructure.Validatie;

public static class UnauthenticatedHandler
{
    public static async ValueTask<bool> HandleNotAuthenticated(this HttpContext context, IDiagnosticContext diagnosticContext)
    {
        if (context.User.Identity == null || !context.User.Identity.IsAuthenticated)
        {
            if (context.Items["AuthenticationFailedException"] is Exception notAuthenticatedException)
            {
                diagnosticContext.Set("NotAuthorized", notAuthenticatedException.Message);
            }
            if (context.Items["Forbidden"] is string forbiddenReason)
            {
                diagnosticContext.Set("NotAuthorized", forbiddenReason);
            }
            if (!context.Request.Headers.ContainsKey("Authorization"))
            {
                diagnosticContext.Set("NotAuthorized", "no authorization header");
            }

            var problemDetails = context.Request.CreateProblemDetailsFor(StatusCodes.Status401Unauthorized);

            await context.Response.WriteProblemDetailsAsync(problemDetails);

            return false;
        }

        return true;
    }
}
