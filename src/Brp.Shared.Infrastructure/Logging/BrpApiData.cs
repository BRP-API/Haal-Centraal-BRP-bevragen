using System.Runtime.Serialization;
using System.Text.Json.Serialization;

namespace Brp.Shared.Infrastructure.Logging;

public class BrpApiData
{
    public BrpApiData()
    {
    }

    public object? Autorisatie { get; set; }
    public object? Claims { get; set; }
    public object? Protocollering { get; set; }
    [JsonPropertyName("request.headers"), DataMember(Name = "request.headers")]
    public object? RequestHeaders { get; set; }
    [JsonPropertyName("request.body"), DataMember(Name = "request.body")]
    public object? RequestBody { get; set; }
    [JsonPropertyName("response.headers"), DataMember(Name = "response.headers")]
    public object? ResponseHeaders { get; set; }
    [JsonPropertyName("response.body"), DataMember(Name = "response.body")]
    public object? ResponseBody { get; set; }
    public object? Unauthorized { get; set; }
}
