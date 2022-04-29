using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Mappers;

public static class NationaliteitMapper
{
    public static NationaliteitInOnderzoek? NationaliteitInOnderzoek(this GbaInOnderzoek? source)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "040000" => new NationaliteitInOnderzoek
            {
                Nationaliteit = true,
                RedenOpname = true,
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            "040500" or "040510" => new NationaliteitInOnderzoek
            {
                Nationaliteit = true,
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()

            },
            "046300" or "046310" => new NationaliteitInOnderzoek
            {
                RedenOpname = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()

            },
            _ => null
        };
    }

    public static NationaliteitOnbekendInOnderzoek? NationaliteitOnbekendInOnderzoek(this GbaInOnderzoek? source)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "040000" => new NationaliteitOnbekendInOnderzoek
            {
                RedenOpname = true,
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            "040500" or "040510" => new NationaliteitOnbekendInOnderzoek
            {
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()

            },
            "046300" or "046310" => new NationaliteitOnbekendInOnderzoek
            {
                RedenOpname = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()

            },
            _ => null
        };
    }

    public static BijzonderNederlanderschapInOnderzoek? BijzonderNederlanderschapInOnderzoek(this GbaInOnderzoek? source)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "040000" => new BijzonderNederlanderschapInOnderzoek
            {
                RedenOpname = true,
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            "040500" or
            "040510" or
            "046500" or
            "046510" => new BijzonderNederlanderschapInOnderzoek
            {
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()

            },
            "046300" or "046310" => new BijzonderNederlanderschapInOnderzoek
            {
                RedenOpname = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()

            },
            _ => null
        };
    }
}
