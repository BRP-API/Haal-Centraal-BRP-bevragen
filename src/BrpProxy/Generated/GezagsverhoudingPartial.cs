namespace HaalCentraal.BrpProxy.Generated;

public partial class Gezagsverhouding
{
    public bool ShouldSerialize() =>
        IndicatieCurateleRegister != null ||
        IndicatieGezagMinderjarige != null ||
        InOnderzoek != null;
}
