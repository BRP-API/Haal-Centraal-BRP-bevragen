using HaalCentraal.BrpProxy.Generated;
using System;
using System.Text.RegularExpressions;

namespace BrpProxy.Mappers;

public static class AanschrijfwijzeMapper
{
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
    private const string JONKVROUW = "jonkvrouw";
    private const string JONKHEER = "jonkheer";

    private static readonly Dictionary<string, string> AdellijkeTitelPredicaten = new()
    {
        { "B-M", BARON },
        { "BS-M", BARON },
        { "B-V", BARONES },
        { "BS-V", BARONES },
        { "G-M", GRAAF },
        { "GI-M", GRAAF },
        { "G-V", GRAVIN },
        { "GI-V", GRAVIN },
        { "H-M", HERTOG },
        { "HI-M", HERTOG },
        { "H-V", HERTOGIN },
        { "HI-V", HERTOGIN },
        { "JH-M", JONKHEER },
        { "JV-M", JONKHEER },
        { "JH-V", JONKVROUW },
        { "JV-V", JONKVROUW },
        { "M-M", MARKIES },
        { "MI-M", MARKIES },
        { "M-V", MARKIEZIN },
        { "MI-V", MARKIEZIN },
        { "P-M", PRINS },
        { "PS-M", PRINS },
        { "P-V", PRINSES },
        { "PS-V", PRINSES },
        { "R-M", RIDDER },
    };

    private const string HOOGWELGEBORENHEER = "De hoogwelgeboren heer";
    private const string HOOGWELGEBORENVROUWE = "De hoogwelgeboren vrouwe";
    private const string HOOGGEBORENHEER = "De hooggeboren heer";
    private const string HOOGGEBORENVROUWE = "De hooggeboren vrouwe";
    private const string HOOGHEID = "De hoogheid";

