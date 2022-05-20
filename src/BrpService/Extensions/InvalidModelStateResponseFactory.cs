using Microsoft.AspNetCore.Mvc;

namespace HaalCentraal.BrpService.Extensions;

public static class InvalidModelStateResponseFactory
{
    public static IMvcBuilder ConfigureInvalidModelStateHandling(this IMvcBuilder builder)
    {
        return builder.ConfigureApiBehaviorOptions(options =>
        {
            options.InvalidModelStateResponseFactory = context => InvalidModelStateResponseFactory.CreateProblemDetails(context);
        });
    }

    private static IActionResult CreateProblemDetails(ActionContext context)
    {
        var invalidParams = (from kvp in context.ModelState
                             from error in kvp.Value.Errors
                            select new Generated.InvalidParams
                            {
                                Name = kvp.Key.ToLower(),
                                Code = error.ErrorMessage.Contains("||")
                                    ? error.ErrorMessage.Split("||")[0]
                                    : null,
                                Reason = error.ErrorMessage.Contains("||")
                                    ? error.ErrorMessage.Split("||")[1]
                                    : error.ErrorMessage
                            }).ToList();
        var titel = invalidParams.Any(x => x.Code == "required")
            ? "Minimale combinatie van parameters moet worden opgegeven."
            : "Een of meerdere parameters zijn niet correct.";
        var code = invalidParams.Any(x => x.Code == "required")
            ? "paramsCombination"
            : "paramsValidation";
        var foutbericht = new Generated.BadRequestFoutbericht
        {
            Instance = new Uri(context.HttpContext.Request.Path, UriKind.Relative),
            Status = StatusCodes.Status400BadRequest,
            Title = titel,
            Type = new Uri("https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest"),
            Code = code,
            InvalidParams = invalidParams,
            Detail = $"De foutieve parameter(s) zijn: {string.Join(", ", invalidParams.Select(x => x.Name))}."
        };

        return new BadRequestObjectResult(foutbericht)
        {
            ContentTypes = { "application/problem+json" }
        };
    }
}
