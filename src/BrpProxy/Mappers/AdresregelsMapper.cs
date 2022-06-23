using HaalCentraal.BrpProxy.Generated;
using System.Text;
using System.Text.RegularExpressions;

namespace BrpProxy.Mappers;

public static class AdresregelsMapper
{
    public static string? Adresregel1(this AbstractVerblijfplaats verblijfplaats)
    {
        return verblijfplaats switch
        {
            Adres a => a.Adresregel1(),
            Locatie l => l.Adresregel1(),
            VerblijfplaatsBuitenland b => b.Adresregel1(),
            _ => null
        };
    }

    public static string? Adresregel1(this AbstractVerblijfplaatsBeperkt verblijfplaats)
    {
        return verblijfplaats switch
        {
            AdresBeperkt a => a.Adresregel1(),
            LocatieBeperkt l => l.Adresregel1(),
            VerblijfplaatsBuitenlandBeperkt b => b.Adresregel1(),
            _ => null
        };
    }

    private static string? Adresregel1(this Adres verblijfplaats)
    {
        return verblijfplaats.Verblijfadres.Adresregel1();
    }

    private static string? Adresregel1(this AdresBeperkt verblijfplaats)
    {
        return verblijfplaats.Verblijfadres?.Adresregel1();
    }

    private static string? Adresregel1(this VerblijfadresBinnenland adres)
    {
        if (string.IsNullOrWhiteSpace(adres.KorteNaam) ||
            string.IsNullOrWhiteSpace(adres.Postcode) ||
            adres.Huisnummer == 0)
        {
            return null;
        }

        StringBuilder retval = new();

        if (!string.IsNullOrWhiteSpace(adres.KorteNaam))
        {
            retval.Append(adres.KorteNaam);
        }
        if (adres.AanduidingBijHuisnummer != null)
        {
            switch (adres.AanduidingBijHuisnummer.Code)
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
        if (adres.Huisnummer > 0)
        {
            retval.AppendFormat("{1}{0}", adres.Huisnummer,
                retval.Length > 0
                    ? " "
                    : "");
        }
        if (!string.IsNullOrWhiteSpace(adres.Huisletter))
        {
            retval.AppendFormat(" {0}", adres.Huisletter);
        }
        if (!string.IsNullOrWhiteSpace(adres.Huisnummertoevoeging))
        {
            if (!string.IsNullOrWhiteSpace(adres.Huisletter))
            {
                retval.Append(adres.Huisnummertoevoeging);
            }
            else
            {
                retval.AppendFormat("{1}{0}", adres.Huisnummertoevoeging,
                    Regex.Match(adres.Huisnummertoevoeging, @"^\d.*$").Success
                        ? "-"
                        : " ");
            }
        }

        return retval.ToString();
    }

    private static string? Adresregel1(this Locatie verblijfplaats)
    {
        return verblijfplaats.Verblijfadres.Locatiebeschrijving;
    }

    private static string? Adresregel1(this LocatieBeperkt? verblijfplaats)
    {
        return verblijfplaats?.Verblijfadres?.Locatiebeschrijving;
    }

    private static string? Adresregel1(this VerblijfplaatsBuitenland verblijfplaats)
    {
        return verblijfplaats.Verblijfadres.Adresregel1();
    }

    private static string? Adresregel1(this VerblijfplaatsBuitenlandBeperkt verblijfplaats)
    {
        return verblijfplaats.Verblijfadres.Adresregel1();
    }

    private static string? Adresregel1(this VerblijfadresBuitenland? adres)
    {
        return
            adres?.Land != null &&
            (!string.IsNullOrWhiteSpace(adres.Regel1) ||
            !string.IsNullOrWhiteSpace(adres.Regel2) ||
            !string.IsNullOrWhiteSpace(adres.Regel3))
            ? adres.Regel1
            : null;
    }

    public static string? Adresregel2(this AbstractVerblijfplaats verblijfplaats, IWaardetabel gemeenteVanInschrijving)
    {
        return verblijfplaats switch
        {
            Adres a => a.Adresregel2(gemeenteVanInschrijving),
            Locatie l => l.Adresregel2(gemeenteVanInschrijving),
            VerblijfplaatsBuitenland b => b.Adresregel2(),
            _ => null
        };
    }

    public static string? Adresregel2(this AbstractVerblijfplaatsBeperkt verblijfplaats, IWaardetabel? gemeenteVanInschrijving)
    {
        return verblijfplaats switch
        {
            AdresBeperkt a => a.Adresregel2(gemeenteVanInschrijving),
            LocatieBeperkt l => l.Adresregel2(gemeenteVanInschrijving),
            VerblijfplaatsBuitenlandBeperkt b => b.Adresregel2(),
            _ => null
        };
    }

    private static string? Adresregel2(this Adres verblijfplaats, IWaardetabel? gemeenteVanInschrijving)
    {
        return verblijfplaats.Verblijfadres.Adresregel2(gemeenteVanInschrijving);
    }

    private static string? Adresregel2(this AdresBeperkt verblijfplaats, IWaardetabel? gemeenteVanInschrijving)
    {
        return verblijfplaats.Verblijfadres?.Adresregel2(gemeenteVanInschrijving);
    }

    private static string? Adresregel2(this VerblijfadresBinnenland adres, IWaardetabel? gemeenteVanInschrijving)
    {
        if (string.IsNullOrWhiteSpace(adres.KorteNaam) ||
            string.IsNullOrWhiteSpace(adres.Postcode) ||
            adres.Huisnummer == 0)
        {
            return null;
        }

        var postcodeNum = adres.Postcode != null ? adres.Postcode[0..4] : String.Empty;
        var postcodeAlfa = adres.Postcode != null ? adres.Postcode[4..] : String.Empty;

        return !string.IsNullOrWhiteSpace(adres.Woonplaats)
            ? $"{postcodeNum} {postcodeAlfa}  {adres.Woonplaats.ToUpperInvariant()}"
            : $"{postcodeNum} {postcodeAlfa}  {gemeenteVanInschrijving?.Omschrijving?.ToUpperInvariant()}";
    }

    private static string? Adresregel2(this Locatie verblijfplaats, IWaardetabel? gemeenteVanInschrijving)
    {
        return gemeenteVanInschrijving?.Omschrijving.ToUpperInvariant();
    }

    private static string? Adresregel2(this LocatieBeperkt verblijfplaats, IWaardetabel? gemeenteVanInschrijving)
    {
        return gemeenteVanInschrijving?.Omschrijving.ToUpperInvariant();
    }

    private static string? Adresregel2(this VerblijfplaatsBuitenland verblijfplaats)
    {
        return verblijfplaats.Verblijfadres.Adresregel2();
    }

    private static string? Adresregel2(this VerblijfplaatsBuitenlandBeperkt verblijfplaats)
    {
        return verblijfplaats.Verblijfadres.Adresregel2();
    }

    private static string? Adresregel2(this VerblijfadresBuitenland? adres)
    {
        return
            adres?.Land != null &&
            (!string.IsNullOrWhiteSpace(adres.Regel1) ||
            !string.IsNullOrWhiteSpace(adres.Regel2) ||
            !string.IsNullOrWhiteSpace(adres.Regel3))
            ? adres.Regel2
            : null;
    }

    public static string? Adresregel3(this AbstractVerblijfplaats verblijfplaats)
    {
        return verblijfplaats switch
        {
            VerblijfplaatsBuitenland b => b.Verblijfadres.Adresregel3(),
            _ => null
        };
    }

    public static string? Adresregel3(this AbstractVerblijfplaatsBeperkt verblijfplaats)
    {
        return verblijfplaats switch
        {
            VerblijfplaatsBuitenlandBeperkt b => b.Verblijfadres?.Adresregel3(),
            _ => null
        };
    }

    private static string? Adresregel3(this VerblijfadresBuitenland adres)
    {
        return
            adres.Land != null &&
            (!string.IsNullOrWhiteSpace(adres.Regel1) ||
            !string.IsNullOrWhiteSpace(adres.Regel2) ||
            !string.IsNullOrWhiteSpace(adres.Regel3))
            ? adres.Regel3
            : null;
    }

    public static Waardetabel? Land(this AbstractVerblijfplaats verblijfplaats)
    {
        return verblijfplaats switch
        {
            VerblijfplaatsBuitenland b => b.Verblijfadres.Land(),
            _ => null
        };
    }

    public static Waardetabel? Land(this AbstractVerblijfplaatsBeperkt verblijfplaats)
    {
        return verblijfplaats switch
        {
            VerblijfplaatsBuitenlandBeperkt b => b.Verblijfadres?.Land(),
            _ => null
        };
    }

    private static Waardetabel? Land(this VerblijfadresBuitenland adres)
    {
        return
            adres.Land != null &&
            (!string.IsNullOrWhiteSpace(adres.Regel1) ||
            !string.IsNullOrWhiteSpace(adres.Regel2) ||
            !string.IsNullOrWhiteSpace(adres.Regel3))
            ? adres.Land
            : null;
    }
}
