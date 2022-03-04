using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Mappers;

public static class GeboorteMapper
{
    public static void Map(this GeboorteBeperkt geboorte)
    {
        if (geboorte == null) return;

        if (geboorte?.Datum is GbaDatum datum)
        {
            geboorte.Datum = datum.Map();
        }
    }
    
    public static void Map(this Geboorte geboorte)
    {
        if (geboorte == null) return;

        if (geboorte?.Datum is GbaDatum datum)
        {
            geboorte.Datum = datum.Map();
        }
    }
}
