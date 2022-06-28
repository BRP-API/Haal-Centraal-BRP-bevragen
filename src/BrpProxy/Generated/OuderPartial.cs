namespace HaalCentraal.BrpProxy.Generated;

public partial class Ouder
{
    public bool ShouldSerializeGeboorte() => Geboorte != null && Geboorte.ShouldSerialize();

    public bool ShouldSerializeNaam() => Naam != null && Naam.ShouldSerialize();

    public bool ShouldSerialize() =>
        ShouldSerializeGeboorte() ||
        ShouldSerializeNaam() ||
        !string.IsNullOrWhiteSpace(OuderAanduiding) ||
        InOnderzoek != null;
}
