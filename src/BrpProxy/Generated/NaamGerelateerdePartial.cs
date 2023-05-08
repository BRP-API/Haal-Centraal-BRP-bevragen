namespace HaalCentraal.BrpProxy.Generated;

public partial class NaamGerelateerde : INaam
{
    public bool ShouldSerialize() =>
        AdellijkeTitelPredicaat != null ||
        !string.IsNullOrWhiteSpace(Geslachtsnaam) ||
        !string.IsNullOrWhiteSpace(Voornamen) ||
        !string.IsNullOrWhiteSpace(Voorvoegsel) ||
        !string.IsNullOrWhiteSpace(Voorletters)||
        InOnderzoek != null
        ;

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();
}

public partial class NaamInOnderzoek
{
    public bool ShouldSerialize() =>
        AdellijkeTitelPredicaat.HasValue ||
        Geslachtsnaam.HasValue ||
        Voornamen.HasValue ||
        Voorvoegsel.HasValue ||
        Voorletters.HasValue
        ;
}