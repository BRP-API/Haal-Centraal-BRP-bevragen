using Brp.Shared.Infrastructure.Http;
using Brp.Shared.Infrastructure.ProblemDetails;
using Microsoft.AspNetCore.Http;

namespace Brp.Shared.Infrastructure.Validatie;

public static class UnauthenticatedHandler
{
    public static async ValueTask<bool> HandleNotAuthenticated(this HttpContext context)
    {
        if (context.User.Identity == null || !context.User.Identity.IsAuthenticated)
        {
            if (context.Items["AuthenticationFailedException"] is Exception notAuthenticatedException)
            {
                context.Items.Add("Autorisatie", notAuthenticatedException.Message);
            }
            if (context.Items["Forbidden"] is string forbiddenReason)
            {
                context.Items.Add("Autorisatie", forbiddenReason);
            }
            if (!context.Request.Headers.ContainsKey("Authorization"))
            {
                context.Items.Add("Autorisatie", "geen Authorization header");
            }

            var problemDetails = context.Request.CreateProblemDetailsFor(StatusCodes.Status401Unauthorized);

            await context.Response.WriteProblemDetailsAsync(problemDetails);

            return false;
        }

        return true;
    }
}
