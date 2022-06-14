using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class NationaliteitInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, NationaliteitBekendInOnderzoek?>
{
    public NationaliteitBekendInOnderzoek? Convert(GbaInOnderzoek source, NationaliteitBekendInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "040000" => new NationaliteitBekendInOnderzoek
            {
                Nationaliteit = true,
                RedenOpname = true,
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            "040500" or "040510" => new NationaliteitBekendInOnderzoek
            {
                Nationaliteit = true,
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()

            },
            "046300" or "046310" => new NationaliteitBekendInOnderzoek
            {
                RedenOpname = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()

            },
            _ => null
        };
    }
}
