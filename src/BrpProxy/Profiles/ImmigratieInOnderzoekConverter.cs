using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles
{
    public class ImmigratieInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, ImmigratieInOnderzoek?>
    {
        public ImmigratieInOnderzoek? Convert(GbaInOnderzoek source, ImmigratieInOnderzoek? destination, ResolutionContext context)
        {
            return source?.AanduidingGegevensInOnderzoek switch
            {
                "080000" or
                "081400" => new ImmigratieInOnderzoek
                {
                    LandVanwaarIngeschreven = true,
                    DatumVestigingInNederland = true,
                    IndicatieVestigingVanuitBuitenland = true,
                    VanuitVerblijfplaatsOnbekend = true,
                    DatumIngangOnderzoek = source.DatumIngangOnderzoek?.Map()
                },
                "081410" => new ImmigratieInOnderzoek
                {
                    LandVanwaarIngeschreven = true,
                    VanuitVerblijfplaatsOnbekend = true,
                    DatumIngangOnderzoek = source.DatumIngangOnderzoek?.Map()
                },
                "081420" => new ImmigratieInOnderzoek
                {
                    DatumVestigingInNederland = true,
                    IndicatieVestigingVanuitBuitenland = true,
                    DatumIngangOnderzoek = source.DatumIngangOnderzoek?.Map()
                },
                _ => null,
            };
        }
    }
}