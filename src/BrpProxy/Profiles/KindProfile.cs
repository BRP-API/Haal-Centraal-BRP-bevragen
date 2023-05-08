using AutoMapper;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles
{
    public class KindProfile : Profile
    {
        public KindProfile()
        {
            CreateMap<GbaKind, Kind>()
                .BeforeMap((src, dest) =>
                {
                    if (src.Naam != null || src.InOnderzoek != null)
                    {
                        src.Naam ??= new GbaNaamBasis();
                        src.Naam.InOnderzoek = src.InOnderzoek;
                    }
                    if (src.Geboorte != null || src.InOnderzoek != null)
                    {
                        src.Geboorte ??= new GbaGeboorte();
                        src.Geboorte.InOnderzoek = src.InOnderzoek;
                    }
                });

            CreateMap<GbaInOnderzoek, KindInOnderzoek?>().ConvertUsing<KindInOnderzoekConverter>();
        }
    }
}
