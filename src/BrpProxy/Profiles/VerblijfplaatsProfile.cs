using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class VerblijfplaatsProfile : Profile
{
    public VerblijfplaatsProfile()
    {
        CreateMap<GbaVerblijfplaats, AbstractVerblijfplaats?>().ConvertUsing<VerblijfplaatsConverter>();
        CreateMap<GbaVerblijfplaats, VerblijfplaatsOnbekend>()
            .ForMember(dest => dest.DatumInschrijvingInGemeente, opt => opt.MapFrom(src => src.DatumInschrijvingInGemeente.Map()))
            .ForMember(dest => dest.GemeenteVanInschrijving, opt => opt.MapFrom(src => src.GemeenteVanInschrijving.Code))
            .ForMember(dest => dest.VerblijfplaatsOnbekend1, opt => opt.MapFrom(src => true));
        CreateMap<GbaVerblijfplaats, VerblijfplaatsBuitenland>()
            .ForMember(dest => dest.DatumInschrijvingInGemeente, opt => opt.MapFrom(src => src.DatumInschrijvingInGemeente.Map()))
            .ForMember(dest => dest.DatumVan, opt => opt.MapFrom(src => src.DatumAanvangAdresBuitenland.Map()));
        CreateMap<GbaVerblijfplaats, Adres>()
            .ForMember(dest => dest.DatumInschrijvingInGemeente, opt => opt.MapFrom(src => src.DatumInschrijvingInGemeente.Map()))
            .ForMember(dest => dest.DatumVan, opt => opt.MapFrom(src => src.DatumAanvangAdreshouding.Map()))
            .ForMember(dest => dest.Woonplaats, opt => opt.MapFrom(src => src.MapWoonplaats()));
        CreateMap<GbaVerblijfplaats, Locatie>()
            .ForMember(dest => dest.DatumInschrijvingInGemeente, opt => opt.MapFrom(src => src.DatumInschrijvingInGemeente.Map()))
            .ForMember(dest => dest.Woonplaats, opt => opt.MapFrom(src => src.MapWoonplaats()))
            //.ForMember(dest => dest.DatumVan, opt => opt.MapFrom(src => src.DatumAanvangAdreshouding.Map()))
            ;

        CreateMap<GbaVerblijfplaatsBeperkt, AbstractVerblijfplaatsBeperkt>().ConvertUsing<VerblijfplaatsBeperktConverter>();
    }
}
