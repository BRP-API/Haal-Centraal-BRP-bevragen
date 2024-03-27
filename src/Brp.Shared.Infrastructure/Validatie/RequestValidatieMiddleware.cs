using Brp.Shared.Infrastructure.Autorisatie;
using Brp.Shared.Infrastructure.Http;
using Brp.Shared.Infrastructure.ProblemDetails;
using Microsoft.AspNetCore.Http;
using Serilog;

namespace Brp.Shared.Infrastructure.Validatie;

public class RequestValidatieMiddleware
{
    private readonly RequestDelegate _next;
    private readonly IDiagnosticContext _diagnosticContext;
    private readonly IRequestBodyValidator _requestBodyValidator;
    private readonly IAuthorisation _authorisation;

    public RequestValidatieMiddleware(RequestDelegate next, IDiagnosticContext diagnosticContext, IRequestBodyValidator requestBodyValidator, IAuthorisation authorisation)
    {
        _next = next;
        _diagnosticContext = diagnosticContext;
        _authorisation = authorisation;
        _requestBodyValidator = requestBodyValidator;
    }

    public async Task Invoke(HttpContext httpContext)
    {
        if (!await httpContext.HandleNotAuthenticated(_diagnosticContext))
        {
            return;
        }

        if (!await httpContext.HandleRequestMethodIsAllowed(_diagnosticContext))
        {
            return;
        }

        if (!await httpContext.HandleRequestAcceptIsSupported(_diagnosticContext))
        {
            return;
        }

        if (!await httpContext.HandleMediaTypeIsSupported(_diagnosticContext))
        {
            return;
        }

        var requestBody = await httpContext.Request.ReadBodyAsync();

        if (!await httpContext.HandleRequestBodyIsValidJson(requestBody, _requestBodyValidator, _diagnosticContext))
        {
            return;
        }

        (int afnemerId, int? gemeenteCode) = GetClaimValues(httpContext);

        var result = _authorisation.Authorize(afnemerId, gemeenteCode, requestBody);
        if (!result.IsValid)
        {
            _diagnosticContext.Set("NotAuthorized", result.Errors[0].Reason);

            var problemDetails = httpContext.Request.CreateProblemDetailsFor(result);

            await httpContext.Response.WriteProblemDetailsAsync(problemDetails, _diagnosticContext);

            return;
        }

        await _next(httpContext);

        var geleverdePls = httpContext.Response.Headers["x-geleverde-pls"];
        if (!string.IsNullOrWhiteSpace(geleverdePls))
        {
            _authorisation.Protocolleer(afnemerId, geleverdePls!, requestBody);
        }
    }

    private static (int afnemerId, int? gemeenteCode) GetClaimValues(HttpContext httpContext)
    {
        var isValidAfnemerId = int.TryParse(httpContext.User.Claims.FirstOrDefault(c => c.Type == "afnemerID")?.Value, out int afnemerId);

        var isValidGemeenteCode = int.TryParse(httpContext.User.Claims.FirstOrDefault(c => c.Type == "gemeenteCode")?.Value, out int gemeenteCode);

        return (isValidAfnemerId ? afnemerId : 0,
                isValidGemeenteCode ? gemeenteCode : null);
    }
}
