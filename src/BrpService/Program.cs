using Brp.Shared.Infrastructure.HealthCheck;
using Brp.Shared.Infrastructure.Logging;
using Brp.Shared.Infrastructure.Utils;
using BrpProxy.Middlewares;
using BrpProxy.Validators;
using FluentValidation;
using FluentValidation.AspNetCore;
using HaalCentraal.BrpService.Extensions;
using HaalCentraal.BrpService.Repositories;
using HaalCentraal.BrpService.Validators;
using Serilog;

Log.Logger = SerilogHelpers.SetupSerilogBootstrapLogger();

try
{
    Log.Information($"Starting {AssemblyHelpers.Name} v{AssemblyHelpers.Version}. TimeZone: {TimeZoneInfo.Local.StandardName}. Now: {DateTime.Now}");

    var builder = WebApplication.CreateBuilder(args);

    builder.Services.AddHttpContextAccessor();

    builder.SetupSerilog(Log.Logger);

    builder.Services.AddSingleton<FieldsHelper>();
    builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

    builder.Services.AddControllers()
                    .ConfigureInvalidModelStateHandling()
                    .AddNewtonsoftJson();

    builder.Services.AddScoped<PersoonRepository>();

    builder.Services.AddHealthChecks();

    var app = builder.Build();

    app.SetupSerilogRequestLogging();

    app.SetupHealthCheckEndpoints(builder.Configuration, Log.Logger);

    app.UseMiddleware<OverwriteResponseBodyMiddleware>();

    app.MapControllers();

    app.Run();
}
catch (Exception ex)
{
    Log.Fatal(ex, $"{AssemblyHelpers.Name} terminated unexpectedly");
}
finally
{
    Log.CloseAndFlush();
}
