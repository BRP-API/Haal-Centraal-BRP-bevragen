using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class OntbondenPartnerInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, OntbindingHuwelijkPartnerschapInOnderzoek?>
{
    public OntbindingHuwelijkPartnerschapInOnderzoek? Convert(GbaInOnderzoek source, OntbindingHuwelijkPartnerschapInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "050000" or
            "050700" or
            "050710" => new OntbindingHuwelijkPartnerschapInOnderzoek
            {
                Datum = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            _ => null
        };
    }
}