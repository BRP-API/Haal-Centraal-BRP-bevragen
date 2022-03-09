using AutoMapper;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class PersoonProfile : Profile
{
    public PersoonProfile()
    {
        CreateMap<GbaPersoonBeperkt, PersoonBeperkt>();
        CreateMap<GbaPersoon, Persoon>();
    }
}
