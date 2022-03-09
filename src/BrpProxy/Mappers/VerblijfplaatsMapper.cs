using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Mappers
{
    public static class VerblijfplaatsMapper
    {
        public static AbstractVerblijfplaats Map(this GbaVerblijfplaats verblijfplaats)
        {
            return new Adres
            {
                Straat = verblijfplaats?.MapStraat(),
                KorteNaam = verblijfplaats?.Straat,
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
}
