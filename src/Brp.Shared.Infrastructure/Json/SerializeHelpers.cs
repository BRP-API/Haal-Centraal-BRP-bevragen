using Newtonsoft.Json;

namespace Brp.Shared.Infrastructure.Json;

public static class SerializeHelpers
{
    private static readonly JsonSerializerSettings CompactJsonSettings = new()
    {
        NullValueHandling = NullValueHandling.Ignore,
        DefaultValueHandling = DefaultValueHandling.Ignore,
    };

    public static string ToJson(this object obj) => JsonConvert.SerializeObject(obj);

    public static string ToJsonCompact(this object obj) => JsonConvert.SerializeObject(obj, CompactJsonSettings);
}
