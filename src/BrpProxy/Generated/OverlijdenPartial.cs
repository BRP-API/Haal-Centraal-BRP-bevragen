namespace HaalCentraal.BrpProxy.Generated;

public partial class Overlijden
{
    public bool ShouldSerialize() =>
        Datum != null ||
        IndicatieOverleden ||
        Land != null ||
        Plaats != null ||
        (InOnderzoek != null && InOnderzoek.ShouldSerialize());
}

public partial class OverlijdenInOnderzoek
{
    public bool ShouldSerialize() =>
        IndicatieOverleden.HasValue ||
        Datum.HasValue ||
        Plaats.HasValue ||
        Land.HasValue;
}