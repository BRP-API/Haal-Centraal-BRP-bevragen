using AutoMapper;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class VerblijfplaatsBeperktConverter : ITypeConverter<GbaVerblijfplaatsBeperkt, AbstractVerblijfplaatsBeperkt?>
{
    private static bool VerblijfBuitenlandIsOnbekend(GbaVerblijfplaatsBeperkt source)
    {
        return
            (source.Land == null || source.Land.Code == "0000") &&
            string.IsNullOrWhiteSpace(source.Regel1) &&
            string.IsNullOrWhiteSpace(source.Regel2) &&
            string.IsNullOrWhiteSpace(source.Regel3)
            ;
    }

    private static bool AdresIsOnbekend(GbaVerblijfplaatsBeperkt source)
    {
        return
            (string.IsNullOrWhiteSpace(source.Straat) || source.Straat == ".") &&
            source.Huisnummer == 0 &&
            string.IsNullOrWhiteSpace(source.Huisletter) &&
            string.IsNullOrWhiteSpace(source.Huisnummertoevoeging) &&
            source.AanduidingBijHuisnummer == null &&
            string.IsNullOrWhiteSpace(source.Postcode) &&
            (string.IsNullOrWhiteSpace(source.Woonplaats) || source.Woonplaats == ".")
            ;
    }

    private static bool LocatieIsOnbekend(GbaVerblijfplaatsBeperkt source)
    {
        return string.IsNullOrWhiteSpace(source.Locatiebeschrijving);
    }

    public AbstractVerblijfplaatsBeperkt? Convert(GbaVerblijfplaatsBeperkt source, AbstractVerblijfplaatsBeperkt? destination, ResolutionContext context)
    {
        if (source == null) return null;
        if (VerblijfBuitenlandIsOnbekend(source) &&
            AdresIsOnbekend(source) &&
            LocatieIsOnbekend(source))
        {
            return context.Mapper.Map<VerblijfplaatsOnbekendBeperkt>(source);
        }
        if (!VerblijfBuitenlandIsOnbekend(source))
        {
            return context.Mapper.Map<VerblijfplaatsBuitenlandBeperkt>(source);
        }
        if (!AdresIsOnbekend(source))
        {
            return context.Mapper.Map<AdresBeperkt>(source);
        }
        if (!LocatieIsOnbekend(source))
        {
            return context.Mapper.Map<LocatieBeperkt>(source);
        }
        return null;
    }
}
