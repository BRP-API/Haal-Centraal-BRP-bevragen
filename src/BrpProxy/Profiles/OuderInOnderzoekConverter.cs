using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class OuderInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, OuderInOnderzoek?>
{
    public OuderInOnderzoek? Convert(GbaInOnderzoek source, OuderInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "020000" or
            "030000" => new OuderInOnderzoek
            {
                Burgerservicenummer = true,
                Geslacht = true,
                DatumIngangFamilierechtelijkeBetrekking = true,
                DatumIngangOnderzoek = source.DatumIngangOnderzoek?.Map()
            },
            "020100" or
            "020120" or
            "030100" or
            "030120" => new OuderInOnderzoek
            {
                Burgerservicenummer = true,
                DatumIngangOnderzoek = source.DatumIngangOnderzoek?.Map()
            },
            "020400" or
            "020410" or
            "030400" or
            "030410" => new OuderInOnderzoek
            {
                Geslacht = true,
                DatumIngangOnderzoek = source.DatumIngangOnderzoek?.Map()
            },
            "026200" or
            "026210" or
            "036200" or
            "036210" => new OuderInOnderzoek
            {
                DatumIngangFamilierechtelijkeBetrekking = true,
                DatumIngangOnderzoek = source.DatumIngangOnderzoek?.Map()
            },
            _ => null,
        };
    }
}
