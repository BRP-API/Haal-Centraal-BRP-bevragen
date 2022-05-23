using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class BijzonderNederlanderschapInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, BijzonderNederlanderschapInOnderzoek?>
{
    public BijzonderNederlanderschapInOnderzoek? Convert(GbaInOnderzoek source, BijzonderNederlanderschapInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "040000" => new BijzonderNederlanderschapInOnderzoek
            {
                RedenOpname = true,
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            "040500" or
            "040510" or
            "046500" or
            "046510" => new BijzonderNederlanderschapInOnderzoek
            {
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()

            },
            "046300" or "046310" => new BijzonderNederlanderschapInOnderzoek
            {
                RedenOpname = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()

            },
            _ => null
        };
    }
}
