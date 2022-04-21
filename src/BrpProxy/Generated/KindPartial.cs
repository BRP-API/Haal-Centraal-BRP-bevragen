namespace HaalCentraal.BrpProxy.Generated
{
    public partial class Kind
    {
        public bool ShouldSerializeNaam() => Naam != null && Naam.ShouldSerialize();

        public bool ShouldSerializeGeboorte() => Geboorte != null && Geboorte.ShouldSerialize();
    }
}
