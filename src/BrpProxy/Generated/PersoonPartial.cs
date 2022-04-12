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

    public bool ShouldSerializeNaam() =>
        Naam != null &&
        (Naam.AanduidingNaamgebruik != null ||
        Naam.AdellijkeTitelPredicaat != null ||
        !string.IsNullOrWhiteSpace(Naam.Geslachtsnaam) ||
        !string.IsNullOrWhiteSpace(Naam.Voornamen) ||
        !string.IsNullOrWhiteSpace(Naam.Voorvoegsel) ||
        !string.IsNullOrWhiteSpace(Naam.Voorletters) ||
        !string.IsNullOrWhiteSpace(Naam.VolledigeNaam));
}
