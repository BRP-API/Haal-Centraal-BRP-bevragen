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

    public bool ShouldSerializeGeboorte() => Geboorte != null && Geboorte.ShouldSerialize();

    public bool ShouldSerializeGezagsverhouding() => Gezagsverhouding != null && Gezagsverhouding.ShouldSerialize();

    public bool ShouldSerializeKiesrecht() => Kiesrecht != null && Kiesrecht.ShouldSerialize();

    public bool ShouldSerializeNaam() => Naam != null && Naam.ShouldSerialize();

    public bool ShouldSerializeOpschortingBijhouding() => OpschortingBijhouding != null && OpschortingBijhouding.ShouldSerialize();

    public bool ShouldSerializeOverlijden() => Overlijden != null && Overlijden.ShouldSerialize();

    public bool ShouldSerializeVerblijfplaats() => Verblijfplaats != null && Verblijfplaats.ShouldSerialize();

    public bool ShouldSerializeVerblijfstitel() => Verblijfstitel != null && Verblijfstitel.ShouldSerialize();

    public bool ShouldSerialize() =>
        !string.IsNullOrWhiteSpace(ANummer) ||
        !string.IsNullOrWhiteSpace(Burgerservicenummer) ||
        DatumEersteInschrijvingGBA != null ||
        GeheimhoudingPersoonsgegevens ||
        Geslacht != null ||
        InOnderzoek != null ||
        Leeftijd > 0 ||
        ShouldSerializeGeboorte() ||
        ShouldSerializeGezagsverhouding() ||
        ShouldSerializeKiesrecht() ||
        ShouldSerializeKinderen() ||
        ShouldSerializeNaam() ||
        ShouldSerializeNationaliteiten() ||
        ShouldSerializeOuders() ||
        ShouldSerializeOpschortingBijhouding() ||
        ShouldSerializeOverlijden() ||
        ShouldSerializePartners() ||
        ShouldSerializeReisdocumentnummers() ||
        ShouldSerializeVerblijfplaats() ||
        ShouldSerializeVerblijfstitel()
        ;
}
