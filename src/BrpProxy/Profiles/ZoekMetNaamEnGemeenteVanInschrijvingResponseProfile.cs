using AutoMapper;
using HC = HaalCentraal.BrpProxy.Generated;
using Gba = HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class ZoekMetNaamEnGemeenteVanInschrijvingResponseProfile : Profile
{
    public ZoekMetNaamEnGemeenteVanInschrijvingResponseProfile()
    {
        CreateMap<Gba.ZoekMetNaamEnGemeenteVanInschrijvingResponse, HC.ZoekMetNaamEnGemeenteVanInschrijvingResponse>();
    }
}