    private static readonly Dictionary<string, string> AdellijkeTitelPredicaatAanspreekvormen = new()
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
    };

    public static Aanschrijfwijze? Aanschrijfwijze(this NaamPersoon persoon)
    {
        if (persoon == null) return null;

        var partner = persoon.Partners.ActuelePartner();

        if (persoon.HeeftGeenAdellijkeTitelOfPredicaat() &&
            partner.HeeftAdellijkeTitel() &&
            persoon.IsVrouw() &&
            persoon.GebruiktNaamVanPartner())
        {
            return partner.HeeftHoffelijkheidstitelMetAanspreekvorm()
                ? partner!.BepaalAanschrijfwijzeVoorHoffelijkheidstitel(persoon)
                : persoon.BepaalAanschrijfwijzeZonderAdellijkeTitelOfPredicaat(partner);
        }

        if (persoon.HeeftAdellijkeTitelOfPredicaat())
        {
            if (partner.HeeftAdellijkeTitelOfPredicaat() &&
                persoon.IsVrouw() &&
                persoon.GebruiktNaamVanPartner()
                )
            {
                return partner.HeeftHoffelijkheidstitelMetAanspreekvorm()
                    ? partner!.BepaalAanschrijfwijzeVoorHoffelijkheidstitel(persoon)
                    : persoon.BepaalAanschrijfwijzeZonderAdellijkeTitelOfPredicaatVanPartner(partner);
            }

            if (partner != null &&
               persoon.HeeftPartnerNaamgebruik()
              ) return persoon.BepaalAanschrijfwijzeZonderAdellijkeTitelOfPredicaat(partner);

            if (persoon.HeeftPredicaat() &&
                persoon.IsVrouw() &&
                partner.IsActueelPartner()
               ) return persoon.BepaalAanschrijfwijzeZonderAdellijkeTitelOfPredicaat(partner);

            if (persoon.HeeftPredicaat() &&
                persoon.IsVrouw() &&
                partner.IsExPartner() &&
                persoon.GebruiktNaamVanPartner()
                ) return persoon.BepaalAanschrijfwijzeZonderAdellijkeTitelOfPredicaat(partner);

            return persoon.BepaalAanschrijfwijzeVoorAdellijkeTitelOfPredicaat(partner);
        }

        return persoon.BepaalAanschrijfwijzeZonderAdellijkeTitelOfPredicaat(partner);
    }

    private static string? Aanspreekvorm(this AdellijkeTitelPredicaatType type, string geslachtsaanduiding)
    {
        var key = $"{type.Code}-{geslachtsaanduiding}";

        return AdellijkeTitelPredicaatAanspreekvormen.ContainsKey(key)
            ? AdellijkeTitelPredicaatAanspreekvormen[key]
            : null;
    }

    private static Aanschrijfwijze? BepaalAanschrijfwijzeVoorHoffelijkheidstitel(this Partner partner, NaamPersoon persoon)
    {
        return new Aanschrijfwijze
        {
            Naam = partner.AanschrijfwijzeNaamHoffelijkheidstitel(persoon),
            Aanspreekvorm = !partner.Achternaam().IsLeegOfOnbekend()
                ? partner.AdellijkeTitelPredicaatType()!.Aanspreekvorm(persoon.Geslacht!.Code)
                : null
        };
    }

    private static Aanschrijfwijze? BepaalAanschrijfwijzeVoorAdellijkeTitelOfPredicaat(this NaamPersoon persoon, Partner? partner)
    {
        return new Aanschrijfwijze
        {
            Naam = persoon.AdellijkeTitelPredicaat.Soort == AdellijkeTitelPredicaatSoort.Titel
                ? persoon.AanschrijfwijzeNaamAdellijkeTitel(partner)
                : persoon.AanschrijfwijzeNaamPredicaat(partner),
            Aanspreekvorm = persoon.AdellijkeTitelPredicaat.Aanspreekvorm(persoon.Geslacht!.Code)
        };
    }

    private static Aanschrijfwijze? BepaalAanschrijfwijzeZonderAdellijkeTitelOfPredicaatVanPartner(this NaamPersoon persoon, Partner? partner)
    {
        return new Aanschrijfwijze
        {
            Naam = persoon.AanschrijfwijzeNaamAdellijkeTitel(partner, false),
            Aanspreekvorm = persoon.AdellijkeTitelPredicaat.Aanspreekvorm(persoon.Geslacht!.Code)
        };
    }

    private static Aanschrijfwijze? BepaalAanschrijfwijzeZonderAdellijkeTitelOfPredicaat(this NaamPersoon persoon, Partner? partner)
    {
        if (persoon.HeeftLeegOfOnbekendGeslachtsnaam() &&
            persoon.HeeftGeenPartnerNaamgebruik())
        {
            return null;
        }

        return new Aanschrijfwijze
        {
            Naam = persoon.AanschrijfwijzeNaam(partner)
        };
    }

    private static string RemoveRedundantSpaces(this string input)
    {
        var retval = Regex.Replace(input, @"\s+", " ");
        retval = Regex.Replace(retval, @"\-\s+", "-");

        return retval.Trim();
    }

    private static string Titel(this NaamPersoon persoon)
    {
        var key = $"{persoon.AdellijkeTitelPredicaat?.Code}-{persoon.Geslacht?.Code}";

        return AdellijkeTitelPredicaten.ContainsKey(key)
            ? AdellijkeTitelPredicaten[key]
            : string.Empty;
    }

    private static string Titel(this Partner? partner, NaamPersoon persoon)
    {
        if(partner == null) return string.Empty;

        var keyPartner = partner.HeeftAdellijkeTitelOfPredicaat()
            ? $"{partner.AdellijkeTitelPredicaatType()!.Code}-{persoon.Geslacht?.Code}"
            : null;

        return keyPartner != null && AdellijkeTitelPredicaten.ContainsKey(keyPartner)
            ? AdellijkeTitelPredicaten[keyPartner]
            : string.Empty;
    }

    private static string? AanschrijfwijzeNaamHoffelijkheidstitel(this Partner partner, NaamPersoon persoon)
    {
        var achternaamPartner = $"{partner.Titel(persoon)} {partner.Achternaam()}";

        var achternaam = $"{persoon.Titel()} {persoon.Achternaam()}";

        var retval = partner.Achternaam().IsLeegOfOnbekend()
            ? $"{persoon.Voorletters} {achternaam}"
            : persoon.AanduidingNaamgebruik.Code switch
        {
            "P" => $"{persoon.Voorletters} {achternaamPartner}",
            "V" => $"{persoon.Voorletters} {achternaamPartner}-{achternaam}",
            "N" => $"{persoon.Voorletters} {achternaam}-{achternaamPartner}",
            _ => string.Empty
        };

        return retval.RemoveRedundantSpaces().ToNull();
    }

    private static string? AanschrijfwijzeNaamAdellijkeTitel(this NaamPersoon persoon, Partner? partner, bool inclusiefTitelPartner = true)
    {
        var titelPartner = inclusiefTitelPartner ? partner.Titel(persoon) : string.Empty;
        var achternaamPartner = $"{titelPartner} {partner.Achternaam()}";

        var achternaam = $"{persoon.Titel()} {persoon.Achternaam()}";

        var retval = partner.Achternaam().IsLeegOfOnbekend()
            ? $"{persoon.Voorletters} {achternaam}"
            : persoon.AanduidingNaamgebruik.Code switch
                {
                    "E" => $"{persoon.Voorletters} {achternaam}",
                    "V" => $"{persoon.Voorletters} {achternaamPartner}-{achternaam}",
                    "N" => $"{persoon.Voorletters} {achternaam}-{achternaamPartner}",
                    _ => string.Empty
                };

        return retval.RemoveRedundantSpaces().ToNull();
    }

    private static string? AanschrijfwijzeNaamPredicaat(this NaamPersoon persoon, Partner? partner)
    {
        var titel = persoon.Titel();

        var retval = partner.Achternaam().IsLeegOfOnbekend()
            ? $"{titel} {persoon.Voorletters} {persoon.Achternaam()}"
            : persoon.AanduidingNaamgebruik.Code switch
                {
                    "E" => $"{titel} {persoon.Voorletters} {persoon.Achternaam()}",
                    "V" => $"{titel} {persoon.Voorletters} {partner.Achternaam()}-{persoon.Achternaam()}",
                    "N" => $"{titel} {persoon.Voorletters} {persoon.Achternaam()}-{partner.Achternaam()}",
                    _ => string.Empty
                };

        return retval.RemoveRedundantSpaces().Capitalize().ToNull();
    }

    private static string? AanschrijfwijzeNaam(this NaamPersoon persoon, Partner? partner)
    {
        var retval = partner.Achternaam().IsLeegOfOnbekend()
            ? $"{persoon.Voorletters} {persoon.Achternaam()}"
            : persoon.AanduidingNaamgebruik.Code switch
                {
                    "E" => $"{persoon.Voorletters} {persoon.Achternaam()}",
                    "P" => $"{persoon.Voorletters} {partner.Achternaam()}",
                    "V" => $"{persoon.Voorletters} {partner.Achternaam()}-{persoon.Achternaam()}",
                    "N" => $"{persoon.Voorletters} {persoon.Achternaam()}-{partner.Achternaam()}",
                    _ => string.Empty
                };

        return retval.RemoveRedundantSpaces().Capitalize().ToNull();
    }
}
