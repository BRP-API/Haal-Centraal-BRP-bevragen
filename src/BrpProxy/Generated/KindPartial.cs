namespace HaalCentraal.BrpProxy.Generated
{
    public partial class Kind
    {
        public bool ShouldSerialize() =>
            !string.IsNullOrWhiteSpace(Burgerservicenummer) ||
            ShouldSerializeGeboorte() ||
            ShouldSerializeNaam() ||
            ShouldSerializeInOnderzoek()
            ;

        public bool ShouldSerializeInOnderzoek() => InOnderzoek != null;

        public bool ShouldSerializeNaam() => Naam != null && Naam.ShouldSerialize();

        public bool ShouldSerializeGeboorte() => Geboorte != null;
    }
}
