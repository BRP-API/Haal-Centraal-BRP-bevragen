using AutoMapper;
using HC = HaalCentraal.BrpProxy.Generated;
using Gba = HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class ZoekMetStraatHuisnummerEnGemeenteVanInschrijvingResponseProfile : Profile
{
    public ZoekMetStraatHuisnummerEnGemeenteVanInschrijvingResponseProfile()
    {
        CreateMap<Gba.ZoekMetStraatHuisnummerEnGemeenteVanInschrijvingResponse, HC.ZoekMetStraatHuisnummerEnGemeenteVanInschrijvingResponse>();
    }
}
