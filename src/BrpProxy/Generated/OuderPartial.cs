namespace HaalCentraal.BrpProxy.Generated;

public partial class Ouder
{
    public bool ShouldSerializeGeboorte() => Geboorte != null;

    public bool ShouldSerializeNaam() => Naam != null;

    public bool ShouldSerialize() =>
        ShouldSerializeGeboorte() ||
        ShouldSerializeNaam() ||
        !string.IsNullOrWhiteSpace(OuderAanduiding) ||
        InOnderzoek != null;
}
