using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Mappers;

public static class GeboorteMapper
{
    //public static void Map(this GeboorteBeperkt geboorte)
    //{
    //    if (geboorte == null) return;

    //    if (geboorte?.Datum is GbaDatum datum)
    //    {
    //        geboorte.Datum = datum.Map();
    //    }
    //}

    //public static void Map(this Geboorte geboorte)
    //{
    //    if (geboorte == null) return;

    //    if (geboorte?.Datum is GbaDatum datum)
    //    {
    //        geboorte.Datum = datum.Map();
    //    }
    //}

    public static Geboorte Map(this GbaGeboorte geboorte)
    {
        return new Geboorte
        {
            Datum = geboorte?.Datum.Map(),
        };
    }

    public static GeboorteBeperkt Map(this GbaGeboorteBeperkt geboorte)
    {
        return new GeboorteBeperkt
        {
            Datum = geboorte?.Datum.Map(),
        };
    }
}
