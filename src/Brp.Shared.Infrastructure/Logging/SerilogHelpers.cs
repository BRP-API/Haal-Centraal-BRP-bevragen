using Brp.Shared.Infrastructure.Json;
using Destructurama;
using Elastic.CommonSchema;
using Elastic.CommonSchema.Serilog;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json.Linq;
using Serilog;
using Serilog.Enrichers.Sensitive;
using Serilog.Events;
using Serilog.Exceptions;
using System.Text;

namespace Brp.Shared.Infrastructure.Logging;

public static class SerilogHelpers
{
    /// <summary>
    /// Setup stage 1 van Serilog's [two-stage initialization](https://github.com/serilog/serilog-aspnetcore#two-stage-initialization)
    /// </summary>
    /// <returns>Serilog.ILogger</returns>
    public static Serilog.ILogger SetupSerilogBootstrapLogger()
    {
        return new LoggerConfiguration()
            .MinimumLevel.Override("Microsoft", Serilog.Events.LogEventLevel.Information)
            .Enrich.FromLogContext()
            .WriteTo.Console()
            .CreateBootstrapLogger();
    }

    /// <summary>
    /// Setup stage 2 van Serilog's [two-stage initialization](https://github.com/serilog/serilog-aspnetcore#two-stage-initialization)
    /// 
    /// Voeg de aanroep 'builder.Services.AddHttpContextAccessor();' toe vóór de aanroep van 'SetupSerilog' zodat de HttpContext instance kan worden uitgelezen voor het genereren van de request log
    /// 
    /// Afhankelijk van settings worden log regels weggeschreven naar de volgende log providers/sinks
    /// - Console als in appSettings.json de LogLevel voor Serilog op Debug is gezet (Serilog:MinimumLevel:Override:Serilog)
    /// - Seq als in appSettings.json de url naar een Seq server is opgegeven (Seq:ServerUrl)
    /// - File in Elastic Common Schema formaat als in appSettings.json het pad naar een log bestand is opgegeven (Ecs:Path)
    /// </summary>
    /// <param name="builder"></param>
    /// <param name="logger"></param>
    public static void SetupSerilog(this WebApplicationBuilder builder, Serilog.ILogger logger)
    {
        builder.Logging.ClearProviders();

        builder.Host.UseSerilog(Configure(logger));
    }

    /// <summary>
    /// Setup Serilog HTTP request logging als vervanging van ASP.NET Core default request logging
    /// Configureert ook de benodigde middleware voor het uitlezen van de request- en response body
    /// </summary>
    /// <param name="app"></param>
    public static void SetupSerilogRequestLogging(this WebApplication app)
    {
        app.UseSerilogRequestLogging(options =>
        {
            options.GetLevel = GetLogEventLevel;
            options.EnrichDiagnosticContext = EnrichDiagnosticContext;
        });

        app.UseMiddleware<RequestResponseLoggerMiddleware>();
    }

    /// <summary>
    /// Configureert de Log Level van een request log aan de hand van de HTTP status code.
    /// 
    /// |HTTP status code | Log Level   |
    /// |>= 500           | Error       |
    /// |>= 400 en < 500  | Warning     |
    /// |< 400            | Information |
    /// </summary>
    /// <param name="httpContext"></param>
    /// <param name="_"></param>
    /// <param name="exception"></param>
    /// <returns></returns>
    private static LogEventLevel GetLogEventLevel(HttpContext httpContext, double _, Exception? exception)
    {
        var isHealthCheckRequest = httpContext.Request.Headers.ContainsKey("x-healthcheck");
        return exception != null
            ? LogEventLevel.Error
            : httpContext.Response switch
            {
                { StatusCode: var status } when status >= 500 => LogEventLevel.Error,
                { StatusCode: var status } when status >= 400 && status < 500 && !isHealthCheckRequest => LogEventLevel.Warning,
                { StatusCode: var status } when status >= 400 && status < 500 && isHealthCheckRequest => LogEventLevel.Verbose,
                _ => httpContext.LogEventLevelIfHealthCheckEndpoint()
            };
    }

    private static LogEventLevel LogEventLevelIfHealthCheckEndpoint(this HttpContext httpContext) =>
        httpContext.IsHealthCheckEndpoint()
            ? LogEventLevel.Verbose
            : LogEventLevel.Information;

    private static bool IsHealthCheckEndpoint(this HttpContext httpContext)
    {
        var endpoint = httpContext.GetEndpoint();
        return endpoint is not null && string.Equals(endpoint.DisplayName, "Health checks", StringComparison.Ordinal);
    }

    private static void EnrichDiagnosticContext(IDiagnosticContext diagnosticContext, HttpContext httpContext)
    {
        diagnosticContext.Set(MapToEcsKeys.EcsResponseContentType, httpContext.Response.ContentType);
        httpContext.MapToDiagnosticContext(diagnosticContext);
    }

