using AutoMapper;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles
{
    public class KindProfile : Profile
    {
        public KindProfile()
        {
            CreateMap<GbaKind, AbstractKind>()
                .ConvertUsing<KindConverter>();
            CreateMap<GbaKind, KindOnbekend>();
            CreateMap<GbaKind, Kind>();
        }
    }
}
