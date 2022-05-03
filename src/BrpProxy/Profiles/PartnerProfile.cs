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

        CreateMap<GbaPartner, Partner>()
            .BeforeMap((src, dest) =>
            {
                if(src.Naam != null)
                {
                    src.Naam.InOnderzoek = src.InOnderzoek;
                }
                if(src.Geboorte != null)
                {
                    src.Geboorte.InOnderzoek = src.InOnderzoek;
                }
                if(src.AangaanHuwelijkPartnerschap != null)
                {
                    src.AangaanHuwelijkPartnerschap.InOnderzoek = src.InOnderzoek;
                }
            })
            .ForMember(dest => dest.SoortVerbintenis, opt =>
            {
                opt.PreCondition(src => src.SoortVerbintenis?.Code != ".");
                opt.MapFrom(src => src.SoortVerbintenis);
            });

        CreateMap<GbaPartner, OntbondenPartner>();

        CreateMap<GbaAangaanHuwelijkPartnerschap, AangaanHuwelijkPartnerschap>()
            .ForMember(dest => dest.Datum, opt => opt.MapFrom(src => src.Datum.Map()))
            .ForMember(dest => dest.Land, opt =>
            {
                opt.PreCondition(src => src.Land?.Code != "0000");
                opt.MapFrom(src => src.Land);
            })
           .ForMember(dest => dest.Plaats, opt =>
            {
                opt.PreCondition(src => src.Plaats?.Code != "0000");
                opt.MapFrom(src => src.Plaats);
            })
           .ForMember(dest => dest.InOnderzoek, opt => opt.MapFrom(src => src.InOnderzoek.AangaanHuwelijkPartnerschapInOnderzoek()))
            ;

        CreateMap<GbaInOnderzoek, PartnerInOnderzoek?>().ConvertUsing<PartnerInOnderzoekConverter>();
    }
}
