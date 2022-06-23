using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class PersoonInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, PersoonInOnderzoek?>
{
    public PersoonInOnderzoek? Convert(GbaInOnderzoek source, PersoonInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "010000" => new PersoonInOnderzoek
            {
                Burgerservicenummer = true,
                Geslacht = true,
                Leeftijd = true,
                DatumIngangOnderzoekPersoon = source.DatumIngangOnderzoek?.Map()
            },
            "010100" or "010120" => new PersoonInOnderzoek
            {
                Burgerservicenummer = true,
                DatumIngangOnderzoekPersoon = source.DatumIngangOnderzoek?.Map()
            },
            "010400" or "010410" => new PersoonInOnderzoek
            {
                Geslacht = true,
                DatumIngangOnderzoekPersoon = source.DatumIngangOnderzoek?.Map()
            },
            _ => null,
        };
    }
}
