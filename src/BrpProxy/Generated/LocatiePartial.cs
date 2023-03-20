namespace HaalCentraal.BrpProxy.Generated;

public partial class Locatie
{
    public override bool ShouldSerialize() =>
        DatumIngangGeldigheid != null ||
        DatumVan != null ||
        FunctieAdres != null ||
        Verblijfadres != null
        ;

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();

    public bool ShouldSerializeVerblijfadres() => Verblijfadres != null;
}

public partial class LocatieInOnderzoek
{
    public bool ShouldSerialize() =>
        DatumIngangGeldigheid.HasValue ||
        DatumVan.HasValue ||
        FunctieAdres.HasValue ||
        Type.HasValue
        ;
}

public partial class VerblijfadresLocatie
{
    public bool ShouldSerialize() =>
        !string.IsNullOrWhiteSpace(Locatiebeschrijving)
        ;

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();
}

public partial class VerblijfadresLocatieInOnderzoek
{
    public bool ShouldSerialize() =>
        Locatiebeschrijving.HasValue
        ;
}
