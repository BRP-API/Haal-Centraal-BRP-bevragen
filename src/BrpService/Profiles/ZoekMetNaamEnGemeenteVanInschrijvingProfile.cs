using AutoMapper;
using HaalCentraal.BrpService.Generated;
using HaalCentraal.BrpService.Repositories;

namespace HaalCentraal.BrpService.Profiles;

public class ZoekMetNaamEnGemeenteVanInschrijvingProfile : Profile
{
    public ZoekMetNaamEnGemeenteVanInschrijvingProfile()
    {
        CreateMap<ZoekMetNaamEnGemeenteVanInschrijving, ZoekMetNaamEnGemeenteVanInschrijvingFilter>();
    }
}
