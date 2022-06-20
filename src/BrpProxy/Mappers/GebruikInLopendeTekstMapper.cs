﻿using HaalCentraal.BrpProxy.Generated;
using System.Text.RegularExpressions;

namespace BrpProxy.Mappers;

public static class GebruikInLopendeTekstMapper
{
    private const string BARON = "baron";
    private const string BARONES = "barones";
    private const string GRAAF = "graaf";
    private const string GRAVIN = "gravin";
    private const string HERTOG = "hertog";
    private const string HERTOGIN = "hertogin";
    private const string JONKHEER = "jonkheer";
    private const string JONKVROUW = "jonkvrouw";
    private const string MARKIES = "markies";
    private const string MARKIEZIN = "markiezin";
    private const string PRINS = "prins";
    private const string PRINSES = "prinses";
    private const string RIDDER = "ridder";

    private static readonly Dictionary<string, string> GebruikInLopendeTekstAdellijkeTitelPredicaat = new()
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

    private static string? BepaalGebruikInLopendeTekstZonderAdellijkeTitelOfPredicaat(this NaamPersoon persoon, Partner? partner)
    {
        if (persoon.HeeftLeegOfOnbekendGeslachtsnaam() &&
            persoon.HeeftGeenPartnerNaamgebruik())
        {
            return null;
        }

        var partnerNaam = partner.Achternaam();
        var persoonNaam = persoon.Achternaam();

        var geslachtsnaam = persoon.AanduidingNaamgebruik() switch
        {
            "E" => persoonNaam,
            "N" => partnerNaam.IsLeegOfOnbekend() ? persoonNaam : $"{persoonNaam}-{partnerNaam}",
            "V" => partnerNaam.IsLeegOfOnbekend() ? persoonNaam : $"{partnerNaam}-{persoonNaam}",
            "P" => partnerNaam.IsLeegOfOnbekend() ? persoonNaam : partnerNaam,
            _ => persoonNaam
        };

        var retval = persoon.Geslacht() switch
        {
            "M" => $"de heer {geslachtsnaam.Capitalize()}",
            "V" => $"mevrouw {geslachtsnaam.Capitalize()}",
            "O" => !string.IsNullOrWhiteSpace(persoon.Voorletters)
                ? $"{persoon.Voorletters} {geslachtsnaam}"
                : $"{geslachtsnaam.Capitalize()}",
            _ => string.Empty
        };

        return Regex.Replace(retval, @"\s+", " ").Trim().ToNull();
    }

    private static bool HeeftAdellijkeTitelVoorGebruikInLopendeTekst(this NaamPersoon persoon)
    {
        var key = $"{persoon.AdellijkeTitelPredicaat()}-{persoon.Geslacht()}";

        return GebruikInLopendeTekstAdellijkeTitelPredicaat.ContainsKey(key);
    }

    private static string? BepaalGebruikInLopendeTekstVoorHoffelijkheidsTitel(this NaamPersoon persoon, Partner partner)
    {
        var key = $"{partner.AdellijkeTitelPredicaat()}-{persoon.Geslacht()}";
        var titel = GebruikInLopendeTekstAdellijkeTitelPredicaat.ContainsKey(key)
            ? GebruikInLopendeTekstAdellijkeTitelPredicaat[key]
            : string.Empty;

        var partnerNaam = partner.Achternaam();
        var persoonNaam = persoon.Achternaam();

        var geslachtsnaam = persoon.AanduidingNaamgebruik() switch
        {
            "N" => partnerNaam.IsLeegOfOnbekend() ? $"{titel} {persoonNaam}" : $"{persoonNaam}-{titel} {partnerNaam}",
            "V" => partnerNaam.IsLeegOfOnbekend() ? $"{titel} {persoonNaam}" : $"{titel} {partnerNaam}-{persoonNaam}",
            "P" => partnerNaam.IsLeegOfOnbekend() ? $"{titel} {persoonNaam}" : $"{titel} {partnerNaam}",
            _ => $"{titel} {persoonNaam}"
        };

        var retval = persoon.Geslacht() switch
        {
            "M" => !geslachtsnaam.StartsWith(titel) ? $"de heer {geslachtsnaam.Capitalize()}" : geslachtsnaam,
            "V" => !geslachtsnaam.StartsWith(titel) ? $"mevrouw {geslachtsnaam.Capitalize()}" : geslachtsnaam,
            "O" => !string.IsNullOrWhiteSpace(persoon.Voorletters)
                ? $"{persoon.Voorletters} {geslachtsnaam}"
                : $"{geslachtsnaam.Capitalize()}",
            _ => string.Empty
        };

        return Regex.Replace(retval, @"\s+", " ").Trim().ToNull();
    }

