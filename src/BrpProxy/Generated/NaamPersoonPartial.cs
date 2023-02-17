using Newtonsoft.Json;

namespace HaalCentraal.BrpProxy.Generated;

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

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();

    [JsonIgnore]
    public ICollection<Partner>? Partners { get; set; }
}

public partial class NaamPersoonInOnderzoek
{
    public new bool ShouldSerialize() =>
        AanduidingNaamgebruik.HasValue ||
        AdellijkeTitelPredicaat.HasValue ||
        Geslachtsnaam.HasValue ||
        Voornamen.HasValue ||
        Voorvoegsel.HasValue ||
        Voorletters.HasValue ||
        VolledigeNaam.HasValue
        ;
}

public partial class NaamPersoonBeperkt
{
    public bool ShouldSerialize() =>
        AdellijkeTitelPredicaat != null ||
        !string.IsNullOrWhiteSpace(Geslachtsnaam) ||
        !string.IsNullOrWhiteSpace(Voornamen) ||
        !string.IsNullOrWhiteSpace(Voorvoegsel) ||
        !string.IsNullOrWhiteSpace(Voorletters) ||
        !string.IsNullOrWhiteSpace(VolledigeNaam) ||
        InOnderzoek != null
        ;

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();
}

public partial class NaamPersoonInOnderzoekBeperkt
{
    public new bool ShouldSerialize() =>
        AdellijkeTitelPredicaat.HasValue ||
        Geslachtsnaam.HasValue ||
        Voornamen.HasValue ||
        Voorvoegsel.HasValue ||
        Voorletters.HasValue ||
        VolledigeNaam.HasValue
        ;
}