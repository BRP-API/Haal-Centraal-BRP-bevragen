using static BrpProxy.Mappers.PersoonMapper;

namespace HaalCentraal.BrpProxy.Generated;

public partial class PersoonInOnderzoek : IPersoonInOnderzoek
{
    public bool ShouldSerialize() =>
        Burgerservicenummer.HasValue ||
        Geslacht.HasValue ||
        Leeftijd.HasValue ||
        IndicatieCurateleRegister.HasValue ||
        IndicatieGezagMinderjarige.HasValue ||
        DatumInschrijvingInGemeente.HasValue ||
        GemeenteVanInschrijving.HasValue
        ;
}
