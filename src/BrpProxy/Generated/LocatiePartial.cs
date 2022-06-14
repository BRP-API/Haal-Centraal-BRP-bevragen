namespace HaalCentraal.BrpProxy.Generated;

public partial class Locatie
{
    public bool ShouldSerializeVerblijfadres() =>
        Verblijfadres != null && Verblijfadres.ShouldSerialize();
}

public partial class VerblijfadresLocatie
{
    public bool ShouldSerialize() =>
        !string.IsNullOrWhiteSpace(Locatiebeschrijving) ||
        InOnderzoek != null;
}

public partial class LocatieBeperkt
{
    public VerblijfadresLocatie? Verblijfadres { get; set; }

    public bool ShouldSerializeVerblijfadres() => false;
}
