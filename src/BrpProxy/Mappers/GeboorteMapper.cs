using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Mappers
{
    public static class GeboorteMapper
    {
        public static GeboorteInOnderzoek? PersoonGeboorteInOnderzoek(this GbaInOnderzoek? source)
        {
            return source?.AanduidingGegevensInOnderzoek switch
            {
                "010300" => new GeboorteInOnderzoek
                {
                    Datum = true,
                    Land = true,
                    Plaats = true,
                    DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
                },
                "010310" => new GeboorteInOnderzoek
                {
                    Datum = true,
                    DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
                },
                "010320" => new GeboorteInOnderzoek
                {
                    Plaats = true,
                    DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
                },
                "010330" => new GeboorteInOnderzoek
                {
                    Land = true,
                    DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
                },
                _ => null,
            };
        }
    }
}
