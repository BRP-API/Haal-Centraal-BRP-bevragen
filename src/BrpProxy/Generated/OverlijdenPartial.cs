using System.Security.Cryptography.X509Certificates;

namespace HaalCentraal.BrpProxy.Generated;

public partial class Overlijden
{
    public bool ShouldSerialize() =>
        Datum != null ||
        IndicatieOverleden ||
        Land != null ||
        Plaats != null ||
        InOnderzoek != null
        ;

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();
}

public partial class OverlijdenInOnderzoek
{
    public bool ShouldSerialize() =>
        IndicatieOverleden.HasValue ||
        Datum.HasValue ||
        Plaats.HasValue ||
        Land.HasValue;
}

public partial class OverlijdenBeperkt
{
    public bool ShouldSerialize() =>
        IndicatieOverleden ||
        InOnderzoek != null
        ;

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();
}

public partial class OverlijdenInOnderzoekBeperkt
{
    public bool ShouldSerialize() => IndicatieOverleden.HasValue;
}
