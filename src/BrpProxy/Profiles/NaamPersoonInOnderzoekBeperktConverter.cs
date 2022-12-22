using AutoMapper;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class NaamPersoonInOnderzoekBeperktConverter : ITypeConverter<GbaInOnderzoek, NaamPersoonInOnderzoekBeperkt?>
{
    public NaamPersoonInOnderzoekBeperkt? Convert(GbaInOnderzoek source, NaamPersoonInOnderzoekBeperkt? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            _ => null
        };
    }
}