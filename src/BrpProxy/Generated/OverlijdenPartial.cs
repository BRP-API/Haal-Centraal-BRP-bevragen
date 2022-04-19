namespace HaalCentraal.BrpProxy.Generated;

public partial class Overlijden
{
    public bool ShouldSerialize() =>
        Datum != null ||
        IndicatieOverleden ||
        Land != null ||
        Plaats != null;
}
