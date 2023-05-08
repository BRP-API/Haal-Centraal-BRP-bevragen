namespace HaalCentraal.BrpProxy.Generated;

public partial class Partner
{
    public bool ShouldSerializeAangaanHuwelijkPartnerschap() => AangaanHuwelijkPartnerschap != null;
    public bool ShouldSerializeGeboorte() => Geboorte != null;
    public bool ShouldSerializeNaam() => Naam != null;
    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();
    public bool ShouldSerializeOntbindingHuwelijkPartnerschap() => OntbindingHuwelijkPartnerschap != null;
    public bool ShouldSerialize() =>
        !string.IsNullOrWhiteSpace(Burgerservicenummer) ||
        Geslacht != null ||
        SoortVerbintenis != null
        ;
}

public partial class PartnerInOnderzoek
{
    public bool ShouldSerialize() =>
        Burgerservicenummer.HasValue ||
        Geslacht.HasValue ||
        SoortVerbintenis.HasValue
        ;
}

public partial class AangaanHuwelijkPartnerschap
{
    public bool ShouldSerialize() =>
        Datum != null ||
        Land != null ||
        Plaats != null
        ;

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();
}

public partial class AangaanHuwelijkPartnerschapInOnderzoek
{
    public bool ShouldSerialize() =>
        Datum.HasValue ||
        Land.HasValue ||
        Plaats.HasValue
        ;
}

public partial class OntbindingHuwelijkPartnerschap
{
    public bool ShouldSerialize() => Datum != null;

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();
}

public partial class OntbindingHuwelijkPartnerschapInOnderzoek
{
    public bool ShouldSerialize() => Datum.HasValue;
}
