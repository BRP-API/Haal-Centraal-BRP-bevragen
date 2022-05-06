namespace HaalCentraal.BrpProxy.Generated;

public partial class Verblijfstitel
{
    public bool ShouldSerialize() => 
        Aanduiding != null ||
        DatumEinde != null ||
        DatumIngang != null ||
        InOnderzoek != null;
}
