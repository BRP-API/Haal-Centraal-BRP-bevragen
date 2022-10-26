namespace HaalCentraal.BrpProxy.Generated;

public partial class VerblijfplaatsOnbekend
{
    public override bool ShouldSerialize() => true;

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();
}

public partial class VerblijfplaatsOnbekendInOnderzoek
{
    public bool ShouldSerialize() =>
        DatumIngangGeldigheid.HasValue ||
        DatumVan.HasValue ||
        FunctieAdres.HasValue ||
        Type.HasValue
        ;
}