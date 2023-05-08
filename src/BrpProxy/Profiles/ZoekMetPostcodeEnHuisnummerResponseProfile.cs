using AutoMapper;
using HC = HaalCentraal.BrpProxy.Generated;
using Gba = HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class ZoekMetPostcodeEnHuisnummerResponseProfile : Profile
{
    public ZoekMetPostcodeEnHuisnummerResponseProfile()
    {
        CreateMap<Gba.ZoekMetPostcodeEnHuisnummerResponse, HC.ZoekMetPostcodeEnHuisnummerResponse>();
    }
}
