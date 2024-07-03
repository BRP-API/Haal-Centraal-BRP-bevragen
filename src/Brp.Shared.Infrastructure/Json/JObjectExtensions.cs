using Newtonsoft.Json.Linq;

namespace Brp.Shared.Infrastructure.Json;

public static class JObjectExtensions
{
    public static Dictionary<string, object?> ToDictionary(this JObject jObject)
    {
        Dictionary<string, object?> retval = new();

        foreach (var property in jObject.Properties())
        {
            retval[property.Name] = property.Value.Type switch
            {
                JTokenType.String => property.Value.ToString(),
                JTokenType.Object => property.Value.ToObject<object>(),
                JTokenType.Array => property.Value.ElementAt(0).Type == JTokenType.Object
                            ? (from JObject prop in property.Value
                               select prop.ToDictionary())
                            : (from JToken prop in property.Value
                               select prop.Value<string>()),
                _ => property.Value.ToObject<object>() ?? ""
            };
        }

        return retval;
    }
}
