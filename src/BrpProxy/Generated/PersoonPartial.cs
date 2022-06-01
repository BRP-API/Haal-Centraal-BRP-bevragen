namespace HaalCentraal.BrpProxy.Generated;

public partial class Persoon
{
    public bool ShouldSerializeNationaliteiten() => Nationaliteiten?.Count > 0;

    public bool ShouldSerializeReisdocumentnummers() => Reisdocumentnummers?.Count > 0;

    public bool ShouldSerializeKinderen() => Kinderen?.Count > 0;

    public bool ShouldSerializeOuders() => Ouders?.Count > 0;

    public bool ShouldSerializePartners()
    {
        if (Partners != null)
        {
            Partners = (from partner in Partners
                        where partner.GetType() != typeof(OntbondenPartner)
                        select partner).ToList();
        }
        return Partners?.Count > 0;
    }

    public bool ShouldSerializeAdressering() => Adressering != null && Adressering.ShouldSerialize();

    public bool ShouldSerializeEuropeesKiesrecht() => EuropeesKiesrecht != null && EuropeesKiesrecht.ShouldSerialize();

    public bool ShouldSerializeGeboorte() => Geboorte != null && Geboorte.ShouldSerialize();

    public bool ShouldSerializeImmigratie() => Immigratie != null && Immigratie.ShouldSerialize();

    public bool ShouldSerializeNaam() => Naam != null && Naam.ShouldSerialize();

    public bool ShouldSerializeOpschortingBijhouding() => OpschortingBijhouding != null && OpschortingBijhouding.ShouldSerialize();

    public bool ShouldSerializeOverlijden() => Overlijden != null && Overlijden.ShouldSerialize();

    public bool ShouldSerializeUitsluitingKiesrecht() => UitsluitingKiesrecht != null && UitsluitingKiesrecht.ShouldSerialize();

    public bool ShouldSerializeVerblijfplaats() => Verblijfplaats != null && Verblijfplaats.ShouldSerialize();

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
        InOnderzoek != null ||
        Leeftijd > 0 ||
        ShouldSerializeAdressering() ||
        ShouldSerializeEuropeesKiesrecht() ||
        ShouldSerializeGeboorte() ||
        ShouldSerializeImmigratie() ||
        ShouldSerializeKinderen() ||
        ShouldSerializeNaam() ||
        ShouldSerializeNationaliteiten() ||
        ShouldSerializeOuders() ||
        ShouldSerializeOpschortingBijhouding() ||
        ShouldSerializeOverlijden() ||
        ShouldSerializePartners() ||
        ShouldSerializeReisdocumentnummers() ||
        ShouldSerializeUitsluitingKiesrecht() ||
        ShouldSerializeVerblijfplaats() ||
        ShouldSerializeVerblijfstitel()
        ;
}
