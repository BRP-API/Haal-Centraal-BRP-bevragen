using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class OpschortingBijhoudingProfile : Profile
{
    public OpschortingBijhoudingProfile()
    {
        CreateMap<GbaOpschortingBijhouding, OpschortingBijhouding>()
            .ForMember(dest => dest.Datum, opt => opt.MapFrom(src => src.Datum.Map()));
    }
}
