using Brp.Shared.Infrastructure.Autorisatie;
using Brp.Shared.Infrastructure.Http;
using Brp.Shared.Infrastructure.Logging;
using Brp.Shared.Infrastructure.ProblemDetails;
using Microsoft.AspNetCore.Http;

namespace Brp.Shared.Infrastructure.Validatie;

public static class NotAuthorizedHandler
{
    public static async ValueTask<bool> HandleNotAuthorized(this HttpContext httpContext, AuthorisationResult authorisationResult)
    {
        if (authorisationResult.IsValid)
        {
            return true;
        }

        var reason = authorisationResult.Errors[0]?.Reason;
        if (!string.IsNullOrWhiteSpace(reason))
        {
            httpContext.GetAutorisatieLog().NietGeautoriseerd = reason;
        }

        var problemDetails = httpContext.Request.CreateProblemDetailsFor(authorisationResult);

        await httpContext.Response.WriteProblemDetailsAsync(problemDetails);

        return false;
    }
}
