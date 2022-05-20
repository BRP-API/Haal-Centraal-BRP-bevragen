using AutoMapper;
using HC = HaalCentraal.BrpProxy.Generated;
using Gba = HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class WaardetabelProfile : Profile
{
    public WaardetabelProfile()
    {
        CreateMap<Gba.Waardetabel, HC.Waardetabel>();
    }
}
