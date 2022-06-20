using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class OuderProfile : Profile
{
    public OuderProfile()
    {
        CreateMap<GbaOuder, Ouder>()
            .BeforeMap((src, dest) =>
            {
                if (src.Naam != null)
                {
                    src.Naam.InOnderzoek = src.InOnderzoek;
                }
                if (src.Geboorte != null)
                {
                    src.Geboorte.InOnderzoek = src.InOnderzoek;
                }
            })
            .ForMember(dest => dest.DatumIngangFamilierechtelijkeBetrekking, opt => opt.MapFrom(src => src.DatumIngangFamilierechtelijkeBetrekking.Map()))
            ;

        CreateMap<GbaInOnderzoek, OuderInOnderzoek?>().ConvertUsing<OuderInOnderzoekConverter>();
    }
}
