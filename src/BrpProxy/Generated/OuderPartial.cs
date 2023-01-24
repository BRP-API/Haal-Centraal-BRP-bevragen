namespace HaalCentraal.BrpProxy.Generated;

public partial class Ouder
{
    public bool ShouldSerializeGeboorte() => Geboorte != null;

    public bool ShouldSerializeNaam() => Naam != null;

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();

    public bool ShouldSerialize() =>
        !string.IsNullOrWhiteSpace(Burgerservicenummer) ||
        DatumIngangFamilierechtelijkeBetrekking != null ||
        Geslacht != null ||
        !string.IsNullOrWhiteSpace(OuderAanduiding) 
        ;
}

public partial class OuderInOnderzoek
{
    public bool ShouldSerialize() =>
        Burgerservicenummer.HasValue ||
        DatumIngangFamilierechtelijkeBetrekking.HasValue ||
        Geslacht.HasValue
        ;
}