namespace HaalCentraal.BrpProxy.Generated;

public partial class Partner
{
    public bool ShouldSerializeAangaanHuwelijkPartnerschap() => AangaanHuwelijkPartnerschap != null;
    public bool ShouldSerializeGeboorte() => Geboorte != null;
    public bool ShouldSerializeNaam() => Naam != null;

    public bool ShouldSerialize() =>
        !string.IsNullOrWhiteSpace(Burgerservicenummer) ||
        Geslacht != null ||
        InOnderzoek != null ||
        ShouldSerializeAangaanHuwelijkPartnerschap() ||
        ShouldSerializeGeboorte() ||
        ShouldSerializeNaam();
}

public partial class AangaanHuwelijkPartnerschap
{
    public bool ShouldSerialize() =>
        Datum != null ||
        Land != null ||
        Plaats != null ||
        InOnderzoek != null;
}