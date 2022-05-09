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
            InOnderzoek != null ||
            !string.IsNullOrWhiteSpace(Aanhef);

        [JsonIgnore]
        public ICollection<AbstractPartner>? Partners { get; set; }
        [JsonIgnore]
        public Waardetabel? Geslacht { get; set; }
    }
}