    private static Action<HostBuilderContext, IServiceProvider, LoggerConfiguration> Configure(Serilog.ILogger logger)
    {
        return (context, serviceProvider, config) =>
        {
            var maskProperties = context.Configuration.GetSection("SensitiveProperties").Get<string[]>() ?? Array.Empty<string>();

            config
                .ReadFrom.Configuration(context.Configuration)
                .SetMinimumLevelOverrides()
                .Destructure.UsingAttributes(x => x.IgnoreNullProperties = true)
                .Destructure.JsonNetTypes()
                .Enrich.FromLogContext()
                .Enrich.WithExceptionDetails()
                ;

            context.ConfigureConsoleLogging(config, logger);
            context.ConfigureElasticLogging(serviceProvider, config, maskProperties, logger);
            context.ConfigureSeqLogging(config, logger);
        };
    }

    private static LoggerConfiguration SetMinimumLevelOverrides(this LoggerConfiguration config)
    {
        // uitzetten van logging van de ASP.NET Core ExceptionHandlerMiddleware
        config.MinimumLevel.Override("Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddleware", LogEventLevel.Fatal);

        return config;
    }

    private static bool LogLevelIsDebug(this HostBuilderContext context)
    {
        var serilogLogLevel = context.Configuration["Serilog:MinimumLevel:Override:Serilog"];

        return !string.IsNullOrWhiteSpace(serilogLogLevel) && serilogLogLevel == "Debug";
    }

    private const string ConsoleLogTemplate = "[{Timestamp:HH:mm:ss} {Level}] {SourceContext}{NewLine}{Message:lj}{NewLine}{Exception}{NewLine}";

    private static void ConfigureConsoleLogging(this HostBuilderContext context, LoggerConfiguration config, Serilog.ILogger logger)
    {
        var logLevelIsDebug = context.LogLevelIsDebug();
        if (!context.HostingEnvironment.IsDevelopment() && !logLevelIsDebug)
        {
            return;
        }

        StringBuilder sb = new();
        if (context.HostingEnvironment.IsDevelopment())
        {
            sb.Append("Hosting Environment: Development");
        }
        if (logLevelIsDebug)
        {
            if (sb.Length > 0) { sb.Append(", "); }
            sb.Append("Log level: Debug");
        }

        logger.Information("Enable debug console logging. {Reasons}", sb);
        config.WriteTo.Console(outputTemplate: ConsoleLogTemplate, theme: Serilog.Sinks.SystemConsole.Themes.AnsiConsoleTheme.Code);
    }

    private static void ConfigureSeqLogging(this HostBuilderContext context, LoggerConfiguration config, Serilog.ILogger logger)
    {
        var seqServerUrl = context.Configuration["Seq:ServerUrl"];
        if (string.IsNullOrWhiteSpace(seqServerUrl))
        {
            return;
        }

        logger.Information("Enable logging to Seq. Server url: {ServerUrl}", seqServerUrl);
        config.WriteTo.Seq(serverUrl: seqServerUrl);
    }

    private static EcsTextFormatter<EcsDocument> ConfigureLoggingWithEcsTextFormatter(this LoggerConfiguration config, IServiceProvider serviceProvider)
    {
        var httpContextAccessor = serviceProvider.GetRequiredService<IHttpContextAccessor>();
        config.Enrich.WithEcsHttpContext(httpContextAccessor);

        EcsTextFormatterConfiguration<EcsDocument> ecsTextFormatterConfig = new ()
        {
            MapCustom = (ecs, logEvent) =>
            {
                httpContextAccessor?.HttpContext?.MapHttpContextItemToEcsHttpProperty(MapToEcsKeys.EcsRequestContentType, ecs);

                return ecs;
            }
        };

        return new EcsTextFormatter<EcsDocument>(ecsTextFormatterConfig);
    }

    private static EcsTextFormatter<EcsDocument> ConfigureSecuredLoggingWithEcsTextFormatter(this LoggerConfiguration config, IServiceProvider serviceProvider)
    {
        var httpContextAccessor = serviceProvider.GetRequiredService<IHttpContextAccessor>();
        config.Enrich.WithEcsHttpContext(httpContextAccessor);

        EcsTextFormatterConfiguration<EcsDocument> ecsTextFormatterConfig = new()
        {
            MapCustom = (ecs, logEvent) =>
            {
                httpContextAccessor?.HttpContext?.MapHttpContextItemToEcsHttpProperty(MapToEcsKeys.EcsRequestContentType, ecs);
                // Secured logging -> log request en response body tbv naspelen
                httpContextAccessor?.HttpContext?.MapHttpContextItemToEcsHttpProperty(MapToEcsKeys.EcsRequestBody, ecs);
                httpContextAccessor?.HttpContext?.MapHttpContextItemToEcsHttpProperty(MapToEcsKeys.EcsResponseBody, ecs);

                return ecs;
            }
        };

        return new EcsTextFormatter<EcsDocument>(ecsTextFormatterConfig);
    }

