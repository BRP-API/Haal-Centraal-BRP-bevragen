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
            ShouldSerializeInOnderzoek()
            ;

        public bool ShouldSerializeInOnderzoek() =>
            InOnderzoek.AanduidingNaamgebruik.HasValue ||
            InOnderzoek.AdellijkeTitelPredicaat.HasValue ||
            InOnderzoek.Geslachtsnaam.HasValue ||
            InOnderzoek.Voornamen.HasValue ||
            InOnderzoek.Voorvoegsel.HasValue ||
            InOnderzoek.Voorletters.HasValue ||
            InOnderzoek.VolledigeNaam.HasValue
            ;

        [JsonIgnore]
        public ICollection<Partner>? Partners { get; set; }
    }
}
