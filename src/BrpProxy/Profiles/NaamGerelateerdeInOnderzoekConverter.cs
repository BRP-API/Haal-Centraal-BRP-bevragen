using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class NaamGerelateerdeInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, NaamInOnderzoek?>
{
    public NaamInOnderzoek? Convert(GbaInOnderzoek source, NaamInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "020000" or
            "020200" or
            "030000" or
            "030200" or
            "050000" or
            "050200" or
            "090000" or
            "090200" => new NaamInOnderzoek
            {
                Voornamen = true,
                AdellijkeTitelPredicaat = true,
                Voorvoegsel = true,
                Geslachtsnaam = true,
                Voorletters = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            "020210" or
            "030210" or
            "050210" or
            "090210" => new NaamInOnderzoek
            {
                Voornamen = true,
                Voorletters = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            "020220" or
            "030220" or
            "050220" or
            "090220" => new NaamInOnderzoek
            {
                AdellijkeTitelPredicaat = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            "020230" or
            "030230" or
            "050230" or
            "090230" => new NaamInOnderzoek
            {
                Voorvoegsel = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            "020240" or
            "030240" or
            "050240" or
            "090240" => new NaamInOnderzoek
            {
                Geslachtsnaam = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            _ => null
        };
    }
}
