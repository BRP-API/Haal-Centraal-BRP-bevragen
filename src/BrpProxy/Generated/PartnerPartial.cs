namespace HaalCentraal.BrpProxy.Generated;

public partial class Partner
{
    public bool ShouldSerializeAangaanHuwelijkPartnerschap() => AangaanHuwelijkPartnerschap != null && AangaanHuwelijkPartnerschap.ShouldSerialize();
    public bool ShouldSerializeGeboorte() => Geboorte != null && Geboorte.ShouldSerialize();
}

public partial class AangaanHuwelijkPartnerschap
{
    public bool ShouldSerialize() =>
        Datum != null ||
        Land != null ||
        Plaats != null;
}