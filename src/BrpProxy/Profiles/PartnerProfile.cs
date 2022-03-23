using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class PartnerProfile : Profile
{
    public PartnerProfile()
    {
        CreateMap<GbaPartner, AbstractPartner>()
            .ConvertUsing<PartnerConverter>();
        CreateMap<GbaPartner, Partner>();
        CreateMap<GbaAangaanHuwelijkPartnerschap, AangaanHuwelijkPartnerschap>()
            .ForMember(dest => dest.Datum, opt => opt.MapFrom(src => src.Datum.Map()));
    }
}
