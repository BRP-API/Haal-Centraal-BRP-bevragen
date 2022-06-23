using AutoMapper;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class OntbondenPartnerInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, OntbindingHuwelijkPartnerschapInOnderzoek?>
{
    public OntbindingHuwelijkPartnerschapInOnderzoek? Convert(GbaInOnderzoek source, OntbindingHuwelijkPartnerschapInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            _ => null
        };
    }
}