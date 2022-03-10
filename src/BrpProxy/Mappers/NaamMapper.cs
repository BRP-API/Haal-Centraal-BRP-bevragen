using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;
using System.Collections.ObjectModel;
using System.Text.RegularExpressions;

namespace BrpProxy.Mappers;

public static class NaamMapper
{
    public static NaamBasis? Map(this GbaNaamBasis? naam)
    {
        return naam != null
            ? new NaamBasis
        {
                Geslachtsnaam = naam.Geslachtsnaam,
                VolledigeNaam = MapNaarVolledigeNaam(naam.Voornamen, naam.Voorvoegsel, naam.Geslachtsnaam, naam.AdellijkeTitelPredicaat),
            Voorletters = naam.Voornamen.MapNaarVoorletters()
        }
            : null;
    }

    private static string VoorvoegselEnGeslachtsnaam(this IGbaNaam naam)
    {
        return string.IsNullOrWhiteSpace(naam.Voorvoegsel)
            ? naam.Geslachtsnaam
            : $"{naam.Voorvoegsel} {naam.Geslachtsnaam}";
    }

    public static Aanschrijfwijze MapNaarAanschrijfwijze(this GbaNaamPersoon naam, ICollection<GbaPartner> partners)
    {
        var aanschrijfwijze = string.Empty;
        var partnerNaam = partners != null && partners.Any() ? partners.ElementAt(0).Naam : null;
        switch (naam.AanduidingNaamgebruik.Code)
        {
            case "E":
                aanschrijfwijze = $"{naam.Predicaat()} {naam.Voorletters()} {naam.Titel()} {naam.VoorvoegselEnGeslachtsnaam()}";
                break;
            case "N":
                aanschrijfwijze = $"{naam.Predicaat()} {naam.Voorletters()} {naam.Titel()} {naam.VoorvoegselEnGeslachtsnaam()}-{partnerNaam?.VoorvoegselEnGeslachtsnaam()}";
                break;
            case "P":
                aanschrijfwijze = $"{partnerNaam?.Predicaat()} {naam.Voorletters()} {partnerNaam?.Titel()} {partnerNaam?.VoorvoegselEnGeslachtsnaam()}";
                break;
            case "V":
                aanschrijfwijze = $"{partnerNaam?.Predicaat()} {naam.Voorletters()} {partnerNaam?.Titel()} {partnerNaam?.VoorvoegselEnGeslachtsnaam()}-{naam.Titel()} {naam.VoorvoegselEnGeslachtsnaam()}";
                break;
            default:
                break;
        }
        return new Aanschrijfwijze
        {
            Naam = Regex.Replace(aanschrijfwijze, @"\s+", " ").Replace("- ", "-").Trim()
        };
    }

    public static string MapNaarVolledigeNaam(string voornamen, string voorvoegsel, string geslachtsnaam, AdellijkeTitelPredicaatType adellijkeTitelPredicaat)
    {
        var adellijkeTitel = adellijkeTitelPredicaat.MapNaarAdellijkeTitel();
        var predikaat = adellijkeTitelPredicaat.MapNaarPredicaat();

        var retval = Regex.Replace($"{predikaat} {voornamen} {adellijkeTitel} {voorvoegsel} {geslachtsnaam}", @"\s+", " ").Trim();

        return retval;
    }

    private static string Titel(this IGbaNaam naam)
    {
        return naam.AdellijkeTitelPredicaat.MapNaarAdellijkeTitel();
    }

    public static string MapNaarAdellijkeTitel(this AdellijkeTitelPredicaatType waardetabel)
    {
        if (waardetabel == null) return string.Empty;

        switch (waardetabel.Code)
        {
            case "B":
                return "baron";
            case "BS":
                return "barones";
            case "G":
                return "graaf";
            case "GI":
                return "gravin";
            case "R":
                return "ridder";
            default:
                return string.Empty;
        }
    }

    private static string Predicaat(this IGbaNaam naam)
    {
        return naam.AdellijkeTitelPredicaat.MapNaarPredicaat();
    }

    public static string MapNaarPredicaat(this AdellijkeTitelPredicaatType waardetabel)
    {
        if (waardetabel == null) return string.Empty;

        switch (waardetabel.Code)
        {
            case "JH":
                return "jonkheer";
            case "JV":
                return "jonkvrouw";
            default:
                return string.Empty;
        }
    }

    public static string VolledigeNaam(this GbaNaamPersoon naam)
    {
        var adellijkeTitel = naam.AdellijkeTitelPredicaat.MapNaarAdellijkeTitel();
        var predikaat = naam.AdellijkeTitelPredicaat.MapNaarPredicaat();

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
}
