using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class VerblijfstitelProfile : Profile
{
    public VerblijfstitelProfile()
    {
        CreateMap<GbaVerblijfstitel, Verblijfstitel>()
            .ForMember(dest => dest.DatumEinde, opt => opt.MapFrom(src => src.DatumEinde.Map()))
            .ForMember(dest => dest.DatumIngang, opt => opt.MapFrom(src => src.DatumIngang.Map()));
    }
}
