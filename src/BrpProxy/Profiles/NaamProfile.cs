using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class NaamProfile : Profile
{
    public NaamProfile()
    {
        CreateMap<GbaNaamBasis, NaamBasis>();
        CreateMap<GbaNaamPersoon, NaamPersoon>()
            .ForMember(dest => dest.Voorletters, opt => opt.MapFrom(src => src.Voorletters()));
    }
}
