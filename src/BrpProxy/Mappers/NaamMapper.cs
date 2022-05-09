using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;
using System.Text.RegularExpressions;
using GBA = HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Mappers;

public static class NaamMapper
{
    private const string JONKVROUW = "jonkvrouw";
    private const string JONKHEER = "jonkheer";
    private const string BARONES = "barones";
    private const string BARON = "baron";
    private const string GRAVIN = "gravin";
    private const string GRAAF = "graaf";
    private const string HERTOGIN = "hertogin";
    private const string HERTOG = "hertog";
    private const string MARKIEZIN = "markiezin";
    private const string MARKIES = "markies";
    private const string PRINSES = "prinses";
    private const string PRINS = "prins";
    private const string RIDDER = "ridder";

    private const string HOOGWELGEBORENHEER = "Hoogwelgeboren heer";
    private const string HOOGWELGEBORENVROUWE = "Hoogwelgeboren vrouwe";
    private const string HOOGGEBORENHEER = "Hooggeboren heer";
    private const string HOOGGEBORENVROUWE = "Hooggeboren vrouwe";
    private const string HOOGHEID = "Hoogheid";

    private static readonly Dictionary<string, string> AdellijkeTitels = new ()
    {
        { "B", BARON },
        { "BS", BARONES },
        { "G", GRAAF },
        { "GI", GRAVIN },
        { "H", HERTOG },
        { "HI", HERTOGIN },
        { "M", MARKIES },
        { "MI", MARKIEZIN },
        { "P", PRINS },
        { "PS", PRINSES },
        { "R", RIDDER }
    };
    private static readonly Dictionary<string, string> Predicaten = new ()
    {
        { "JH", JONKHEER },
        { "JV", JONKVROUW }
    };
    private static readonly Dictionary<string, string> AanhefAdellijkeTitelPredicaat = new ()
    {
        { "B-M", HOOGWELGEBORENHEER },
        { "BS-M", HOOGWELGEBORENHEER },
        { "B-V", HOOGWELGEBORENVROUWE },
        { "BS-V", HOOGWELGEBORENVROUWE },
        { "G-M", HOOGGEBORENHEER },
        { "GI-M", HOOGGEBORENHEER },
        { "G-V", HOOGGEBORENVROUWE },
        { "GI-V", HOOGGEBORENVROUWE },
        { "H-M", HOOGWELGEBORENHEER },
        { "HI-M", HOOGWELGEBORENHEER },
        { "H-V", HOOGWELGEBORENVROUWE },
        { "HI-V", HOOGWELGEBORENVROUWE },
        { "JH-M", HOOGWELGEBORENHEER },
        { "JV-M", HOOGWELGEBORENHEER },
        { "JH-V", HOOGWELGEBORENVROUWE },
        { "JV-V", HOOGWELGEBORENVROUWE },
        { "M-M", HOOGWELGEBORENHEER },
        { "MI-M", HOOGWELGEBORENHEER },
        { "M-V", HOOGWELGEBORENVROUWE },
        { "MI-V", HOOGWELGEBORENVROUWE },
        { "P-M", HOOGHEID },
        { "PS-M", HOOGHEID },
        { "P-V", HOOGHEID },
        { "PS-V", HOOGHEID },
        { "P-O", HOOGHEID },
        { "PS-O", HOOGHEID },
        { "R-M", HOOGWELGEBORENHEER },
        { "R-V", HOOGWELGEBORENVROUWE },
    };
    private static readonly Dictionary<string, string> HoffelijkheidsTitels = new ()
    {
        { "B", HOOGWELGEBORENVROUWE },
        { "G", HOOGGEBORENVROUWE },
        { "H", HOOGWELGEBORENVROUWE },
        { "M", HOOGWELGEBORENVROUWE },
        { "P", HOOGHEID }
    };

    private static bool IsMan(this GBA.Waardetabel geslacht)
    {
        return geslacht?.Code.ToUpperInvariant() == "M";
    }

    private static bool IsVrouw(this GBA.Waardetabel geslacht)
    {
        return geslacht?.Code.ToUpperInvariant() == "V";
    }

    public static string MapNaarAdellijkeTitel(this AdellijkeTitelPredicaatType waardetabel, GBA.Waardetabel geslacht)
    {
        if (waardetabel == null) return string.Empty;

        return waardetabel.Code switch
        {
            "B"  => AdellijkeTitels[geslacht.IsVrouw() ? "BS" : "B"],
            "BS" => AdellijkeTitels[geslacht.IsMan() ? "B" : "BS"],
            "G"  => AdellijkeTitels[geslacht.IsVrouw() ? "GI" : "G"],
            "GI" => AdellijkeTitels[geslacht.IsMan() ? "G" : "GI"],
            "H"  => AdellijkeTitels[geslacht.IsVrouw() ? "HI" : "H"],
            "HI" => AdellijkeTitels[geslacht.IsMan() ? "H" : "HI"],
            "M"  => AdellijkeTitels[geslacht.IsVrouw() ? "MI" : "M"],
            "MI" => AdellijkeTitels[geslacht.IsMan() ? "M" : "MI"],
            "P"  => AdellijkeTitels[geslacht.IsVrouw() ? "PS" : "P"],
            "PS" => AdellijkeTitels[geslacht.IsMan() ? "P" : "PS"],
            "R" => AdellijkeTitels["R"],
            _ => string.Empty,
        };
    }

