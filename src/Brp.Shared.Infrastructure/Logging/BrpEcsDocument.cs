using Elastic.CommonSchema;
using Elastic.CommonSchema.Serialization;
using System.Runtime.Serialization;
using System.Text.Json.Serialization;

namespace Brp.Shared.Infrastructure.Logging;

[JsonConverter(typeof(EcsDocumentJsonConverterFactory))]
public class BrpEcsDocument : EcsDocument
{
    [JsonPropertyName("brp"), DataMember(Name = "brp")]
    public BrpApiData Brp { get; set; }

    public BrpEcsDocument()
    {
        Brp = new BrpApiData();
    }

    protected override bool TryRead(string propertyName, out Type? type)
    {
        type = propertyName switch
        {
            "brp" => typeof(BrpApiData),
            _ => null
        };

        return type != null;
    }

    protected override bool ReceiveProperty(string propertyName, object value)
    {
        return propertyName switch
        {
            "brp" => null != (Brp = value as BrpApiData),
            _ => false
        };
    }

    protected override void WriteAdditionalProperties(Action<string, object> write)
    {
        write("brp", Brp);
    }
}