    private static void MapHttpContextItemToEcsHttpProperty(this HttpContext httpContext, string key, EcsDocument ecs)
    {
        if (httpContext.Items[key] is not string val)
        {
            return;
        }

        ecs.Http ??= new Elastic.CommonSchema.Http();
        switch (key)
        {
            case MapToEcsKeys.EcsRequestContentType:
                ecs.Http.RequestMimeType = val;
                break;
            case MapToEcsKeys.EcsRequestBody:
                ecs.Http.RequestBodyContent = val;
                break;
            case MapToEcsKeys.EcsResponseBody:
                ecs.Http.ResponseBodyContent = val;
                break;
            default:
                break;

        }
    }

    private static void MapToDiagnosticContext(this HttpContext httpContext, IDiagnosticContext diagnosticContext)
    {
        foreach (var item in httpContext.Items)
        {
            var key = item.Key.ToString();
            switch (key)
            {
                case LogConstants.Autorisatie:
                case LogConstants.RequestHeaders:
                case LogConstants.ResponseHeaders:
                    diagnosticContext.Set(key, JObject.Parse(item.Value!.ToJsonCompact()), true);
                    break;
                case MapToEcsKeys.EcsRequestBody:
                case MapToEcsKeys.EcsResponseBody:
                    var val = item.Value as string;
                    if (!string.IsNullOrWhiteSpace(val))
                    {
                        // remove 'ecs.' from property name
                        diagnosticContext.Set(key[4..], JObject.Parse(val!), true);
                    }
                    break;
                case LogConstants.Protocollering:
                    diagnosticContext.Set(key, item.Value, true);
                    break;
                default:
                    break;
            }
        }
    }

    private static void ConfigureElasticLogging(this HostBuilderContext context, IServiceProvider serviceProvider, LoggerConfiguration config, IEnumerable<string> maskProperties, Serilog.ILogger logger)
    {
        var ecsPath = context.Configuration["Ecs:Path"];
        var ecsSecuredPath = context.Configuration["Ecs:SecuredPath"];
        if (string.IsNullOrWhiteSpace(ecsPath) && string.IsNullOrWhiteSpace(ecsSecuredPath))
        {
            logger.Information("No Path & SecuredPath setting provided. No file logging");
            return;
        }
        if(!long.TryParse(context.Configuration["Ecs:FileSizeLimitBytes"], out long fileSizeLimitBytes))
        {
            logger.Information("No/Invalid FileSizeLimitBytes provided. Default to 1 GB");
            fileSizeLimitBytes = 1024 * 1024 * 1024; // 1 GB
        }
        if (!int.TryParse(context.Configuration["Ecs:RetainedFileCountLimit"], out int retainedFileCountLimit))
        {
            logger.Information("No/Invalid RetainedFileCountLimit provided. Default to 10");
            retainedFileCountLimit = 10;
        }

        if (!string.IsNullOrWhiteSpace(ecsPath))
        {
            logger.Information("Enable file logging using Elasticsearch Common Schema format. Path: {Path}, size limit: {FileSizeLimitBytes}, retained file count limit: {RetainedFileCountLimit}", ecsPath, fileSizeLimitBytes, retainedFileCountLimit);

            config
                .WriteTo.Logger(lc => lc
                    .Enrich.WithSensitiveDataMasking(options =>
                    {
                        options.MaskingOperators.Clear();
                        options.MaskProperties.AddRange(maskProperties);
                    })
                    .WriteTo.PersistentFile(
                        formatter: config.ConfigureLoggingWithEcsTextFormatter(serviceProvider),
                        path: ecsPath,
                        fileSizeLimitBytes: fileSizeLimitBytes,
                        rollOnFileSizeLimit: true,
                        retainedFileCountLimit: retainedFileCountLimit,
                        preserveLogFilename: true,
                        shared: true
                    )
                );
        }
        if (!string.IsNullOrWhiteSpace(ecsSecuredPath))
        {
            logger.Information("Enable secured file logging using Elasticsearch Common Schema format. Path: {Path}, size limit: {FileSizeLimitBytes}, retained file count limit: {RetainedFileCountLimit}", ecsSecuredPath, fileSizeLimitBytes, retainedFileCountLimit);

            config
                .WriteTo.Logger(lc => lc
                    .WriteTo.PersistentFile(
                        formatter: config.ConfigureSecuredLoggingWithEcsTextFormatter(serviceProvider),
                        path: ecsSecuredPath,
                        fileSizeLimitBytes: fileSizeLimitBytes,
                        rollOnFileSizeLimit: true,
                        retainedFileCountLimit: retainedFileCountLimit,
                        preserveLogFilename: true,
                        shared: true
                    )
                );
        }
    }
}
