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
            .ForMember(dest => dest.GemeenteVanInschrijving, opt => {
                opt.PreCondition(src => src.GemeenteVanInschrijving?.Code != "0000");
                opt.MapFrom(src => src.GemeenteVanInschrijving.Code);
            })
            .ForMember(dest => dest.VerblijfplaatsOnbekend1, opt => opt.MapFrom(src => true));

        CreateMap<GbaVerblijfplaats, VerblijfplaatsBuitenland>()
            .ForMember(dest => dest.DatumInschrijvingInGemeente, opt => opt.MapFrom(src => src.DatumInschrijvingInGemeente.Map()))
            .ForMember(dest => dest.DatumVan, opt => opt.MapFrom(src => src.DatumAanvangAdresBuitenland.Map()))
            .ForMember(dest => dest.Adresregel1, opt => opt.MapFrom(src => src.Adresregel1))
            .ForMember(dest => dest.Adresregel2, opt => opt.MapFrom(src => src.Adresregel2))
            .ForMember(dest => dest.Adresregel3, opt => opt.MapFrom(src => src.Adresregel3))
            .ForMember(dest => dest.GemeenteVanInschrijving, opt =>
            {
                opt.PreCondition(src => src.GemeenteVanInschrijving?.Code != "0000");
                opt.MapFrom(src => src.GemeenteVanInschrijving);
            });

        CreateMap<GbaVerblijfplaats, Adres>()
            .ForMember(dest => dest.Adresregel1, opt => opt.MapFrom(src => src.MapAdresregel1()))
            .ForMember(dest => dest.Adresregel2, opt => opt.MapFrom(src => src.MapAdresregel2()))
            .ForMember(dest => dest.AdresseerbaarObjectIdentificatie, opt =>
            {
                opt.PreCondition(src => src.AdresseerbaarObjectIdentificatie != "0000000000000000");
                opt.MapFrom(src => src.AdresseerbaarObjectIdentificatie);
            })
            .ForMember(dest => dest.DatumIngangGeldigheid, opt => opt.MapFrom(src => src.DatumIngangGeldigheid.Map()))
            .ForMember(dest => dest.DatumInschrijvingInGemeente, opt => opt.MapFrom(src => src.DatumInschrijvingInGemeente.Map()))
            .ForMember(dest => dest.DatumVan, opt => opt.MapFrom(src => src.DatumAanvangAdreshouding.Map()))
            .ForMember(dest => dest.DatumVestigingInNederland, opt => opt.MapFrom(src => src.DatumVestigingInNederland.Map()))
            .ForMember(dest => dest.GemeenteVanInschrijving, opt =>
            {
                opt.PreCondition(src => src.GemeenteVanInschrijving?.Code != "0000");
                opt.MapFrom(src => src.GemeenteVanInschrijving);
            })
            .ForMember(dest => dest.IndicatieVestigingVanuitBuitenland, opt => {
                opt.PreCondition(src => !string.IsNullOrWhiteSpace(src.LandVanwaarIngeschreven?.Code));
                opt.MapFrom(src => true);
            })
            .ForMember(dest => dest.KorteNaam, opt => opt.MapFrom(src => src.Straat))
            .ForMember(dest => dest.LandVanwaarIngeschreven, opt =>
            {
                opt.PreCondition(src => src.LandVanwaarIngeschreven?.Code != "0000");
                opt.MapFrom(src => src.LandVanwaarIngeschreven);
            })
            .ForMember(dest => dest.NummeraanduidingIdentificatie, opt =>
            {
                opt.PreCondition(src => src.NummeraanduidingIdentificatie != "0000000000000000");
                opt.MapFrom(src => src.NummeraanduidingIdentificatie);
            })
            .ForMember(dest => dest.Straat, opt =>
            {
                opt.PreCondition(src => src.Straat != ".");
                opt.MapFrom(src => src.MapStraat());
            })
            .ForMember(dest => dest.VanuitVerblijfplaatsOnbekend, opt => {
                opt.PreCondition(src => src.LandVanwaarIngeschreven?.Code == "0000");
                opt.MapFrom(src => true);
            })
            .ForMember(dest => dest.Woonplaats, opt => {
                opt.PreCondition(src => src.Woonplaats != ".");
                opt.MapFrom(src => src.MapWoonplaats());
            });

        CreateMap<GbaVerblijfplaats, Locatie>()
            .ForMember(dest => dest.DatumVan, opt => opt.MapFrom(src => src.DatumAanvangAdreshouding.Map()))
            .ForMember(dest => dest.DatumInschrijvingInGemeente, opt => opt.MapFrom(src => src.DatumInschrijvingInGemeente.Map()))
            .ForMember(dest => dest.Woonplaats, opt => opt.MapFrom(src => src.MapWoonplaats()))
            .ForMember(dest => dest.Adresregel1, opt => opt.MapFrom(src => src.Locatiebeschrijving))
            .ForMember(dest => dest.Adresregel2, opt => opt.MapFrom(src => src.MapLocatieAdresregel2()))
            .ForMember(dest => dest.GemeenteVanInschrijving, opt =>
             {
                 opt.PreCondition(src => src.GemeenteVanInschrijving?.Code != "0000");
                 opt.MapFrom(src => src.GemeenteVanInschrijving);
             })
            .ForMember(dest => dest.LandVanwaarIngeschreven, opt =>
            {
                opt.PreCondition(src => src.LandVanwaarIngeschreven?.Code != "0000");
                opt.MapFrom(src => src.LandVanwaarIngeschreven);
            });

        CreateMap<GbaVerblijfplaatsBeperkt, AbstractVerblijfplaatsBeperkt>().ConvertUsing<VerblijfplaatsBeperktConverter>();
    }
}
