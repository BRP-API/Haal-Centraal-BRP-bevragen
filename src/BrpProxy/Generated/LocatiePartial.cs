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