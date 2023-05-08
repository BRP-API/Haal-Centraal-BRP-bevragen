using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Mappers;

public static class VerblijfplaatsMapper
{
    public static AbstractDatum? MapDatumVan(this GbaVerblijfplaats verblijfplaats)
    {
        return verblijfplaats switch
        {
            { DatumAanvangAdresBuitenland: var datum } when !string.IsNullOrWhiteSpace(datum) => datum.Map(),
            { DatumAanvangAdreshouding: var datum } when !string.IsNullOrWhiteSpace(datum) => datum.Map(),
            _ => null
        };
    }

    public static string? MapStraat(this GbaVerblijfplaats verblijfplaats)
    {
        return !string.IsNullOrWhiteSpace(verblijfplaats.NaamOpenbareRuimte)
            ? verblijfplaats.NaamOpenbareRuimte
            : verblijfplaats.Straat;
    }
}
