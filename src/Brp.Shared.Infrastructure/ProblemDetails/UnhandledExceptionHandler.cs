using Microsoft.AspNetCore.Http;
using Serilog;

namespace Brp.Shared.Infrastructure.ProblemDetails;

public class UnhandledExceptionHandler
{
    private readonly RequestDelegate _next;
    private readonly IDiagnosticContext _diagnosticContext;

    public UnhandledExceptionHandler(RequestDelegate next, IDiagnosticContext diagnosticContext)
    {
        _next = next;
        _diagnosticContext = diagnosticContext;
    }

    public async Task Invoke(HttpContext httpContext)
    {
        try
        {
            await _next(httpContext);
        }
        catch (Exception ex)
        {
            _diagnosticContext.SetException(ex);

            httpContext.Response.StatusCode = StatusCodes.Status500InternalServerError;

            await httpContext.HandleInternalServerError();
        }
    }
}
