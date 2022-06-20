using AutoMapper;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class VerblijfplaatsOnbekendInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, VerblijfplaatsOnbekendInOnderzoek?>
{
    public VerblijfplaatsOnbekendInOnderzoek? Convert(GbaInOnderzoek source, VerblijfplaatsOnbekendInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            _ => null,
        };
    }
}
