using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class KindInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, KindInOnderzoek?>
{
    public KindInOnderzoek? Convert(GbaInOnderzoek source, KindInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "090000" or
            "090100" or
            "090120" => new KindInOnderzoek
            {
                Burgerservicenummer = true,
                DatumIngangOnderzoek = source.DatumIngangOnderzoek?.Map()
            },
            _ => null,
        };
    }
}
