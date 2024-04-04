using HealthChecks.UI.Client;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Diagnostics.HealthChecks;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Brp.Shared.Infrastructure.HealthCheck;

public static class HealthCheckHelpers
{
    public static IHealthChecksBuilder AddOcelotDownstreamEndpointCheck(this IHealthChecksBuilder builder, ConfigurationManager configuration)
    {
        var downstreamPathTemplate = configuration["Routes:0:DownstreamPathTemplate"];
        var downstreamScheme = configuration["Routes:0:DownstreamScheme"];
        var downstreamHost = configuration["Routes:0:DownstreamHostAndPorts:0:Host"];
        var downstreamPort = configuration["Routes:0:DownstreamHostAndPorts:0:Port"];
        var downstreamEndpoint = new Uri($"{downstreamScheme}://{downstreamHost}:{downstreamPort}{downstreamPathTemplate}");

        return builder.AddUrlGroup(options =>
        {
            options.ExpectHttpCodes(400, 403);
            options.UsePost();
            options.AddUri(downstreamEndpoint, options =>
            {
                options.AddCustomHeader("x-healthcheck", "true");
            });
        }, name: $"Downstream endpoint: {downstreamEndpoint}");
    }

    public static void SetupHealthCheckEndpoints(this WebApplication app, ConfigurationManager configuration, Serilog.ILogger logger)
    {
        var healthBaseUrl = configuration["HealthEndpointBase"];

        var startupHealthEndpoint = $"{healthBaseUrl}/startup";
        logger.Information("Setup startup healthcheck endpoint: {StartupHealthEndpoint}", startupHealthEndpoint);
        app.MapHealthChecks(startupHealthEndpoint, new HealthCheckOptions
        {
            ResponseWriter = UIResponseWriter.WriteHealthCheckUIResponse
        });

        var readyHealthEndpoint = $"{healthBaseUrl}/ready";
        logger.Information("Setup ready healthcheck endpoint: {ReadyHealthEndpoint}", readyHealthEndpoint);
        app.MapHealthChecks(readyHealthEndpoint, new HealthCheckOptions
        {
            ResponseWriter = UIResponseWriter.WriteHealthCheckUIResponse
        });

        var liveHealthEndpoint = $"{healthBaseUrl}/live";
        logger.Information("Setup live healthcheck endpoint: {LiveHealthEndpoint}", liveHealthEndpoint);
        app.MapHealthChecks(liveHealthEndpoint, new HealthCheckOptions
        {
            ResponseWriter = UIResponseWriter.WriteHealthCheckUIResponse
        });
    }
}
