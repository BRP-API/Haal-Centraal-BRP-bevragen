namespace HaalCentraal.BrpProxy.Generated;

public partial class Partner
{
    public bool ShouldSerializeAangaanHuwelijkPartnerschap() => AangaanHuwelijkPartnerschap != null && AangaanHuwelijkPartnerschap.ShouldSerialize();
    public bool ShouldSerializeGeboorte() => Geboorte != null && Geboorte.ShouldSerialize();
    public bool ShouldSerializeNaam() => Naam != null && Naam.ShouldSerialize();

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