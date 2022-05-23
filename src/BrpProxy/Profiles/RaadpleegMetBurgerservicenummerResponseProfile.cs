using AutoMapper;
using HC = HaalCentraal.BrpProxy.Generated;
using Gba = HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class RaadpleegMetBurgerservicenummerResponseProfile : Profile
{
    public RaadpleegMetBurgerservicenummerResponseProfile()
    {
        CreateMap<Gba.RaadpleegMetBurgerservicenummerResponse, HC.RaadpleegMetBurgerservicenummerResponse>();
    }
}
