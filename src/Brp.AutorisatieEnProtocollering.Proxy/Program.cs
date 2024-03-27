using Brp.AutorisatieEnProtocollering.Proxy.Autorisatie;
using Brp.AutorisatieEnProtocollering.Proxy.Data;
using Brp.AutorisatieEnProtocollering.Proxy.Validatie;
using Brp.Shared.Infrastructure.Autorisatie;
using Brp.Shared.Infrastructure.HealthCheck;
using Brp.Shared.Infrastructure.Logging;
using Brp.Shared.Infrastructure.Utils;
using Brp.Shared.Infrastructure.Validatie;
using Microsoft.EntityFrameworkCore;
using Ocelot.DependencyInjection;
using Ocelot.Middleware;
using Serilog;

Log.Logger = SerilogHelpers.SetupSerilogBootstrapLogger();

try
{
    Log.Information($"Starting {AssemblyHelpers.Name} v{AssemblyHelpers.Version}. TimeZone: {TimeZoneInfo.Local.StandardName}. Now: {DateTime.Now}");

    var builder = WebApplication.CreateBuilder(args);

    builder.Services.AddHttpContextAccessor();

    builder.SetupSerilog(Log.Logger);

    builder.Configuration.AddJsonFile(Path.Combine("configuration", "ocelot.json"))
                         .AddJsonFile(Path.Combine("configuration", $"ocelot.{builder.Environment.EnvironmentName}.json"), true)
                         .AddEnvironmentVariables();

    builder.SetupAuthentication(Log.Logger);
    builder.Services.AddTransient<IAuthorisation, AuthorisationService>();
    builder.Services.AddTransient<IRequestBodyValidator, RequestBodyValidationService>();

    var dbSection = builder.Configuration.GetSection("Db");
    var connectionString = $"Host={dbSection["Host"]};Username={dbSection["Username"]};Password={dbSection["Password"]};Database={dbSection["Database"]}";

    builder.Services.AddDbContext<AppDbContext>(options => options.UseNpgsql(connectionString));

    builder.Services.AddOcelot();

    builder.Services.AddHealthChecks()
                    .AddNpgSql(connectionString, name: "Database")
                    .AddOcelotDownstreamEndpointCheck(builder.Configuration)
                    .AddIdentityServer(new Uri(builder.Configuration["OAuth:Authority"]), discoverConfigurationSegment: "nam/.well-known/openid-configuration", name: "IDP");

    var app = builder.Build();

    app.SetupSerilogRequestLogging();

    app.UseAuthentication();

    app.UseRouting();

    app.UseAuthorization();

    app.SetupHealthCheckEndpoints(builder.Configuration, Log.Logger);

    app.UseEndpoints(e => e.MapControllers());

    app.UseMiddleware<RequestValidatieMiddleware>();

    app.UseOcelot().Wait();

    app.Run();
}
catch(Exception ex)
{
    Log.Fatal(ex, $"{AssemblyHelpers.Name} terminated unexpectedly");
}
finally
{
    Log.CloseAndFlush();
}