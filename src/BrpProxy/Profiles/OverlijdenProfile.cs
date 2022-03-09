using AutoMapper;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class OverlijdenProfile : Profile
{
    public OverlijdenProfile()
    {
        CreateMap<GbaOverlijdenBasis, OverlijdenBasis>();
    }
}