    public static string MapNaarPredicaat(this AdellijkeTitelPredicaatType waardetabel, GBA.Waardetabel geslacht)
    {
        if (waardetabel == null) return string.Empty;

        return waardetabel.Code switch
        {
            "JH" => geslacht.IsVrouw() ? JONKVROUW : JONKHEER,
            "JV" => geslacht.IsMan() ? JONKHEER : JONKVROUW,
            _ => string.Empty,
        };
    }

    public static string VolledigeNaam(this GbaNaamPersoon naam, GBA.Waardetabel geslacht)
    {
        var adellijkeTitel = naam.AdellijkeTitelPredicaat.MapNaarAdellijkeTitel(geslacht);
        var predikaat = naam.AdellijkeTitelPredicaat.MapNaarPredicaat(geslacht);

        return Regex.Replace($"{predikaat} {naam.Voornamen} {adellijkeTitel} {naam.Voorvoegsel} {naam.Geslachtsnaam}", @"\s+", " ").Trim();
    }

    public static string Voorletters(this GbaNaamPersoon naam)
    {
        return naam.Voornamen.MapNaarVoorletters();
    }

    private static string MapNaarVoorletters(this string voornamen)
    {
        if (string.IsNullOrWhiteSpace(voornamen) ||
            voornamen == ".")
        {
            return voornamen;
        }

        var voorletters = from voornaam in voornamen.Split(" ")
                          select voornaam.Trim().Length > 1
                             ? voornaam[..1] + "."
                             : voornaam + " ";
        return string.Join("", voorletters).Trim();
    }

    private static AbstractPartner? SelecteerOudstePartnerRelatie(this IEnumerable<AbstractPartner>? partners)
    {
        if (partners == null) return null;

        Partner? retval = null;

        foreach (var partner in partners)
        {
            if(partner is Partner p)
            {
                if(retval == null)
                {
                    retval = p;
                }
                else if(p.AangaanHuwelijkPartnerschap.Datum < retval.AangaanHuwelijkPartnerschap.Datum)
                {
                    retval = p;
                }
            }
        }

        return retval;
    }

    private static AbstractPartner? SelecteerJongsteOntbondenPartnerRelatie(this IEnumerable<AbstractPartner>? partners)
    {
        if (partners == null) return null;

        OntbondenPartner? retval = null;

        foreach (var partner in partners)
        {
            if (partner is OntbondenPartner p)
            {
                if (retval == null)
                {
                    retval = p;
                }
                else if (p.OntbindingHuwelijkPartnerschap!.Datum > retval.OntbindingHuwelijkPartnerschap!.Datum)
                {
                    retval = p;
                }
            }
        }

        return retval;
    }

    private static AbstractPartner? ActuelePartner(this IEnumerable<AbstractPartner>? partners)
    {
        var partner = partners.SelecteerOudstePartnerRelatie();
        if (partner == null)
        {
            partner = partners.SelecteerJongsteOntbondenPartnerRelatie();
        }
        return partner;
    }

    private static bool HeeftLeegOfOnbekendGeslachtsnaam(this NaamPersoon naam)
    {
        return string.IsNullOrWhiteSpace(naam.Geslachtsnaam);
    }

    private static bool HeeftNaamgebruikOngelijkAanPartner(this NaamPersoon naam)
    {
        return naam.AanduidingNaamgebruik?.Code != "P";
    }

    private static bool HeeftGeenPredicaat(this NaamPersoon naam)
    {
        return !string.IsNullOrWhiteSpace(naam.AdellijkeTitelPredicaat.Code) &&
               !Predicaten.ContainsKey(naam.AdellijkeTitelPredicaat.Code);
    }

    private static bool HeeftAdellijkeTitelPredicaat(this AbstractPartner? partner)
    {
        return partner is Partner p && p.Naam.AdellijkeTitelPredicaat != null;
    }

    private static string AdellijkeTitelPredicaat(this AbstractPartner? partner)
    {
        return partner is Partner p && p.Naam.AdellijkeTitelPredicaat != null
            ? p.Naam.AdellijkeTitelPredicaat.Code
            : String.Empty;
    }

