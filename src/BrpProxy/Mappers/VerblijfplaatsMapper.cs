using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;
using System.Text;
using System.Text.RegularExpressions;

namespace BrpProxy.Mappers;

public static class VerblijfplaatsMapper
{
    public static string? MapWoonplaats(this GbaVerblijfplaats verblijfplaats)
    {
        return !string.IsNullOrWhiteSpace(verblijfplaats.Woonplaats)
            ? verblijfplaats.Woonplaats
            : verblijfplaats.GemeenteVanInschrijving?.Omschrijving;
    }

    public static string? MapStraat(this GbaVerblijfplaats verblijfplaats)
    {
        return !string.IsNullOrWhiteSpace(verblijfplaats.NaamOpenbareRuimte)
            ? verblijfplaats.NaamOpenbareRuimte
            : verblijfplaats.Straat;
    }

    public static string? MapAdresregel1(this GbaVerblijfplaats verblijfplaats)
    {
        StringBuilder retval = new();

        if(!string.IsNullOrWhiteSpace(verblijfplaats.Straat))
        {
            retval.Append(verblijfplaats.Straat);
        }
        if (verblijfplaats.AanduidingBijHuisnummer != null)
        {
            switch (verblijfplaats.AanduidingBijHuisnummer.Code)
            {
                case "to":
                    retval.Append(" t/o");
                    break;
                case "by":
                    retval.Append(" bij");
                    break;
                default:
                    break;
            }
        }
        if(verblijfplaats.Huisnummer > 0)
        {
            retval.AppendFormat("{1}{0}", verblijfplaats.Huisnummer,
                retval.Length > 0
                    ? " "
                    : "");
        }
        if (!string.IsNullOrWhiteSpace(verblijfplaats.Huisletter))
        {
            retval.AppendFormat(" {0}", verblijfplaats.Huisletter);
        }
        if (!string.IsNullOrWhiteSpace(verblijfplaats.Huisnummertoevoeging))
        {
            if (!string.IsNullOrWhiteSpace(verblijfplaats.Huisletter))
            {
                retval.Append(verblijfplaats.Huisnummertoevoeging);
            }
            else
            {
                retval.AppendFormat("{1}{0}", verblijfplaats.Huisnummertoevoeging,
                    Regex.Match(verblijfplaats.Huisnummertoevoeging, @"^\d.*$").Success
                        ? "-"
                        : " ");
            }
        }

        return retval.ToString();
    }

    public static string? MapAdresregel2(this GbaVerblijfplaats verblijfplaats)
    {
        var postcodeNum = verblijfplaats.Postcode != null ? verblijfplaats.Postcode[0..4] : String.Empty;
        var postcodeAlfa = verblijfplaats.Postcode != null ? verblijfplaats.Postcode[4..] : String.Empty;

        return $"{postcodeNum} {postcodeAlfa}  {verblijfplaats.MapWoonplaats()?.ToUpperInvariant()}";
    }

    public static string? MapLocatieAdresregel2(this GbaVerblijfplaats verblijfplaats)
    {
        return verblijfplaats.MapWoonplaats()?.ToUpperInvariant();
    }

    public static AbstractVerblijfplaatsBeperkt? Map(this GbaVerblijfplaatsBeperkt verblijfplaats)
    {
        if (verblijfplaats == null)
        {
            return null;
        }
        if (!string.IsNullOrWhiteSpace(verblijfplaats.Locatiebeschrijving))
        {
            return new LocatieBeperkt
            {
                Locatiebeschrijving = verblijfplaats.Locatiebeschrijving,
                Woonplaats = verblijfplaats.GemeenteVanInschrijving.Omschrijving
            };
        }
        return new AdresBeperkt
        {
            Woonplaats = verblijfplaats?.Woonplaats
        };
    }
}
