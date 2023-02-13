namespace HaalCentraal.BrpProxy.Generated;

public partial class PersoonInOnderzoekBeperkt
{
    public bool ShouldSerialize() =>
        Burgerservicenummer.HasValue ||
        Geslacht.HasValue ||
        Leeftijd.HasValue
        ;
}