    public static string? Aanhef(this NaamPersoon naam)
    {
        var partner = naam.Partners.ActuelePartner();

        var geslacht = naam.Geslacht != null
            ? naam.Geslacht.Code
            : "O";

        if (naam.AdellijkeTitelPredicaat == null &&
            partner.HeeftAdellijkeTitelPredicaat() &&
            geslacht == "V" && naam.AanduidingNaamgebruik.Code != "E")
        {
            return HoffelijkheidsTitels.ContainsKey(partner.AdellijkeTitelPredicaat())
                ? HoffelijkheidsTitels[partner.AdellijkeTitelPredicaat()]
                : naam.AanhefZonderTitel(partner);
        }

        if (naam.AdellijkeTitelPredicaat != null)
        {
            var aanhefKey = $"{naam.AdellijkeTitelPredicaat.Code}-{geslacht}";

            if (naam.HeeftLeegOfOnbekendGeslachtsnaam() &&
                naam.HeeftNaamgebruikOngelijkAanPartner() &&
                naam.HeeftGeenPredicaat() &&
                !AanhefAdellijkeTitelPredicaat.ContainsKey(aanhefKey) &&
                !HoffelijkheidsTitels.ContainsKey(naam.AdellijkeTitelPredicaat.Code))
            {
                return null;
            }

            if (partner is Partner p1 &&
                p1.Naam.AdellijkeTitelPredicaat != null &&
                HoffelijkheidsTitels.ContainsKey(p1.Naam.AdellijkeTitelPredicaat.Code) &&
                p1.Geslacht != null && p1.Geslacht.Code == "M" &&
                geslacht == "V" &&
                naam.AanduidingNaamgebruik != null && naam.AanduidingNaamgebruik.Code != "E")
            {
                return HoffelijkheidsTitels[partner.AdellijkeTitelPredicaat()];
            }

            if (partner != null &&
                naam.AanduidingNaamgebruik != null && naam.AanduidingNaamgebruik.Code == "P") return naam.AanhefZonderTitel(partner);

            if (partner != null && geslacht == "V" &&
                naam.AanduidingNaamgebruik != null && naam.AanduidingNaamgebruik.Code != "E") return naam.AanhefZonderTitel(partner);

            return AanhefAdellijkeTitelPredicaat.ContainsKey(aanhefKey)
                ? AanhefAdellijkeTitelPredicaat[aanhefKey]
                : naam.AanhefZonderTitel(partner);
        }

        return naam.AanhefZonderTitel(partner);
    }

    private static string? AanhefZonderTitel(this NaamPersoon naam, AbstractPartner? partner)
    {
        var partnerNaam = partner switch
        {
            Partner p => p.Naam.Achternaam(),
            OntbondenPartner p => p.Naam.Achternaam(),
            _ => ""
        };
        var persoonNaam = naam.Achternaam();
        if(string.IsNullOrWhiteSpace(persoonNaam) && naam.AanduidingNaamgebruik?.Code != "P")
        {
            return null;
        }

        var geslachtsnaam = naam.AanduidingNaamgebruik?.Code switch
        {
            "E" => persoonNaam,
            "N" => partner != null && !string.IsNullOrWhiteSpace(partnerNaam) ? $"{persoonNaam}-{partnerNaam}" : persoonNaam,
            "V" => partner != null && !string.IsNullOrWhiteSpace(partnerNaam) ? $"{partnerNaam}-{persoonNaam}" : persoonNaam,
            "P" => partner != null && !string.IsNullOrWhiteSpace(partnerNaam) ? partnerNaam : persoonNaam,
            _ => persoonNaam
        };

        var retval = naam.Geslacht?.Code switch
        {
            "M" => $"Geachte heer {geslachtsnaam.Capitalize()}",
            "V" => $"Geachte mevrouw {geslachtsnaam.Capitalize()}",
            "O" => !string.IsNullOrWhiteSpace(naam.Voorletters)
                ? $"Geachte {naam.Voorletters} {geslachtsnaam}"
                : $"Geachte {geslachtsnaam.Capitalize()}",
            _ => string.Empty
        };

        return Regex.Replace(retval, @"\s+", " ").Trim().ToNull();
    }

    private static string? ToNull(this string str)
    {
        return string.IsNullOrWhiteSpace(str) ? null : str;
    }

    private static string? Capitalize(this string? str)
    {
        return !string.IsNullOrWhiteSpace(str)
            ? str.Length switch
        {
            1 => str.ToUpperInvariant(),
            _ => $"{char.ToUpperInvariant(str[0])}{str[1..]}"
        }
        : str;
    }

    private static string Achternaam(this INaam? naam)
    {
        return naam != null &&
               !string.IsNullOrWhiteSpace(naam.Geslachtsnaam) &&
               naam.Geslachtsnaam != "."
            ? Regex.Replace($"{naam.Voorvoegsel} {naam.Geslachtsnaam}", @"\s+", " ").Trim()
            : string.Empty;
    }
}
