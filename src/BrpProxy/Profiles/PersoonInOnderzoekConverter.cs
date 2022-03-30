using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class PersoonInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, PersoonInOnderzoek?>
{
    public PersoonInOnderzoek? Convert(GbaInOnderzoek source, PersoonInOnderzoek? destination, ResolutionContext context)
    {
        return source.AanduidingGegevensInOnderzoek switch
        {
            "010000" => new PersoonInOnderzoek
            {
                Burgerservicenummer = true,
                Geslachtsaanduiding = true,
                DatumIngangOnderzoek = source.DatumIngangOnderzoek?.Map()
            },
            "010100" or "010120" => new PersoonInOnderzoek
            {
                Burgerservicenummer = true,
                DatumIngangOnderzoek = source.DatumIngangOnderzoek?.Map()
            },
            "010400" or "010410" => new PersoonInOnderzoek
            {
                Geslachtsaanduiding = true,
                DatumIngangOnderzoek = source.DatumIngangOnderzoek?.Map()
            },
            _ => null,
        };
    }
}
