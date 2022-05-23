namespace HaalCentraal.BrpProxy.Generated;

public partial class VerblijfplaatsBuitenland
{
    public bool ShouldSerializeVerblijfadres() =>
        Verblijfadres != null && Verblijfadres.ShouldSerialize();
}

public partial class VerblijfadresBuitenland
{
    public bool ShouldSerialize() =>
        !string.IsNullOrWhiteSpace(Regel1) ||
        !string.IsNullOrWhiteSpace(Regel2) ||
        !string.IsNullOrWhiteSpace(Regel3) ||
        Land != null ||
        InOnderzoek != null;
}