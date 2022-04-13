namespace HaalCentraal.BrpProxy.Generated
{
    public partial class Kind
    {
        public bool ShouldSerializeNaam() =>
            Naam != null &&
            (Naam.AdellijkeTitelPredicaat != null ||
            !string.IsNullOrWhiteSpace(Naam.Geslachtsnaam) ||
            !string.IsNullOrWhiteSpace(Naam.Voornamen) ||
            !string.IsNullOrWhiteSpace(Naam.Voorvoegsel));

        public bool ShouldSerializeGeboorte() => Geboorte != null && Geboorte.ShouldSerialize();
    }
}
