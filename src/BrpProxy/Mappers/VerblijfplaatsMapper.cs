using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Mappers;

public static class VerblijfplaatsMapper
{
    public static AbstractVerblijfplaats? Map(this GbaVerblijfplaats verblijfplaats)
    {
        if(verblijfplaats == null)
        {
            return null;
        }
        if(!string.IsNullOrWhiteSpace(verblijfplaats.Locatiebeschrijving))
        {
            return new Locatie
            {
                Locatiebeschrijving = verblijfplaats.Locatiebeschrijving,
                Woonplaats = verblijfplaats.GemeenteVanInschrijving.Omschrijving
            };
        }
        return new Adres
        {
            Straat = verblijfplaats?.MapStraat(),
            KorteNaam = verblijfplaats?.Straat,
            Woonplaats = verblijfplaats?.Woonplaats
        };
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

    private static string MapStraat(this GbaVerblijfplaats gba)
    {
        return !string.IsNullOrEmpty(gba.NaamOpenbareRuimte)
                ? gba.NaamOpenbareRuimte
                : gba.Straat;
    }
}
