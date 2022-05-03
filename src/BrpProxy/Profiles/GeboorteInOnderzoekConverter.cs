using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class GeboorteInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, GeboorteInOnderzoek?>
{
    public GeboorteInOnderzoek? Convert(GbaInOnderzoek source, GeboorteInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "010000" or
            "010300" or
            "020000" or
            "020300" or
            "030000" or
            "030300" or
            "050000" or
            "050300" => new GeboorteInOnderzoek
            {
                Datum = true,
                Land = true,
                Plaats = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            "010310" or
            "020310" or
            "030310" or
            "050310" => new GeboorteInOnderzoek
            {
                Datum = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            "010320" or
            "020320" or
            "030320" or
            "050320" => new GeboorteInOnderzoek
            {
                Plaats = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            "010330" or
            "020330" or
            "030330" or
            "050330" => new GeboorteInOnderzoek
            {
                Land = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            _ => null,
        };
    }
}
