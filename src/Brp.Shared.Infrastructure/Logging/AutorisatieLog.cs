using Microsoft.AspNetCore.Http;
using System.Runtime.Serialization;
using System.Text.Json.Serialization;

namespace Brp.Shared.Infrastructure.Logging;

public class AutorisatieLog
{
    [JsonPropertyName("gemeente"), DataMember(Name = "gemeente")]
    public string? Gemeente { get; set; } = null;
    [JsonPropertyName("regel"), DataMember(Name = "regel")]
    public object? Regel { get; set; } = null;
    [JsonPropertyName("niet_geautoriseerd"), DataMember(Name = "niet_geautoriseerd")]
    public string? NietGeautoriseerd { get; set; } = null;
    [JsonPropertyName("niet_geauthentiseerd"), DataMember(Name = "niet_geauthenticeerd")]
    public string? NietGeauthentiseerd { get; set; } = null;
    [JsonPropertyName("exceptie"), DataMember(Name = "exceptie")]
    public Exception? Exceptie { get; set; } = null;
    [JsonPropertyName("claims"), DataMember(Name = "claims")]
    public Dictionary<string, string>? Claims { get; set; } = null;
}

public static class AutorisatieLogHelpers
{
    public static AutorisatieLog GetAutorisatieLog(this HttpContext httpContext)
    {
        AutorisatieLog? autorisatieLog;
        if (httpContext.Items.ContainsKey(LogConstants.Autorisatie))
        {
            autorisatieLog = httpContext.Items[LogConstants.Autorisatie] as AutorisatieLog;
        }
        else
        {
            autorisatieLog = new AutorisatieLog();
            httpContext.Items.Add(LogConstants.Autorisatie, autorisatieLog);
        }

        return autorisatieLog!;
    }

}
