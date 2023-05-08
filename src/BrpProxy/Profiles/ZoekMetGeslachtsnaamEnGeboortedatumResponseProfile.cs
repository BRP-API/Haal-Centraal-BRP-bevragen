using AutoMapper;
using HC = HaalCentraal.BrpProxy.Generated;
using Gba = HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class ZoekMetGeslachtsnaamEnGeboortedatumResponseProfile : Profile
{
    public ZoekMetGeslachtsnaamEnGeboortedatumResponseProfile()
    {
        CreateMap<Gba.ZoekMetGeslachtsnaamEnGeboortedatumResponse, HC.ZoekMetGeslachtsnaamEnGeboortedatumResponse>();
    }
}
