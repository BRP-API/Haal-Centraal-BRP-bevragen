using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Mappers
{
    public static class VerblijfplaatsMapper
    {
        public static AbstractVerblijfplaats Map(this AbstractVerblijfplaats verblijfplaats)
        {
            if (verblijfplaats is GbaVerblijfplaats gba)
            {
                var retval = new Verblijfplaats();

                retval.Straat = gba.MapStraat();
                retval.KorteNaam = gba.Straat;

                return retval;
            }

            return verblijfplaats;
        }

        private static string MapStraat(this GbaVerblijfplaats gba)
        {
            return !string.IsNullOrEmpty(gba.NaamOpenbareRuimte)
                ? gba.NaamOpenbareRuimte
                : gba.Straat;
        }
    }
}
