using Newtonsoft.Json;

namespace HaalCentraal.BrpProxy.Generated;

public partial class NaamBasis : INaam
{
    [JsonIgnore]
    public IWaardetabel? Geslacht { get; set; }
}
