namespace HaalCentraal.BrpProxy.Generated;

public partial class Verblijfstitel
{
    public bool ShouldSerialize() => 
        Aanduiding != null ||
        DatumEinde != null ||
        DatumIngang != null ||
        InOnderzoek != null;

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();
}

public partial class VerblijfstitelInOnderzoek
{
    public bool ShouldSerialize() =>
        Aanduiding.HasValue ||
        DatumEinde.HasValue ||
        DatumIngang.HasValue;
}