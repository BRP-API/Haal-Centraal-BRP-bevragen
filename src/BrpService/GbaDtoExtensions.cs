using Newtonsoft.Json;

namespace HaalCentraal.BrpService.Generated
{
    public partial class GbaGeboorteBeperkt
    {
        [JsonIgnore]
        public Waardetabel? Plaats { get; set; }
    }

    public partial class GbaVerblijfplaatsBeperkt
    {
        public string? NummeraanduidingIdentificatie { get; set; }
        public string? NaamOpenbareRuimte { get; set; }

        public bool ShouldSerializeNummeraanduidingIdentificatie() => false;
        public bool ShouldSerializeNaamOpenbareRuimte() => false;
    }
}
