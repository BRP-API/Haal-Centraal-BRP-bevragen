using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Mappers;

public static class VerblijfplaatsMapper
{
    public static string? MapWoonplaats(this GbaVerblijfplaats verblijfplaats)
    {
        return !string.IsNullOrWhiteSpace(verblijfplaats.Woonplaats)
            ? verblijfplaats.Woonplaats
            : verblijfplaats.GemeenteVanInschrijving?.Omschrijving;
    }

    public static AbstractVerblijfplaatsBeperkt? Map(this GbaVerblijfplaatsBeperkt verblijfplaats)
    {
        if (verblijfplaats == null)
        {
            return null;
        }
        if (!string.IsNullOrWhiteSpace(verblijfplaats.Locatiebeschrijving))
        {
            return new LocatieBeperkt
            {
                Locatiebeschrijving = verblijfplaats.Locatiebeschrijving,
                Woonplaats = verblijfplaats.GemeenteVanInschrijving.Omschrijving
            };
        }
        return new AdresBeperkt
        {
            Woonplaats = verblijfplaats?.Woonplaats
        };
    }
}
