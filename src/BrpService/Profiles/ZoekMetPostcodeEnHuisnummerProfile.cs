using AutoMapper;
using HaalCentraal.BrpService.Generated;
using HaalCentraal.BrpService.Repositories;
using System.Text.RegularExpressions;

namespace HaalCentraal.BrpService.Profiles;

public class ZoekMetPostcodeEnHuisnummerProfile : Profile
{
    public ZoekMetPostcodeEnHuisnummerProfile()
    {
        CreateMap<ZoekMetPostcodeEnHuisnummer, ZoekMetPostcodeEnHuisnummerFilter>()
            .ForMember(dest => dest.Postcode, opt => opt.MapFrom(src => Regex.Replace(src.Postcode!.ToUpperInvariant(), @"\s+", "")))
            .ForMember(dest => dest.Huisnummer, opt => opt.MapFrom(src => int.Parse(src.Huisnummer!)));
    }
}
