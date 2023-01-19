namespace HaalCentraal.BrpProxy.Generated;

public partial class Geboorte
{
    public bool ShouldSerialize() =>
        Datum != null ||
        Land != null ||
        Plaats != null||
        InOnderzoek != null
        ;

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();
}

public partial class GeboorteInOnderzoek
{
    public bool ShouldSerialize() =>
        Datum.HasValue ||
        Land.HasValue ||
        Plaats.HasValue;
}