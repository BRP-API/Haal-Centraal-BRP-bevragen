namespace HaalCentraal.BrpProxy.Generated;

public partial class PersoonInOnderzoek
{
    public bool ShouldSerialize() =>
        DatumIngangOnderzoekGemeente != null ||
        DatumIngangOnderzoekGezag != null ||
        DatumIngangOnderzoekPersoon != null;
}
