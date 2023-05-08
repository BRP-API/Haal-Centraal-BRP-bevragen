namespace HaalCentraal.BrpProxy.Generated;

public partial class Kind
{
    public bool ShouldSerialize() =>
        !string.IsNullOrWhiteSpace(Burgerservicenummer)
        ;

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();

    public bool ShouldSerializeNaam() => Naam != null;

    public bool ShouldSerializeGeboorte() => Geboorte != null;
}

public partial class KindInOnderzoek
{
    public bool ShouldSerialize() =>
        Burgerservicenummer.HasValue
        ;
}
