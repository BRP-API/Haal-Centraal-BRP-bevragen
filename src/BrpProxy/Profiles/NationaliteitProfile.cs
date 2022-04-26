using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class NationaliteitProfile : Profile
{
    public NationaliteitProfile()
    {
        CreateMap<GbaNationaliteit, AbstractNationaliteit?>().ConvertUsing<NationaliteitConverter>();

        CreateMap<GbaNationaliteit, Nationaliteit>()
            .ForMember(dest => dest.Nationaliteit1, opt => opt.MapFrom(src => src.Nationaliteit))
            .ForMember(dest => dest.DatumIngangGeldigheid, opt => opt.MapFrom(src => src.DatumIngangGeldigheid.Map()))
            .ForMember(dest => dest.RedenOpname, opt => opt.PreCondition(src => src.RedenOpname?.Code != "000"))
            .ForMember(dest => dest.InOnderzoek, opt => opt.MapFrom(src => src.InOnderzoek.NationaliteitInOnderzoek()));

        CreateMap<GbaNationaliteit, BehandeldAlsNederlander>()
            .ForMember(dest => dest.DatumIngangGeldigheid, opt => opt.MapFrom(src => src.DatumIngangGeldigheid.Map()))
            .ForMember(dest => dest.RedenOpname, opt => opt.PreCondition(src => src.RedenOpname?.Code != "000"))
            .ForMember(dest => dest.InOnderzoek, opt => opt.MapFrom(src => src.InOnderzoek.BijzonderNederlanderschapInOnderzoek()));

        CreateMap<GbaNationaliteit, VastgesteldNietNederlander>()
            .ForMember(dest => dest.DatumIngangGeldigheid, opt => opt.MapFrom(src => src.DatumIngangGeldigheid.Map()))
            .ForMember(dest => dest.RedenOpname, opt => opt.PreCondition(src => src.RedenOpname?.Code != "000"))
            .ForMember(dest => dest.InOnderzoek, opt => opt.MapFrom(src => src.InOnderzoek.BijzonderNederlanderschapInOnderzoek()));

        CreateMap<GbaNationaliteit, NationaliteitOnbekend>()
            .ForMember(dest => dest.DatumIngangGeldigheid, opt => opt.MapFrom(src => src.DatumIngangGeldigheid.Map()))
            .ForMember(dest => dest.RedenOpname, opt => opt.PreCondition(src => src.RedenOpname?.Code != "000"))
            .ForMember(dest => dest.InOnderzoek, opt => opt.MapFrom(src => src.InOnderzoek.NationaliteitOnbekendInOnderzoek()));
    }
}
