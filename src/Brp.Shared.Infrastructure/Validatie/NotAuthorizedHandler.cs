using Brp.Shared.Infrastructure.Autorisatie;
using Brp.Shared.Infrastructure.Http;
using Brp.Shared.Infrastructure.ProblemDetails;
using Microsoft.AspNetCore.Http;
using Serilog;

namespace Brp.Shared.Infrastructure.Validatie;

public static class NotAuthorizedHandler
{
    public static async ValueTask<bool> HandleNotAuthorized(this HttpContext httpContext, AuthorisationResult authorisationResult, IDiagnosticContext diagnosticContext)
    {
        if (authorisationResult.IsValid)
        {
            return true;
        }

        var reason = authorisationResult.Errors[0]?.Reason;
        if (!string.IsNullOrWhiteSpace(reason))
        {
            diagnosticContext.Set("NotAuthorized", reason);
        }

        var problemDetails = httpContext.Request.CreateProblemDetailsFor(authorisationResult);

        await httpContext.Response.WriteProblemDetailsAsync(problemDetails);

        return false;
    }
}
