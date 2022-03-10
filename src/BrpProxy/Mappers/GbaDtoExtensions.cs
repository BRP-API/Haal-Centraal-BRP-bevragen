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
        public bool ShouldSerializePartners() => Partners?.Count > 0;
        //public bool ShouldSerializeNaam() => !string.IsNullOrWhiteSpace(Naam.Geslachtsnaam);
    }

    public partial class NaamBasis
    {
        public bool ShouldSerializeVolledigeNaam() => !string.IsNullOrWhiteSpace(VolledigeNaam);
    }
}