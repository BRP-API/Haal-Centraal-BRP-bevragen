using Newtonsoft.Json;

namespace HaalCentraal.BrpProxy.Generated
{
    public partial class NaamPersoon : INaam
    {
        public bool ShouldSerialize() =>
            AanduidingNaamgebruik != null ||
            AdellijkeTitelPredicaat != null ||
            !string.IsNullOrWhiteSpace(Geslachtsnaam) ||
            !string.IsNullOrWhiteSpace(Voornamen) ||
            !string.IsNullOrWhiteSpace(Voorvoegsel) ||
            !string.IsNullOrWhiteSpace(Voorletters) ||
            !string.IsNullOrWhiteSpace(VolledigeNaam) ||
            InOnderzoek != null
            ;

        [JsonIgnore]
        public ICollection<Partner>? Partners { get; set; }
    }
}
