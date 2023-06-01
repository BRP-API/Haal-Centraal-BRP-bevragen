using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class AdresInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, AdresInOnderzoek?>
{
    public AdresInOnderzoek? Convert(GbaInOnderzoek source, AdresInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "080000" or
            "089999" => new AdresInOnderzoek
            {
                AdresseerbaarObjectIdentificatie = true,
                DatumIngangGeldigheid = true,
                DatumVan = true,
                FunctieAdres = true,
                NummeraanduidingIdentificatie = true,
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081000" => new AdresInOnderzoek
            {
                DatumVan = true,
                FunctieAdres = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081010" => new AdresInOnderzoek
            {
                FunctieAdres = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081030" or
            "081320" => new AdresInOnderzoek
            {
                DatumVan = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081100" => new AdresInOnderzoek
            {
                AdresseerbaarObjectIdentificatie = true,
                NummeraanduidingIdentificatie = true,
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081110" => new AdresInOnderzoek
            {
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081180" => new AdresInOnderzoek
            {
                AdresseerbaarObjectIdentificatie = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081190" => new AdresInOnderzoek
            {
                NummeraanduidingIdentificatie = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081300" => new AdresInOnderzoek
            {
                DatumVan = true,
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "088500" or
            "088510" => new AdresInOnderzoek
            {
                DatumIngangGeldigheid = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            _ => null,
        };
    }
}

public class VerblijfadresBinnenlandInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, VerblijfadresBinnenlandInOnderzoek?>
{
    public VerblijfadresBinnenlandInOnderzoek? Convert(GbaInOnderzoek source, VerblijfadresBinnenlandInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "080000" or
            "081100" or
            "089999" => new VerblijfadresBinnenlandInOnderzoek
            {
                AanduidingBijHuisnummer = true,
                Huisletter = true,
                Huisnummer = true,
                Huisnummertoevoeging = true,
                KorteStraatnaam = true,
                Postcode = true,
                OfficieleStraatnaam = true,
                Woonplaats = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "080900" or
            "080910" => new VerblijfadresBinnenlandInOnderzoek
            {
                Woonplaats = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081110" => new VerblijfadresBinnenlandInOnderzoek
            {
                KorteStraatnaam = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081115" => new VerblijfadresBinnenlandInOnderzoek
            {
                OfficieleStraatnaam = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081120" => new VerblijfadresBinnenlandInOnderzoek
            {
                Huisnummer = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081130" => new VerblijfadresBinnenlandInOnderzoek
            {
                Huisletter = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081140" => new VerblijfadresBinnenlandInOnderzoek
            {
                Huisnummertoevoeging = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081150" => new VerblijfadresBinnenlandInOnderzoek
            {
                AanduidingBijHuisnummer = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081160" => new VerblijfadresBinnenlandInOnderzoek
            {
                Postcode = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081170" => new VerblijfadresBinnenlandInOnderzoek
            {
                Woonplaats = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            _ => null,
        };
    }
}

public class VerblijfplaatsBuitenlandInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, VerblijfplaatsBuitenlandInOnderzoek?>
{
    public VerblijfplaatsBuitenlandInOnderzoek? Convert(GbaInOnderzoek source, VerblijfplaatsBuitenlandInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "080000" => new VerblijfplaatsBuitenlandInOnderzoek
            {
                DatumIngangGeldigheid = true,
                DatumVan = true,
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081300" => new VerblijfplaatsBuitenlandInOnderzoek
            {
                DatumVan = true,
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081310" => new VerblijfplaatsBuitenlandInOnderzoek
            {
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081320" => new VerblijfplaatsBuitenlandInOnderzoek
            {
                DatumVan = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "088500" or
            "088510" => new VerblijfplaatsBuitenlandInOnderzoek
            {
                DatumIngangGeldigheid = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            _ => null,
        };
    }
}

public class VerblijfadresBuitenlandInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, VerblijfadresBuitenlandInOnderzoek?>
{
    public VerblijfadresBuitenlandInOnderzoek? Convert(GbaInOnderzoek source, VerblijfadresBuitenlandInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "080000" or
            "081300"=> new VerblijfadresBuitenlandInOnderzoek
            {
                Regel1 = true,
                Regel2 = true,
                Regel3 = true,
                Land = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081310" => new VerblijfadresBuitenlandInOnderzoek
            {
                Land = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081330" => new VerblijfadresBuitenlandInOnderzoek
            {
                Regel1 = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081340" => new VerblijfadresBuitenlandInOnderzoek
            {
                Regel2 = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081350" => new VerblijfadresBuitenlandInOnderzoek
            {
                Regel3 = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            _ => null,
        };
    }
}

public class LocatieInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, LocatieInOnderzoek?>
{
    public LocatieInOnderzoek? Convert(GbaInOnderzoek source, LocatieInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "080000" or
            "089999" => new LocatieInOnderzoek
            {
                DatumIngangGeldigheid = true,
                DatumVan = true,
                FunctieAdres = true,
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081000" => new LocatieInOnderzoek
            {
                DatumVan = true,
                FunctieAdres = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081010" => new LocatieInOnderzoek
            {
                FunctieAdres = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081030" => new LocatieInOnderzoek
            {
                DatumVan = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081200" or
            "081210" => new LocatieInOnderzoek
            {
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "088500" or
            "088510" => new LocatieInOnderzoek
            {
                DatumIngangGeldigheid = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            _ => null,
        };
    }
}

public class VerblijfadresLocatieInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, VerblijfadresLocatieInOnderzoek?>
{
    public VerblijfadresLocatieInOnderzoek? Convert(GbaInOnderzoek source, VerblijfadresLocatieInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "080000" or
            "081200" or
            "081210" or
            "089999" => new VerblijfadresLocatieInOnderzoek
            {
                Locatiebeschrijving = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            _ => null,
        };
    }
}

public class VerblijfplaatsOnbekendInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, VerblijfplaatsOnbekendInOnderzoek?>
{
    public VerblijfplaatsOnbekendInOnderzoek? Convert(GbaInOnderzoek source, VerblijfplaatsOnbekendInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "080000" => new VerblijfplaatsOnbekendInOnderzoek
            {
                DatumIngangGeldigheid = true,
                DatumVan = true,
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081300" => new VerblijfplaatsOnbekendInOnderzoek
            {
                DatumVan = true,
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081310" => new VerblijfplaatsOnbekendInOnderzoek
            {
                Type = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "081320" => new VerblijfplaatsOnbekendInOnderzoek
            {
                DatumVan = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            "088500" or
            "088510" => new VerblijfplaatsOnbekendInOnderzoek
            {
                DatumIngangGeldigheid = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
            },
            _ => null,
        };
    }
}
