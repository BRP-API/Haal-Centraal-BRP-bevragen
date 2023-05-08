using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class ImmigratieProfile : Profile
{
    public ImmigratieProfile()
    {
        CreateMap<GbaImmigratie, Immigratie>()
            .ForMember(dest => dest.DatumVestigingInNederland, opt => opt.MapFrom(src => src.DatumVestigingInNederland.Map()))
            .ForMember(dest => dest.LandVanwaarIngeschreven, opt =>
            {
                opt.Condition(src => src.LandVanwaarIngeschreven?.Code != "0000");
            })
            .ForMember(dest => dest.IndicatieVestigingVanuitBuitenland, opt =>
            {
                opt.Condition(src => !string.IsNullOrWhiteSpace(src.DatumVestigingInNederland));
                opt.MapFrom(src => true);
            })
            .ForMember(dest => dest.VanuitVerblijfplaatsOnbekend, opt =>
            {
                opt.Condition(src => src.LandVanwaarIngeschreven?.Code == "0000");
                opt.MapFrom(src => true);
            })
            ;

        CreateMap<GbaInOnderzoek, ImmigratieInOnderzoek?>().ConvertUsing<ImmigratieInOnderzoekConverter>();
    }
}
