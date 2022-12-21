using FluentValidation.AspNetCore;
using HaalCentraal.BrpService.Extensions;
using HaalCentraal.BrpService.Repositories;
using HaalCentraal.BrpService.Validators;
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
        .WriteTo.Console(outputTemplate: "[{Timestamp:HH:mm:ss} {Level}] {SourceContext}{NewLine}{Message:lj}{NewLine}{Exception}{NewLine}",
                         theme: AnsiConsoleTheme.Code)
        .Enrich.WithExceptionDetails()
        .Enrich.FromLogContext()
        .Enrich.With<ActivityEnricher>()
        .WriteTo.Seq(context.Configuration["Seq:ServerUrl"]);
});
builder.Services.AddHttpLogging(options =>
{
    options.LoggingFields = Microsoft.AspNetCore.HttpLogging.HttpLoggingFields.All;
});

// Add services to the container.
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

builder.Services.AddControllers()
                .ConfigureInvalidModelStateHandling()
                .AddFluentValidation(options =>
                {
                    options.RegisterValidatorsFromAssemblyContaining<ZoekMetGeslachtsnaamEnGeboortedatumQueryValidator>();
                    options.DisableDataAnnotationsValidation = true;
                })
                .AddNewtonsoftJson();

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

//app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
