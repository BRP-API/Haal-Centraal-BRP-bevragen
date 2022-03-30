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
                if (src.Geboorte != null)
                {
                    src.Geboorte.InOnderzoek = src.InOnderzoek;
                }
            })
            .ForMember(dest => dest.DatumEersteInschrijvingGBA, opt => opt.MapFrom(src => src.DatumEersteInschrijvingGBA.Map()))
            .ForMember(dest => dest.GeheimhoudingPersoonsgegevens, opt => opt.MapFrom(src => src.Geheimhouding()));
        CreateMap<GbaInOnderzoek, PersoonInOnderzoek?>().ConvertUsing<PersoonInOnderzoekConverter>();
    }
}
