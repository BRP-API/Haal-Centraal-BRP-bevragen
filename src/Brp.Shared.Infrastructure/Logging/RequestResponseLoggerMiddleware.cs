using Brp.Shared.Infrastructure.Http;
using Brp.Shared.Infrastructure.Stream;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using Serilog;

namespace Brp.Shared.Infrastructure.Logging;

/// <summary>
/// Middleware voor het uitlezen van de request- en response headers/body zodat deze kunnen worden toegevoegd aan de Elastic log
/// </summary>
internal class RequestResponseLoggerMiddleware
{
    private readonly RequestDelegate _next;
    private readonly IDiagnosticContext _diagnosticContext;

    public RequestResponseLoggerMiddleware(RequestDelegate next, IDiagnosticContext diagnosticContext)
    {
        _next = next;
        _diagnosticContext = diagnosticContext;
    }

    public async Task Invoke(HttpContext context)
    {
        context.Items.Add(MapToEcsKeys.EcsRequestContentType, context.Request.ContentType);
        _diagnosticContext.Set("RequestHeaders", context.Request.Headers);

        var requestBody = await context.Request.ReadBodyAsync();
        context.Items.Add(MapToEcsKeys.EcsRequestBody, requestBody);

        var orgBodyStream = context.Response.Body;

        using MemoryStream newBodyStream = new();
        context.Response.Body = newBodyStream;

        await _next(context);

        var responseBody = context.Response.Body.CanRead
            ? await context.Response.ReadBodyAsync()
            : await newBodyStream.ReadAsync(context.Response.UseGzip());

        if(context.Response.StatusCode >= StatusCodes.Status400BadRequest)
        {
            context.Items.Add(MapToEcsKeys.EcsResponseBody, responseBody);
        }

        using var bodyStream = responseBody.ToMemoryStream(context.Response.UseGzip());

        context.Response.ContentLength = bodyStream.Length;
        await bodyStream.CopyToAsync(orgBodyStream);
    }
}
