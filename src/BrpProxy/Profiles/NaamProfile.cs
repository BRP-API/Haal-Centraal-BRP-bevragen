using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class NaamProfile : Profile
{
    public NaamProfile()
    {
        CreateMap<GbaNaamBasis, NaamBasis>()
            .ForMember(dest => dest.Voorletters, opt => opt.MapFrom(src => src.Voorletters()))
            .ForMember(dest => dest.Geslachtsnaam, opt =>
            {
                opt.PreCondition(src => src.Geslachtsnaam != ".");
            })
            .AfterMap((src, dest) =>
            {
                dest.VolledigeNaam = dest.VolledigeNaam(dest.Geslacht);
            })
            ;

        CreateMap<GbaNaamBasis, NaamGerelateerde>()
            .ForMember(dest => dest.Voorletters, opt => opt.MapFrom(src => src.Voorletters()))
            .ForMember(dest => dest.Geslachtsnaam, opt =>
            {
                opt.PreCondition(src => src.Geslachtsnaam != ".");
                opt.MapFrom(src => src.Geslachtsnaam);
            })
            ;

        CreateMap<GbaInOnderzoek, NaamInOnderzoek?>().ConvertUsing<NaamGerelateerdeInOnderzoekConverter>();

        CreateMap<GbaNaamPersoon, NaamPersoon>()
            .ForMember(dest => dest.Geslachtsnaam, opt =>
            {
                opt.PreCondition(src => src.Geslachtsnaam != ".");
            })
            .ForMember(dest => dest.Voorletters, opt => opt.MapFrom(src => src.Voorletters()))
            .AfterMap((src, dest) =>
            {
                dest.VolledigeNaam = dest.VolledigeNaam(dest.Geslacht);
            })
            ;

        CreateMap<GbaInOnderzoek, NaamPersoonInOnderzoek?>().ConvertUsing<NaamPersoonInOnderzoekConverter>();
    }
}
