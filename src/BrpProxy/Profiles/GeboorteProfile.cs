using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class GeboorteProfile : Profile
{
    public GeboorteProfile()
    {
        CreateMap<GbaGeboorteBeperkt, GeboorteBeperkt>()
            .ForMember(dest => dest.Datum, opt => opt.MapFrom(src => src.Datum.Map()));
    }
}
