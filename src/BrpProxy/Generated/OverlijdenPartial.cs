using System.Security.Cryptography.X509Certificates;

namespace HaalCentraal.BrpProxy.Generated;

public partial class Overlijden
{
    public bool ShouldSerialize() =>
        Datum != null ||
        Land != null ||
        Plaats != null ||
        InOnderzoek != null
        ;

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();
}

public partial class OverlijdenInOnderzoek
{
    public bool ShouldSerialize() =>
        Datum.HasValue ||
        Plaats.HasValue ||
        Land.HasValue;
}
