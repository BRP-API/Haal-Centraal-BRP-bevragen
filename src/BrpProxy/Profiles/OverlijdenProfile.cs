using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class OverlijdenProfile : Profile
{
    public OverlijdenProfile()
    {
        CreateMap<GbaOverlijden, Overlijden>()
            .ForMember(dest => dest.Datum, opt => opt.MapFrom(src => src.Datum.Map()))
            .ForMember(dest => dest.Land, opt =>
            {
                opt.PreCondition(src => src.Land?.Code != "0000");
                opt.MapFrom(src => src.Land);
            })
            .ForMember(dest => dest.Plaats, opt =>
            {
                opt.PreCondition(src => src.Plaats?.Code != "0000");
                opt.MapFrom(src => src.Plaats);
            })
            ;

        CreateMap<GbaInOnderzoek, OverlijdenInOnderzoek?>().ConvertUsing<OverlijdenInOnderzoekConverter>();
    }
}
