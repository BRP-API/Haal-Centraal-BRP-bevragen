namespace HaalCentraal.BrpProxy.Generated;

public partial class PersoonInOnderzoek
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
