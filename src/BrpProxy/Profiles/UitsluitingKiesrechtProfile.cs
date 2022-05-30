using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class UitsluitingKiesrechtProfile : Profile
{
    public UitsluitingKiesrechtProfile()
    {
        CreateMap<GbaUitsluitingKiesrecht, UitsluitingKiesrecht>()
            .ForMember(dest => dest.Einddatum, opt => opt.MapFrom(src => src.Einddatum.Map()));
    }
}
