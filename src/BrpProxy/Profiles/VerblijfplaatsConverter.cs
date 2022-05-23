using AutoMapper;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class VerblijfplaatsConverter : ITypeConverter<GbaVerblijfplaats, AbstractVerblijfplaats?>
{
    private static bool VerblijfBuitenlandIsOnbekend(GbaVerblijfplaats source)
    {
        return
            (source.Land == null || source.Land.Code == "0000") &&
            string.IsNullOrWhiteSpace(source.Regel1) &&
            string.IsNullOrWhiteSpace(source.Regel2) &&
            string.IsNullOrWhiteSpace(source.Regel3);
    }

    private static bool AdresIsOnbekend(GbaVerblijfplaats source)
    {
        return
            (string.IsNullOrWhiteSpace(source.Straat) || source.Straat == ".") &&
            string.IsNullOrWhiteSpace(source.NaamOpenbareRuimte) &&
            source.Huisnummer == 0 &&
            string.IsNullOrWhiteSpace(source.Huisletter) &&
            string.IsNullOrWhiteSpace(source.Huisnummertoevoeging) &&
            source.AanduidingBijHuisnummer == null &&
            string.IsNullOrWhiteSpace(source.Postcode) &&
            (string.IsNullOrWhiteSpace(source.Woonplaats) || source.Woonplaats == ".") &&
            (string.IsNullOrWhiteSpace(source.AdresseerbaarObjectIdentificatie) || source.AdresseerbaarObjectIdentificatie == "0000000000000000") &&
            (string.IsNullOrWhiteSpace(source.NummeraanduidingIdentificatie) || source.NummeraanduidingIdentificatie == "0000000000000000");
    }

    private static bool LocatieIsOnbekend(GbaVerblijfplaats source)
    {
        return string.IsNullOrWhiteSpace(source.Locatiebeschrijving);
    }

    public AbstractVerblijfplaats? Convert(GbaVerblijfplaats source, AbstractVerblijfplaats? destination, ResolutionContext context)
    {
        if (source == null) return null;
        if (VerblijfBuitenlandIsOnbekend(source) &&
            AdresIsOnbekend(source) &&
            LocatieIsOnbekend(source))
        {
            return context.Mapper.Map<VerblijfplaatsOnbekend>(source);
        }
        if(!VerblijfBuitenlandIsOnbekend(source))
        {
            return context.Mapper.Map<VerblijfplaatsBuitenland>(source);
        }
        if(!AdresIsOnbekend(source))
        {
            return context.Mapper.Map<Adres>(source);
        }
        if (!LocatieIsOnbekend(source))
        {
            return context.Mapper.Map<Locatie>(source);
        }
        return null;
    }
}