    private static string? BepaalGebruikInLopendeTekstVoorAdellijkeTitelOfPredicaat(this NaamPersoon persoon, Partner? partner)
    {
        var key = $"{persoon.AdellijkeTitelPredicaat()}-{persoon.Geslacht()}";
        var titel = GebruikInLopendeTekstAdellijkeTitelPredicaat.ContainsKey(key)
            ? GebruikInLopendeTekstAdellijkeTitelPredicaat[key]
            : string.Empty;

        var partnerNaam = partner.Achternaam();
        var persoonNaam = persoon.Achternaam();

        var geslachtsnaam = persoon.AanduidingNaamgebruik() switch
        {
            "E" => $"{titel} {persoonNaam}",
            "N" => partnerNaam.IsLeegOfOnbekend() ? $"{titel} {persoonNaam}" : $"{titel} {persoonNaam}-{partnerNaam}",
            "V" => partnerNaam.IsLeegOfOnbekend() ? $"{titel} {persoonNaam}" : $"{partnerNaam}-{titel} {persoonNaam}",
            "P" => partnerNaam.IsLeegOfOnbekend() ? $"{titel} {persoonNaam}" : partnerNaam,
            _ => $"{titel} {persoonNaam}"
        };

        var retval = persoon.Geslacht() switch
        {
            "M" => !geslachtsnaam.StartsWith(titel) ? $"de heer {geslachtsnaam.Capitalize()}" : geslachtsnaam,
            "V" => !geslachtsnaam.StartsWith(titel) ? $"mevrouw {geslachtsnaam.Capitalize()}" : geslachtsnaam,
            "O" => !string.IsNullOrWhiteSpace(persoon.Voorletters)
                ? $"{persoon.Voorletters} {geslachtsnaam}"
                : $"{geslachtsnaam.Capitalize()}",
            _ => string.Empty
        };

        return Regex.Replace(retval, @"\s+", " ").Trim().ToNull();
    }

    private static string? BepaalGebruikInLopendeTekstVoorUitHoffelijkheidsTitelVanPartner(this NaamPersoon persoon, Partner? partner)
    {
        var keyTitelPersoon = $"{persoon.AdellijkeTitelPredicaat()}-{persoon.Geslacht()}";
        var titelPersoon = GebruikInLopendeTekstAdellijkeTitelPredicaat.ContainsKey(keyTitelPersoon)
            ? GebruikInLopendeTekstAdellijkeTitelPredicaat[keyTitelPersoon]
            : string.Empty;

        var keyTitelPartner = $"{partner.AdellijkeTitelPredicaat()}-{persoon.Geslacht()}";
        var titelPartner = GebruikInLopendeTekstAdellijkeTitelPredicaat.ContainsKey(keyTitelPartner)
            ? GebruikInLopendeTekstAdellijkeTitelPredicaat[keyTitelPartner]
            : string.Empty;

        var partnerNaam = partner.Achternaam();
        var persoonNaam = persoon.Achternaam();

        var geslachtsnaam = persoon.AanduidingNaamgebruik() switch
        {
            "N" => $"{titelPersoon} {persoonNaam}-{titelPartner} {partnerNaam}",
            "V" => $"{titelPartner} {partnerNaam}-{titelPersoon} {persoonNaam}",
            "P" => $"{titelPartner} {partnerNaam}",
            _ => string.Empty
        };

        var retval = persoon.Geslacht() switch
        {
            "V" => !geslachtsnaam.StartsWith(titelPersoon) && !geslachtsnaam.StartsWith(titelPartner)
                        ? $"mevrouw {geslachtsnaam.Capitalize()}"
                        : geslachtsnaam,
            _ => string.Empty
        };

        return Regex.Replace(retval, @"\s+", " ").Trim().ToNull();
    }

    public static string? GebruikInLopendeTekst(this NaamPersoon persoon)
    {
        var partner = persoon.Partners.ActuelePartner();

        if (persoon.HeeftGeenAdellijkeTitelOfPredicaat() &&
            partner.HeeftAdellijkeTitel() &&
            persoon.IsVrouw() &&
            persoon.GebruiktNaamVanPartner())
        {
            return partner.HeeftHoffelijkheidstitelMetAanspreekvorm()
                ? persoon.BepaalGebruikInLopendeTekstVoorHoffelijkheidsTitel(partner!)
                : persoon.BepaalGebruikInLopendeTekstZonderAdellijkeTitelOfPredicaat(partner);
        }

        if (persoon.HeeftAdellijkeTitelOfPredicaat())
        {
            if (partner.HeeftAdellijkeTitel() &&
                persoon.IsVrouw() &&
                partner.IsMan() &&
                persoon.GebruiktNaamVanPartner() &&
                partner.HeeftHoffelijkheidstitelMetAanspreekvorm()
                )
            {
                return persoon.BepaalGebruikInLopendeTekstVoorUitHoffelijkheidsTitelVanPartner(partner);
            }

            if (partner != null &&
                persoon.HeeftPartnerNaamgebruik()
                ) return persoon.BepaalGebruikInLopendeTekstZonderAdellijkeTitelOfPredicaat(partner);

            if (persoon.HeeftPredicaat() &&
                persoon.IsVrouw() &&
                partner.IsActueelPartner()
                ) return persoon.BepaalGebruikInLopendeTekstZonderAdellijkeTitelOfPredicaat(partner);

            if (persoon.HeeftPredicaat() &&
                persoon.IsVrouw() &&
                partner.IsExPartner() &&
                persoon.GebruiktNaamVanPartner()
                ) return persoon.BepaalGebruikInLopendeTekstZonderAdellijkeTitelOfPredicaat(partner);

            return persoon.HeeftAdellijkeTitelVoorGebruikInLopendeTekst()
                ? persoon.BepaalGebruikInLopendeTekstVoorAdellijkeTitelOfPredicaat(partner)
                : persoon.BepaalGebruikInLopendeTekstZonderAdellijkeTitelOfPredicaat(partner);
        }

        return persoon.BepaalGebruikInLopendeTekstZonderAdellijkeTitelOfPredicaat(partner);
    }
}
