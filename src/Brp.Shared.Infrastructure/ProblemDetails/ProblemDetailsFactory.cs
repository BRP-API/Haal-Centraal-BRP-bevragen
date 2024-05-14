using Brp.Shared.Infrastructure.Autorisatie;
using Microsoft.AspNetCore.Http;
using System.Text;

namespace Brp.Shared.Infrastructure.ProblemDetails;

public static class ProblemDetailsFactory
{
    private static KeyValuePair<string, object?>? ToProblemDetailsCode(this int statusCode) =>
        statusCode switch
        {
            StatusCodes.Status400BadRequest => new KeyValuePair<string, object?>("code", "paramsValidation"),
            StatusCodes.Status401Unauthorized => new KeyValuePair<string, object?>("code", "authentication"),
            StatusCodes.Status403Forbidden => new KeyValuePair<string, object?>("code", "unauthorized"),
            StatusCodes.Status405MethodNotAllowed => new KeyValuePair<string, object?>("code", "methodNotAllowed"),
            StatusCodes.Status406NotAcceptable => new KeyValuePair<string, object?>("code", "notAcceptable"),
            StatusCodes.Status415UnsupportedMediaType => new KeyValuePair<string, object?>("code", "unsupportedMediaType"),
            _ => null
        };

    private static string? ToProblemDetailsDetail(this int statusCode, string? paramNames = null) =>
        statusCode switch
        {
            StatusCodes.Status400BadRequest => $"De foutieve parameter(s) zijn: {paramNames}.",
            StatusCodes.Status406NotAcceptable => "Ondersteunde content type: application/json; charset=utf-8.",
            StatusCodes.Status415UnsupportedMediaType => "Ondersteunde content type: application/json; charset=utf-8.",
            _ => null
        };

    private static string? ToProblemDetailsTitle(this int statusCode) =>
        statusCode switch
        {
            StatusCodes.Status400BadRequest => "Een of meerdere parameters zijn niet correct.",
            StatusCodes.Status401Unauthorized => "Niet correct geauthenticeerd.",
            StatusCodes.Status403Forbidden => "U bent niet geautoriseerd voor het gebruik van deze API.",
            StatusCodes.Status404NotFound => "Opgevraagde resource bestaat niet.",
            StatusCodes.Status405MethodNotAllowed => "Gebruikte bevragingsmethode is niet toegestaan.",
            StatusCodes.Status406NotAcceptable => "Gevraagde content type wordt niet ondersteund.",
            StatusCodes.Status415UnsupportedMediaType => "Media Type wordt niet ondersteund.",
            StatusCodes.Status500InternalServerError => "Internal Server error.",
            StatusCodes.Status502BadGateway => "Bronservice is tijdelijk niet beschikbaar.",
            _ => null
        };

    private static string? ToStatusCodeIdentifier(this int statusCode) =>
        statusCode switch
        {
            StatusCodes.Status400BadRequest => StatusCodeIdentifiers.BadRequestIdentifier,
            StatusCodes.Status401Unauthorized => StatusCodeIdentifiers.UnauthorizedIdentifier,
            StatusCodes.Status403Forbidden => StatusCodeIdentifiers.ForbiddenIdentifier,
            StatusCodes.Status404NotFound => StatusCodeIdentifiers.NotFoundIdentifier,
            StatusCodes.Status405MethodNotAllowed => StatusCodeIdentifiers.MethodNotAllowedIdentifier,
            StatusCodes.Status406NotAcceptable => StatusCodeIdentifiers.NotAcceptableIdentifier,
            StatusCodes.Status415UnsupportedMediaType => StatusCodeIdentifiers.UnsupportedMediaTypeIdentifier,
            StatusCodes.Status500InternalServerError => StatusCodeIdentifiers.InternalServerErrorIdentifier,
            StatusCodes.Status502BadGateway => StatusCodeIdentifiers.ServiceUnavailableIdentifier,
            _ => null
        };

    public static Microsoft.AspNetCore.Mvc.ProblemDetails CreateProblemDetails(this HttpRequest request, int statusCode, string title, string detail)
    {
        return new Microsoft.AspNetCore.Mvc.ProblemDetails
        {
            Detail = detail,
            Instance = request.Path.ToUriComponent(),
            Status = statusCode,
            Title = title,
            Type = statusCode.ToStatusCodeIdentifier()
        };
    }

    public static Microsoft.AspNetCore.Mvc.ProblemDetails CreateProblemDetailsFor(this HttpRequest request, int statusCode, string? paramNames = null, object[]? invalidParams = null)
    {
        Microsoft.AspNetCore.Mvc.ProblemDetails retval = new()
        {
            Detail = statusCode.ToProblemDetailsDetail(paramNames),
            Instance = request.Path.ToUriComponent(),
            Status = statusCode,
            Title = statusCode.ToProblemDetailsTitle(),
            Type = statusCode.ToStatusCodeIdentifier()
        };

        var problemDetailsCode = statusCode.ToProblemDetailsCode();
        if (problemDetailsCode.HasValue)
        {
            retval.Extensions.Add(problemDetailsCode.Value);
        }
        if (invalidParams != null)
        {
            retval.Extensions.Add("invalidParams", invalidParams);
        }

        return retval;
    }

    public static Microsoft.AspNetCore.Mvc.ProblemDetails CreateProblemDetailsFor(this HttpRequest request, string name, string code, string reason)
    {
        var invalidParam = new
        {
            name,
            code,
            reason
        };

        return request.CreateProblemDetailsFor(StatusCodes.Status400BadRequest, name, new object[] { invalidParam });
    }

    public static Microsoft.AspNetCore.Mvc.ProblemDetails CreateProblemDetailsFor(this HttpRequest request, FluentValidation.Results.ValidationResult validationResult)
    {
        StringBuilder names = new();
        var invalidParams = new List<object>();

        foreach (var error in validationResult.Errors)
        {
            var invalidParam = CreateFrom(error);
            if (!invalidParam.HasValue)
            {
                continue;
            }

            (string code, string name, string reason) = invalidParam.Value;

            if (names.Length > 0)
            {
                names.Append(", ");
            }
            names.Append(name);

            invalidParams.Add(new { name, code, reason });
        }

        return request.CreateProblemDetailsFor(StatusCodes.Status400BadRequest, names.ToString(), invalidParams.ToArray());
    }

    private static (string code, string name, string reason)? CreateFrom(FluentValidation.Results.ValidationFailure validationFailure)
    {
        var messageParts = validationFailure.ErrorMessage.Split("||");

        return messageParts.Length switch
        {
            2 =>
            (
                messageParts[0],
                $"{char.ToLowerInvariant(validationFailure.PropertyName[0])}{validationFailure.PropertyName[1..]}",
                messageParts[1]
            ),
            3 => (messageParts[1], messageParts[0], messageParts[2]),
            _ => null
        };
    }

    public static Microsoft.AspNetCore.Mvc.ProblemDetails CreateProblemDetailsFor(this HttpRequest request, AuthorisationResult result)
    {
        Microsoft.AspNetCore.Mvc.ProblemDetails retval = new()
        {
            Detail = result.Errors[0].Detail,
            Instance = request.Path.ToUriComponent(),
            Status = StatusCodes.Status403Forbidden,
            Title = result.Errors[0].Title,
            Type = StatusCodes.Status403Forbidden.ToStatusCodeIdentifier()
        };

        retval.Extensions.Add(new KeyValuePair<string, object?>("code", result.Errors[0].Code));

        return retval;
    }
}
