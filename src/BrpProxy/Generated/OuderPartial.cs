namespace HaalCentraal.BrpProxy.Generated;

public partial class Ouder
{
    public bool ShouldSerializeGeboorte() => Geboorte != null && Geboorte.ShouldSerialize();
}
