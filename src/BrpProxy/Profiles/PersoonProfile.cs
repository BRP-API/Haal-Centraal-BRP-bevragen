using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class PersoonProfile : Profile
{
    public PersoonProfile()
    {
        CreateMap<GbaPersoonBeperkt, PersoonBeperkt>();

        CreateMap<GbaPersoon, Persoon>()
            .BeforeMap((src, dest) =>
            {
                if(src.Naam != null)
                {
                    if(src.Geslacht != null)
                    {
                        src.Naam.Geslacht = src.Geslacht;
                    }
                    src.Naam.InOnderzoek = src.InOnderzoek;
                }
                if (src.Geboorte != null)
                {
                    src.Geboorte.InOnderzoek = src.InOnderzoek;
                }
            })
            .AfterMap((src, dest) =>
            {
                if(dest.Kiesrecht != null && dest.Kiesrecht.EinddatumUitsluitingKiesrecht <= DateTime.Today)
                {
                    dest.Kiesrecht = null;
                }
            })
            .ForMember(dest => dest.DatumEersteInschrijvingGBA, opt => opt.MapFrom(src => src.DatumEersteInschrijvingGBA.Map()))
            .ForMember(dest => dest.GeheimhoudingPersoonsgegevens, opt => opt.MapFrom(src => src.Geheimhouding()))
            .ForMember(dest => dest.Leeftijd, opt =>
            {
                opt.PreCondition(src => src.Overlijden == null);
                opt.MapFrom(src => src.Geboorte.Datum.Map().Leeftijd());
            })
            .ForMember(dest => dest.Reisdocumentnummers, opt => opt.MapFrom(src => src.Reisdocumentnummers.FilterOnbekendReisdocumentnummers()));

        CreateMap<GbaInOnderzoek, PersoonInOnderzoek?>().ConvertUsing<PersoonInOnderzoekConverter>();
    }
}
