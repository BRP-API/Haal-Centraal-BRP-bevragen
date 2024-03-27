using Microsoft.AspNetCore.Http;

namespace Brp.Shared.Infrastructure.ProblemDetails;

public static class InternalServerErrorHandler
{
    public static async Task HandleInternalServerError(this HttpContext context)
    {
        var problemDetails = context.Request.CreateInternalServerErrorProblemDetails();

        context.Response.StatusCode = problemDetails.Status!.Value;

        await context.Response.WriteAsJsonAsync(
            problemDetails,
            System.Text.Json.JsonSerializerOptions.Default,
            ProblemDetailsHelpers.ProblemDetailsContentType);
    }

    public static Microsoft.AspNetCore.Mvc.ProblemDetails CreateInternalServerErrorProblemDetails(this HttpRequest request)
    {
        return new Microsoft.AspNetCore.Mvc.ProblemDetails
        {
            Instance = request.Path.ToUriComponent(),
            Status = StatusCodes.Status500InternalServerError,
            Title = "Internal Server error.",
            Type = StatusCodeIdentifiers.InternalServerErrorIdentifier
        };
    }
}
