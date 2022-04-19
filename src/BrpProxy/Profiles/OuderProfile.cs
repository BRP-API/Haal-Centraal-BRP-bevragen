using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class OuderProfile : Profile
{
    public OuderProfile()
    {
        CreateMap<GbaOuder, AbstractOuder>()
            .ConvertUsing<OuderConverter>();
        CreateMap<GbaOuder, OuderOnbekend>();
        CreateMap<GbaOuder, Ouder>()
            .ForMember(dest => dest.DatumIngangFamilierechtelijkeBetrekking, opt => opt.MapFrom(src => src.DatumIngangFamilierechtelijkeBetrekking.Map()));
    }
}
