using Microsoft.Extensions.DependencyInjection;

namespace Brp.Shared.Infrastructure.ProblemDetails;

public static class ProblemDetailsHelpers
{
    public const string ProblemDetailsContentType = "application/problem+json";

    public static void SetupProblemDetails(this IServiceCollection services)
    {
    }
}
