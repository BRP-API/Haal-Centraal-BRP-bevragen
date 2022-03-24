using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;
using System.Text.RegularExpressions;

namespace BrpProxy.Mappers;

public static class NaamMapper
{
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
