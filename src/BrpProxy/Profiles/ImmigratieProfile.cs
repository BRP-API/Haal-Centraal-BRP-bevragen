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
            ;
    }
}
