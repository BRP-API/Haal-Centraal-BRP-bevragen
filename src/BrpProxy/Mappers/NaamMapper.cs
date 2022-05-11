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

    private static bool IsMan(this GBA.Waardetabel geslacht) => geslacht?.Code.ToUpperInvariant() == "M";

    private static bool IsMan(this AbstractPartner? partner) =>
        partner is Partner p &&
        p.Geslacht != null &&
        p.Geslacht.Code == "M";

    private static bool IsVrouw(this GBA.Waardetabel geslacht) => geslacht?.Code.ToUpperInvariant() == "V";

    private static bool IsVrouw(this NaamPersoon naam) =>
        naam.Geslacht != null &&
        naam.Geslacht.Code == "V";

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

    public static string Voorletters(this GbaNaamPersoon naam) => naam.Voornamen.MapNaarVoorletters();

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

    private static AbstractPartner? SelecteerLaatstOntbondenPartnerRelatie(this IEnumerable<AbstractPartner>? partners)
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
        // Rule 650
        var partner = partners.SelecteerOudstePartnerRelatie();
        if (partner == null)
        {
            // Rule 692
            partner = partners.SelecteerLaatstOntbondenPartnerRelatie();
        }
        return partner;
    }

    private static bool HeeftLeegOfOnbekendGeslachtsnaam(this NaamPersoon naam) => string.IsNullOrWhiteSpace(naam.Geslachtsnaam);

    private static bool HeeftPartnerNaamgebruik(this NaamPersoon naam) =>
        naam.AanduidingNaamgebruik != null &&
        naam.AanduidingNaamgebruik.Code == "P";

    private static bool HeeftGeenPartnerNaamgebruik(this NaamPersoon naam) => !naam.HeeftPartnerNaamgebruik();

    private static bool HeeftEigenNaamgebruik(this NaamPersoon naam) =>
        naam.AanduidingNaamgebruik != null &&
        naam.AanduidingNaamgebruik.Code == "E";

    private static bool GebruiktNaamVanPartner(this NaamPersoon naam) => !naam.HeeftEigenNaamgebruik();

    private static bool HeeftPredicaat(this NaamPersoon naam) =>
        !string.IsNullOrWhiteSpace(naam.AdellijkeTitelPredicaat.Code) &&
        Predicaten.ContainsKey(naam.AdellijkeTitelPredicaat.Code);

    private static bool HeeftHoffelijkheidsTitel(this NaamPersoon naam) =>
        !string.IsNullOrWhiteSpace(naam.AdellijkeTitelPredicaat.Code) &&
        HoffelijkheidsTitels.ContainsKey(naam.AdellijkeTitelPredicaat.Code);

    private static bool HeeftGeenHoffelijkheidsTitel(this NaamPersoon naam) => !naam.HeeftHoffelijkheidsTitel();

    private static bool HeeftAdellijkeTitelOfPredicaat(this NaamPersoon persoon) => persoon.AdellijkeTitelPredicaat != null;

    private static bool HeeftGeenAdellijkeTitelOfPredicaat(this NaamPersoon persoon) => !persoon.HeeftAdellijkeTitelOfPredicaat();

    private static bool HeeftAdellijkeTitel(this AbstractPartner? partner) =>
        partner is Partner p &&
        p.Naam.AdellijkeTitelPredicaat != null &&
        AdellijkeTitels.ContainsKey(p.Naam.AdellijkeTitelPredicaat.Code);

    private static string AdellijkeTitelPredicaat(this AbstractPartner? partner) =>
        partner is Partner p && p.Naam.AdellijkeTitelPredicaat != null
            ? p.Naam.AdellijkeTitelPredicaat.Code
            : String.Empty;

    private static bool IsExPartner(this AbstractPartner? partner) => partner is OntbondenPartner;

    private static bool IsActueelPartner(this AbstractPartner? partner) => !partner.IsExPartner();

    private static bool HeeftAdellijkeTitelMetAanspreekvorm(this NaamPersoon persoon)
    {
        var aanhefKey = $"{persoon.AdellijkeTitelPredicaat.Code}-{persoon.Geslacht!.Code}";

        return AanhefAdellijkeTitelPredicaat.ContainsKey(aanhefKey);
    }

    private static bool HeeftGeenAdellijkeTitelMetAanspreekvorm(this NaamPersoon persoon) => !persoon.HeeftAdellijkeTitelMetAanspreekvorm();

    private static string BepaalAanhefVoorAdellijkeTitelOfPredicaat(this NaamPersoon persoon)
    {
        var aanhefKey = $"{persoon.AdellijkeTitelPredicaat.Code}-{persoon.Geslacht!.Code}";

        return AanhefAdellijkeTitelPredicaat[aanhefKey];
    }

    private static bool HeeftHoffelijkheidstitelMetAanspreekvorm(this AbstractPartner? partner) =>
        partner != null &&
        HoffelijkheidsTitels.ContainsKey(partner.AdellijkeTitelPredicaat());

    public static string? Aanhef(this NaamPersoon persoon)
    {
        var partner = persoon.Partners.ActuelePartner();

        // Rule 423 en Rule 871 (874-876)
        if (persoon.HeeftGeenAdellijkeTitelOfPredicaat() &&
            partner.HeeftAdellijkeTitel() &&
            persoon.IsVrouw() &&
            persoon.GebruiktNaamVanPartner())
        {
            // Rule 427
            return partner.HeeftHoffelijkheidstitelMetAanspreekvorm()
                ? HoffelijkheidsTitels[partner.AdellijkeTitelPredicaat()]
                : persoon.BepaalAanhefZonderAdellijkeTitelOfPredicaat(partner);
        }

        if (persoon.HeeftAdellijkeTitelOfPredicaat())
        {
            // Rule 786
            if (persoon.HeeftLeegOfOnbekendGeslachtsnaam() &&
                persoon.HeeftGeenPartnerNaamgebruik() &&
                (persoon.HeeftPredicaat() || persoon.HeeftGeenAdellijkeTitelMetAanspreekvorm()) &&
                persoon.HeeftGeenHoffelijkheidsTitel()
                )
            {
                return null;
            }

            // Rule 550
            if (partner.HeeftAdellijkeTitel() &&
                persoon.IsVrouw() &&
                partner.IsMan() &&
                persoon.GebruiktNaamVanPartner() &&
                partner.HeeftHoffelijkheidstitelMetAanspreekvorm()
                )
            {
                return HoffelijkheidsTitels[partner.AdellijkeTitelPredicaat()];
            }

            // Rule 211
            if (partner != null &&
                persoon.HeeftPartnerNaamgebruik()
                ) return persoon.BepaalAanhefZonderAdellijkeTitelOfPredicaat(partner);

            // Rule 212
            if (persoon.HeeftPredicaat() &&
                persoon.IsVrouw() &&
                partner.IsActueelPartner()
                ) return persoon.BepaalAanhefZonderAdellijkeTitelOfPredicaat(partner);

            // Rule 213
            if (persoon.HeeftPredicaat() &&
                persoon.IsVrouw() &&
                partner.IsExPartner() &&
                persoon.GebruiktNaamVanPartner()
                ) return persoon.BepaalAanhefZonderAdellijkeTitelOfPredicaat(partner);

            // Rule 210
            return persoon.HeeftAdellijkeTitelMetAanspreekvorm()
                ? persoon.BepaalAanhefVoorAdellijkeTitelOfPredicaat()
                : persoon.BepaalAanhefZonderAdellijkeTitelOfPredicaat(partner);
        }

        return persoon.BepaalAanhefZonderAdellijkeTitelOfPredicaat(partner);
    }

    private static bool IsLeegOfOnbekend(this string partnerNaam) => string.IsNullOrWhiteSpace(partnerNaam);

    private static string? BepaalAanhefZonderAdellijkeTitelOfPredicaat(this NaamPersoon persoon, AbstractPartner? partner)
    {
        // Rule 788 en 789
        if (persoon.HeeftLeegOfOnbekendGeslachtsnaam() &&
            persoon.HeeftGeenPartnerNaamgebruik())
        {
            return null;
        }

        var partnerNaam = partner switch
        {
            Partner p => p.Naam.Achternaam(),
            OntbondenPartner p => p.Naam.Achternaam(),
            _ => ""
        };
        var persoonNaam = persoon.Achternaam();

        // Rule 871 (872-873)
        var geslachtsnaam = persoon.AanduidingNaamgebruik?.Code switch
        {
            "E" => persoonNaam,
            "N" => partnerNaam.IsLeegOfOnbekend() ? persoonNaam : $"{persoonNaam}-{partnerNaam}",
            "V" => partnerNaam.IsLeegOfOnbekend() ? persoonNaam : $"{partnerNaam}-{persoonNaam}",
            "P" => partnerNaam.IsLeegOfOnbekend() ? persoonNaam : partnerNaam,
            _ => persoonNaam
        };

        // Rule 17
        var retval = persoon.Geslacht?.Code switch
        {
            "M" => $"Geachte heer {geslachtsnaam.Capitalize()}",
            "V" => $"Geachte mevrouw {geslachtsnaam.Capitalize()}",
            "O" => !string.IsNullOrWhiteSpace(persoon.Voorletters)
                ? $"Geachte {persoon.Voorletters} {geslachtsnaam}"
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
