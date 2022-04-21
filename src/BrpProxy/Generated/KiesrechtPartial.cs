namespace HaalCentraal.BrpProxy.Generated;

public partial class Kiesrecht
{
    public bool ShouldSerialize() =>
        UitgeslotenVanKiesrecht == true ||
        EinddatumUitsluitingKiesrecht != null ||
        EuropeesKiesrecht == true ||
        EinddatumUitsluitingEuropeesKiesrecht != null;
}
