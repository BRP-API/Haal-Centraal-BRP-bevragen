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
            .ForMember(dest => dest.RedenOpname, opt =>
            {
                opt.PreCondition(src => src.RedenOpname?.Code != "000");
                opt.MapFrom(src => src.RedenOpname);
            });

        CreateMap<GbaNationaliteit, BehandeldAlsNederlander>();
        CreateMap<GbaNationaliteit, VastgesteldNietNederlander>();

        CreateMap<GbaNationaliteit, NationaliteitOnbekend>()
            .ForMember(dest => dest.DatumIngangGeldigheid, opt => opt.MapFrom(src => src.DatumIngangGeldigheid.Map()));
    }
}
