using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

//public class GezagsverhoudingInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, GezagsverhoudingInOnderzoek?>
//{
//    public GezagsverhoudingInOnderzoek? Convert(GbaInOnderzoek source, GezagsverhoudingInOnderzoek? destination, ResolutionContext context)
//    {
//        return source?.AanduidingGegevensInOnderzoek switch
//        {
//            "110000" => new GezagsverhoudingInOnderzoek
//            {
//                IndicatieGezagMinderjarige = true,
//                IndicatieCurateleRegister = true,
//                DatumIngangOnderzoek = source.DatumIngangOnderzoek?.Map()
//            },
//            "113200" or "113210" => new GezagsverhoudingInOnderzoek
//            {
//                IndicatieGezagMinderjarige = true,
//                DatumIngangOnderzoek = source.DatumIngangOnderzoek?.Map()
//            },
//            "113300" or "113310" => new GezagsverhoudingInOnderzoek
//            {
//                IndicatieCurateleRegister= true,
//                DatumIngangOnderzoek = source.DatumIngangOnderzoek?.Map()
//            },
//            _ => null,
//        };
//    }
//}
