using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Logging;
using Microsoft.Extensions.Hosting;
using Brp.Shared.Infrastructure.Logging;

namespace Brp.Shared.Infrastructure.Autorisatie;

public static class SetupAuthenticationHelpers
{
    public static void SetupAuthentication(this WebApplicationBuilder builder, Serilog.ILogger logger)
    {
        if (builder.Environment.IsDevelopment())
        {
            IdentityModelEventSource.ShowPII = true;
        }

        var authority = builder.Configuration["OAuth:Authority"];
        if(string.IsNullOrWhiteSpace(authority))
        {
            throw new InvalidOperationException("Authority setting is niet gezet");
        }
        if (authority.StartsWith("http:"))
        {
            logger.Warning("Schema van authority url '{Authority}' is NIET https. RequireHttpsMetadata wordt gezet op false (Is dit een DEV omgeving?)", authority);
        }

        builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
            .AddJwtBearer(options =>
            {
                if (authority.StartsWith("http:"))
                {
                    options.RequireHttpsMetadata = false;
                }

                options.TokenValidationParameters.ValidateAudience = false;

                // signature van token wordt gevalideerd wanneer Authority wordt gevuld met de url van de IDP
                // key management (refreshen) wordt automatisch afgehandeld. Zie: https://zhiliaxu.github.io/how-do-aspnet-core-services-validate-jwt-signature-signed-by-aad.html#configuration
                options.Authority = authority;

                //options.TokenValidationParameters.ValidTypes = new[] { "jwt" };

                options.SetupJwtBearerEventsHandler();
            });
        builder.Services.AddTransient<IClaimsTransformation, RvIGClaimsTransformation>();
    }

    private static void SetupJwtBearerEventsHandler(this JwtBearerOptions options)
    {
        options.Events = new JwtBearerEvents
        {
            OnAuthenticationFailed = LogAuthenticationFailedReason,
            OnForbidden = LogAuthorizationFailed,
        };
    }

    private static Task LogAuthenticationFailedReason(AuthenticationFailedContext context)
    {
        context.HttpContext.GetAutorisatieLog().Exceptie = context.Exception;

        return Task.CompletedTask;
    }

    private static Task LogAuthorizationFailed(ForbiddenContext context)
    {
        context.HttpContext.GetAutorisatieLog().NietGeauthentiseerd = "Forbidden for unknown reason";

        return Task.CompletedTask;
    }
}
