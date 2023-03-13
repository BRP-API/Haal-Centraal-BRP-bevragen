using FluentValidation;
using FluentValidation.AspNetCore;
using HaalCentraal.BrpService.Extensions;
using HaalCentraal.BrpService.Repositories;
using HaalCentraal.BrpService.Validators;
using OpenTelemetry.Resources;
using OpenTelemetry.Trace;
using Serilog;
using Serilog.Enrichers.Span;
using Serilog.Exceptions;
using Serilog.Sinks.SystemConsole.Themes;

var builder = WebApplication.CreateBuilder(args);

builder.Logging.ClearProviders();
builder.Host.UseSerilog((context, config) =>
{
    config
        .ReadFrom.Configuration(context.Configuration)
        .Enrich.WithExceptionDetails()
        .Enrich.FromLogContext()
        .Enrich.With<ActivityEnricher>()
        .WriteTo.Console(outputTemplate: "[{Timestamp:HH:mm:ss} {Level}] {SourceContext}{NewLine}{Message:lj}{NewLine}{Exception}{NewLine}",
                         theme: AnsiConsoleTheme.Code)
        .WriteTo.Seq(context.Configuration["Seq:ServerUrl"]);
});
builder.Services.AddHttpLogging(options =>
{
    options.LoggingFields = Microsoft.AspNetCore.HttpLogging.HttpLoggingFields.All;
});

builder.Services.AddOpenTelemetry().WithTracing(b =>
{
    b.AddConsoleExporter()
        .AddSource(builder.Environment.ApplicationName)
        .SetResourceBuilder(ResourceBuilder.CreateDefault()
                                            .AddService(builder.Environment.ApplicationName))
        .AddHttpClientInstrumentation(options =>
        {
            options.EnrichWithHttpResponseMessage = async (activity, httpResponseMessage) =>
            {
                var body = await httpResponseMessage.Content.ReadAsStringAsync();

                activity.SetTag("body", body);
            };
            options.RecordException = true;
        })
        .AddAspNetCoreInstrumentation()
        .AddOtlpExporter(opts =>
        {
            opts.Endpoint = new Uri(builder.Configuration["Jaeger:OtlpEndpoint"]);
        });
});

var idpSection = builder.Configuration.GetSection("idp");
if (idpSection.Exists())
{
    builder.Services.AddAuthentication("Bearer")
        .AddJwtBearer("Bearer", options =>
        {
            options.Authority = builder.Configuration["Idp:Authority"];
            options.Audience = builder.Configuration["Idp:Audience"];
        })
        .AddOAuth2Introspection("introspection", options =>
        {
            options.Authority = builder.Configuration["Idp:Authority"];
            options.ClientId = builder.Configuration["Idp:Introspection:ClientId"];
            options.ClientSecret = builder.Configuration["Idp:Introspection:ClientSecret"];
        });
}


// Add services to the container.
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

builder.Services.AddControllers()
                .ConfigureInvalidModelStateHandling()
                .AddNewtonsoftJson();
builder.Services.AddFluentValidationAutoValidation(options => options.DisableDataAnnotationsValidation = true)
                .AddValidatorsFromAssemblyContaining<ZoekMetGeslachtsnaamEnGeboortedatumQueryValidator>();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddScoped<PersoonRepository>();

var app = builder.Build();

// Configure the HTTP request pipeline.
app.UseHttpLogging();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

if (idpSection.Exists())
{
    app.UseAuthentication();
    app.UseAuthorization();

    app.MapControllers().RequireAuthorization();
}
else
{
    app.MapControllers();
}

app.Run();
