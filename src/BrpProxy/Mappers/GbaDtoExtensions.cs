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

    public partial class NaamBasis
    {
        public bool ShouldSerializeVolledigeNaam() => !string.IsNullOrWhiteSpace(VolledigeNaam);
    }

    [Newtonsoft.Json.JsonObject(memberSerialization: Newtonsoft.Json.MemberSerialization.OptOut)]
    public class OntbondenPartner : AbstractPartner
    {
    }
}