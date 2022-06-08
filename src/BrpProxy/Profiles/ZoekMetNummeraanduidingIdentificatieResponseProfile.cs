using AutoMapper;
using HC = HaalCentraal.BrpProxy.Generated;
using Gba = HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class ZoekMetNummeraanduidingIdentificatieResponseProfile : Profile
{
    public ZoekMetNummeraanduidingIdentificatieResponseProfile()
    {
        CreateMap<Gba.ZoekMetNummeraanduidingIdentificatieResponse, HC.ZoekMetNummeraanduidingIdentificatieResponse>();
    }
}
