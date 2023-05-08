namespace HaalCentraal.BrpProxy.Generated;

public partial class UitsluitingKiesrecht
{
    public bool ShouldSerialize() =>
        UitgeslotenVanKiesrecht == true ||
        Einddatum != null;
}
