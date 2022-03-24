using AutoMapper;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class NationaliteitProfile : Profile
{
    public NationaliteitProfile()
    {
        CreateMap<GbaNationaliteit, AbstractNationaliteit?>().ConvertUsing<NationaliteitConverter>();
        CreateMap<GbaNationaliteit, Nationaliteit>()
            .ForMember(dest => dest.Nationaliteit1, opt => opt.MapFrom(src => src.Nationaliteit));
        CreateMap<GbaNationaliteit, BehandeldAlsNederlander>();
        CreateMap<GbaNationaliteit, VastgesteldNietNederlander>();
    }
}
