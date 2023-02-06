using AutoMapper;
namespace BrpProxy.Profiles;

public class RniProfile : Profile
{
	public RniProfile()
	{
		CreateMap<HaalCentraal.BrpProxy.Generated.Gba.RniDeelnemer, HaalCentraal.BrpProxy.Generated.RniDeelnemer>();
	}
}
