using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class OverlijdenInOnderzoekBeperktConverter : ITypeConverter<GbaInOnderzoek, OverlijdenInOnderzoekBeperkt?>
{
    public OverlijdenInOnderzoekBeperkt? Convert(GbaInOnderzoek source, OverlijdenInOnderzoekBeperkt? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "060000" or
            "060800" or
            "060810" => new OverlijdenInOnderzoekBeperkt
            {
                IndicatieOverleden = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            _ => null,
        };
    }
}