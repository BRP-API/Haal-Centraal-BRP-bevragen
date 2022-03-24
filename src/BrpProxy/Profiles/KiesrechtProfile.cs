using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class KiesrechtProfile : Profile
{
    public KiesrechtProfile()
    {
        CreateMap<GbaKiesrecht, Kiesrecht>()
            .ForMember(dest => dest.EinddatumUitsluitingEuropeesKiesrecht, opt => opt.MapFrom(src => src.EinddatumUitsluitingEuropeesKiesrecht.Map()))
            .ForMember(dest => dest.EinddatumUitsluitingKiesrecht, opt => opt.MapFrom(src => src.EinddatumUitsluitingKiesrecht.Map()));
    }
}
