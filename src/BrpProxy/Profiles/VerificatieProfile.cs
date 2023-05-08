using AutoMapper;
using BrpProxy.Mappers;

namespace BrpProxy.Profiles;

public class VerificatieProfile : Profile
{
    public VerificatieProfile()
    {
        CreateMap<HaalCentraal.BrpProxy.Generated.Gba.GbaVerificatie, HaalCentraal.BrpProxy.Generated.Verificatie>()
            .ForMember(dest => dest.Datum, opt => opt.MapFrom(src => src.Datum.Map()))
            ;
    }
}
