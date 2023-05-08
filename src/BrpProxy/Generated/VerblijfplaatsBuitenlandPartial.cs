namespace HaalCentraal.BrpProxy.Generated;

public partial class VerblijfplaatsBuitenland
{
    public override bool ShouldSerialize() =>
        DatumIngangGeldigheid != null ||
        DatumVan != null
        ;

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();

    public bool ShouldSerializeVerblijfadres() => Verblijfadres != null;
}

public partial class VerblijfplaatsBuitenlandInOnderzoek
{
    public bool ShouldSerialize() =>
        DatumIngangGeldigheid.HasValue ||
        DatumVan.HasValue ||
        Type.HasValue
        ;
}

public partial class VerblijfadresBuitenland
{
    public bool ShouldSerialize() =>
        !string.IsNullOrWhiteSpace(Regel1) ||
        !string.IsNullOrWhiteSpace(Regel2) ||
        !string.IsNullOrWhiteSpace(Regel3) ||
        Land != null
        ;

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();
}

public partial class VerblijfadresBuitenlandInOnderzoek
{
    public bool ShouldSerialize() =>
        Regel1.HasValue ||
        Regel2.HasValue ||
        Regel3.HasValue ||
        Land.HasValue
        ;
}
