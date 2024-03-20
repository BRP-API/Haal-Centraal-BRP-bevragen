namespace HaalCentraal.BrpProxy.Generated;

public partial class Persoon
{
    public bool ShouldSerializeNationaliteiten() => Nationaliteiten != null;

    public bool ShouldSerializeKinderen() => Kinderen != null;

    public bool ShouldSerializeOuders() => Ouders != null;

    public bool ShouldSerializePartners() => Partners != null;

    public bool ShouldSerializeRni() => Rni != null && Rni.Count > 0;

    public bool ShouldSerializeAdressering() => Adressering != null;

    public bool ShouldSerializeEuropeesKiesrecht() => EuropeesKiesrecht != null && EuropeesKiesrecht.ShouldSerialize();

    public bool ShouldSerializeGeboorte() => Geboorte != null;

    public bool ShouldSerializeImmigratie() => Immigratie != null;

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();

    public bool ShouldSerializeNaam() => Naam != null;

    public bool ShouldSerializeOpschortingBijhouding() => OpschortingBijhouding != null && OpschortingBijhouding.ShouldSerialize();

    public bool ShouldSerializeOverlijden() => Overlijden != null;

    public bool ShouldSerializeUitsluitingKiesrecht() => UitsluitingKiesrecht != null && UitsluitingKiesrecht.ShouldSerialize();

    public bool ShouldSerializeVerblijfplaats() => Verblijfplaats != null;

    public bool ShouldSerializeVerblijfstitel() => Verblijfstitel != null && Verblijfstitel.ShouldSerialize();

    public bool ShouldSerialize() =>
        !string.IsNullOrWhiteSpace(ANummer) ||
        !string.IsNullOrWhiteSpace(Burgerservicenummer) ||
        DatumEersteInschrijvingGBA != null ||
        DatumInschrijvingInGemeente != null ||
        GeheimhoudingPersoonsgegevens ||
        Geslacht != null ||
        IndicatieCurateleRegister ||
        IndicatieGezagMinderjarige != null ||
        Leeftijd > 0 ||
        Adressering != null ||
        ShouldSerializeEuropeesKiesrecht() ||
        ShouldSerializeGeboorte() ||
        ShouldSerializeImmigratie() ||
        ShouldSerializeInOnderzoek() ||
        ShouldSerializeKinderen() ||
        ShouldSerializeNaam() ||
        ShouldSerializeNationaliteiten() ||
        ShouldSerializeOuders() ||
        ShouldSerializeOpschortingBijhouding() ||
        ShouldSerializeOverlijden() ||
        ShouldSerializePartners() ||
        ShouldSerializeUitsluitingKiesrecht() ||
        ShouldSerializeVerblijfstitel()
        ;
}
