namespace HaalCentraal.BrpProxy.Generated;

public partial class Geboorte
{
    public bool ShouldSerialize() =>
        Datum != null ||
        Land != null ||
        Plaats != null;
}
