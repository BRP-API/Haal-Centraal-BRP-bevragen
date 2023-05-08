using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class EuropeesKiesrechtProfile : Profile
{
    public EuropeesKiesrechtProfile()
    {
        CreateMap<GbaEuropeesKiesrecht, EuropeesKiesrecht>()
            .ForMember(dest => dest.EinddatumUitsluiting, opt => opt.MapFrom(src => src.EinddatumUitsluiting.Map()));
    }
}
