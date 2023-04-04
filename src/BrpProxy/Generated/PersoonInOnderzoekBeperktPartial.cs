using static BrpProxy.Mappers.PersoonMapper;

namespace HaalCentraal.BrpProxy.Generated;

public partial class PersoonInOnderzoekBeperkt : IPersoonInOnderzoek
{
    public bool ShouldSerialize() =>
        Burgerservicenummer.HasValue ||
        Geslacht.HasValue ||
        Leeftijd.HasValue
        ;
}
