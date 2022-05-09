namespace HaalCentraal.BrpProxy.Generated;

public partial class NaamGerelateerde : INaam
{
    public bool ShouldSerialize() =>
        !string.IsNullOrWhiteSpace(Voornamen) ||
        AdellijkeTitelPredicaat != null ||
        !string.IsNullOrWhiteSpace(Voorvoegsel) ||
        !string.IsNullOrWhiteSpace(Geslachtsnaam) ||
        InOnderzoek != null;
}
