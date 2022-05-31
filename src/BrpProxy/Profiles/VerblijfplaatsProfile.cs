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

        CreateMap<GbaVerblijfplaats, VerblijfadresBuitenland>()
            .ForMember(dest => dest.Land, opt =>
            {
                opt.PreCondition(src => src.Land?.Code != "0000");
            })
            ;

        CreateMap<GbaVerblijfplaats, VerblijfadresBinnenland>()
            .ForMember(dest => dest.Straat, opt =>
            {
                opt.PreCondition(src => src.Straat != ".");
                opt.MapFrom(src => src.MapStraat());
            })
            .ForMember(dest => dest.KorteNaam, opt => opt.MapFrom(src => src.Straat))
            .ForMember(dest => dest.Woonplaats, opt =>
            {
                opt.PreCondition(src => src.Woonplaats != ".");
                opt.MapFrom(src => src.Woonplaats);
            })
            ;

        CreateMap<GbaVerblijfplaats, VerblijfadresLocatie>();

        CreateMap<GbaVerblijfplaats, VerblijfplaatsOnbekend>()
            .ForMember(dest => dest.DatumVan, opt => opt.MapFrom(src => src.MapDatumVan()))
            .ForMember(dest => dest.DatumIngangGeldigheid, opt => opt.MapFrom(src => src.DatumIngangGeldigheid.Map()))
            ;

        CreateMap<GbaVerblijfplaats, VerblijfplaatsBuitenland>()
            .ForMember(dest => dest.DatumVan, opt => opt.MapFrom(src => src.DatumAanvangAdresBuitenland.Map()))
            .ForMember(dest => dest.DatumIngangGeldigheid, opt => opt.MapFrom(src => src.DatumIngangGeldigheid.Map()))
            .ForMember(dest => dest.Verblijfadres, opt => opt.MapFrom(src => src))
            ;

        CreateMap<GbaVerblijfplaats, Adres>()
            .ForMember(dest => dest.DatumVan, opt => opt.MapFrom(src => src.DatumAanvangAdreshouding.Map()))
            .ForMember(dest => dest.DatumIngangGeldigheid, opt => opt.MapFrom(src => src.DatumIngangGeldigheid.Map()))
            .ForMember(dest => dest.Verblijfadres, opt => opt.MapFrom(src => src))
            .ForMember(dest => dest.AdresseerbaarObjectIdentificatie, opt =>
            {
                opt.PreCondition(src => src.AdresseerbaarObjectIdentificatie != "0000000000000000");
                opt.MapFrom(src => src.AdresseerbaarObjectIdentificatie);
            })
            .ForMember(dest => dest.NummeraanduidingIdentificatie, opt =>
            {
                opt.PreCondition(src => src.NummeraanduidingIdentificatie != "0000000000000000");
                opt.MapFrom(src => src.NummeraanduidingIdentificatie);
            })
            ;

        CreateMap<GbaVerblijfplaats, Locatie>()
            .ForMember(dest => dest.DatumVan, opt => opt.MapFrom(src => src.DatumAanvangAdreshouding.Map()))
            .ForMember(dest => dest.DatumIngangGeldigheid, opt => opt.MapFrom(src => src.DatumIngangGeldigheid.Map()))
            .ForMember(dest => dest.Verblijfadres, opt => opt.MapFrom(src => src))
            ;

        CreateMap<GbaVerblijfplaatsBeperkt, AbstractVerblijfplaatsBeperkt>().ConvertUsing<VerblijfplaatsBeperktConverter>();
    }
}
