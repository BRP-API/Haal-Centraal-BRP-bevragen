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
            .ForMember(dest => dest.DatumVan, opt => opt.MapFrom(src => src.DatumAanvangAdresBuitenland.Map()))
            .ForMember(dest => dest.Adresregel1, opt => opt.MapFrom(src => src.Adresregel1))
            .ForMember(dest => dest.Adresregel2, opt => opt.MapFrom(src => src.Adresregel2))
            .ForMember(dest => dest.Adresregel3, opt => opt.MapFrom(src => src.Adresregel3))
            ;
        CreateMap<GbaVerblijfplaats, Adres>()
            .ForMember(dest => dest.DatumInschrijvingInGemeente, opt => opt.MapFrom(src => src.DatumInschrijvingInGemeente.Map()))
            .ForMember(dest => dest.DatumVan, opt => opt.MapFrom(src => src.DatumAanvangAdreshouding.Map()))
            .ForMember(dest => dest.Woonplaats, opt => opt.MapFrom(src => src.MapWoonplaats()))
            .ForMember(dest => dest.KorteNaam, opt => opt.MapFrom(src => src.Straat))
            .ForMember(dest => dest.Straat, opt => opt.MapFrom(src => src.MapStraat()))
            .ForMember(dest => dest.Adresregel1, opt => opt.MapFrom(src => src.MapAdresregel1()))
            .ForMember(dest => dest.Adresregel2, opt => opt.MapFrom(src => src.MapAdresregel2()));
        CreateMap<GbaVerblijfplaats, Locatie>()
            .ForMember(dest => dest.DatumInschrijvingInGemeente, opt => opt.MapFrom(src => src.DatumInschrijvingInGemeente.Map()))
            .ForMember(dest => dest.Woonplaats, opt => opt.MapFrom(src => src.MapWoonplaats()))
            .ForMember(dest => dest.Adresregel1, opt => opt.MapFrom(src => src.Locatiebeschrijving))
            .ForMember(dest => dest.Adresregel2, opt => opt.MapFrom(src => src.MapLocatieAdresregel2()));
        //.ForMember(dest => dest.DatumVan, opt => opt.MapFrom(src => src.DatumAanvangAdreshouding.Map()))
        ;

        CreateMap<GbaVerblijfplaatsBeperkt, AbstractVerblijfplaatsBeperkt>().ConvertUsing<VerblijfplaatsBeperktConverter>();
    }
}
