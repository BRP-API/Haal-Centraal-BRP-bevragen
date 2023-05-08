namespace HaalCentraal.BrpProxy.Generated;

public partial class VerblijfplaatsOnbekend
{
    public override bool ShouldSerialize() => 
        DatumIngangGeldigheid != null ||
        DatumVan != null
        ;

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();
}

public partial class VerblijfplaatsOnbekendInOnderzoek
{
    public bool ShouldSerialize() =>
        DatumIngangGeldigheid.HasValue ||
        DatumVan.HasValue ||
        Type.HasValue
        ;
}