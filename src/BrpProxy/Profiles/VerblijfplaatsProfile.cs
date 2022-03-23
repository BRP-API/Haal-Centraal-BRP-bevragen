using AutoMapper;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class VerblijfplaatsProfile : Profile
{
    public VerblijfplaatsProfile()
    {
        CreateMap<GbaVerblijfplaats, AbstractVerblijfplaats>().ConvertUsing<VerblijfplaatsConverter>();
        CreateMap<GbaVerblijfplaatsBeperkt, AbstractVerblijfplaatsBeperkt>().ConvertUsing<VerblijfplaatsBeperktConverter>();
    }
}
