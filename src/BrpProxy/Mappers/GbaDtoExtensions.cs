namespace HaalCentraal.BrpProxy.Generated.Gba
{
    public interface IGbaNaam
    {
        AdellijkeTitelPredicaatType AdellijkeTitelPredicaat { get; }
        string Geslachtsnaam { get; }
        string Voornamen { get; }
        string Voorvoegsel { get; }
    }

    public partial class GbaNaamPersoon : IGbaNaam {}
    public partial class GbaNaamBasis: IGbaNaam { }
}

namespace HaalCentraal.BrpProxy.Generated
{
    public partial class Persoon
    {
        public bool ShouldSerializeNationaliteiten() => Nationaliteiten?.Count > 0;
        public bool ShouldSerializeReisdocumentnummers() => Reisdocumentnummers?.Count > 0;
        public bool ShouldSerializeKinderen() => Kinderen?.Count > 0;
        public bool ShouldSerializeOuders() => Ouders?.Count > 0;
        public bool ShouldSerializePartners() {
            if(Partners != null)
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
            !string.IsNullOrWhiteSpace(Naam.Voorvoegsel));
    }

    public partial class NaamBasis
    {
        public bool ShouldSerializeVolledigeNaam() => !string.IsNullOrWhiteSpace(VolledigeNaam);
    }

    [Newtonsoft.Json.JsonObject(memberSerialization: Newtonsoft.Json.MemberSerialization.OptOut)]
    public class OntbondenPartner : AbstractPartner
    {
    }
}