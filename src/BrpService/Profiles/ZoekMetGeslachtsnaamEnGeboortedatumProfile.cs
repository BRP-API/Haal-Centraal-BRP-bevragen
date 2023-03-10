using AutoMapper;
using HaalCentraal.BrpService.Generated;
using HaalCentraal.BrpService.Repositories;

namespace HaalCentraal.BrpService.Profiles;

public class ZoekMetGeslachtsnaamEnGeboortedatumProfile : Profile
{
    public ZoekMetGeslachtsnaamEnGeboortedatumProfile()
    {
        CreateMap<ZoekMetGeslachtsnaamEnGeboortedatum, ZoekMetGeslachtsnaamEnGeboortedatumFilter>()
            .ForMember(dest => dest.Geboortedatum, opt => opt.MapFrom(src => DateTimeOffset.Parse(src.Geboortedatum!)))
            .ForMember(dest => dest.Geslachtsaanduiding, opt => opt.MapFrom(src => src.Geslacht));
    }
}
