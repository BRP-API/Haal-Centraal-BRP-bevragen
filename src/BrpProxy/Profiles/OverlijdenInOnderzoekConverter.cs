using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class OverlijdenInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, OverlijdenInOnderzoek?>
{
    public OverlijdenInOnderzoek? Convert(GbaInOnderzoek source, OverlijdenInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "060000" or
            "060800" => new OverlijdenInOnderzoek
            {
                Datum = true,
                Land = true,
                Plaats = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            "060810" => new OverlijdenInOnderzoek
            {
                Datum = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            "060820" => new OverlijdenInOnderzoek
            {
                Plaats = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            "060830" => new OverlijdenInOnderzoek
            {
                Land = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            _ => null,
        };
    }
}
