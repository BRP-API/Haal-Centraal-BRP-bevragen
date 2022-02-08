using HaalCentraal.BrpProxy.Generated;
using System.Text.RegularExpressions;

namespace BrpProxy.Mappers;

public static class NaamMapper
{
    public static void Map(this NaamBasis naam)
    {
        if (naam == null) return;

        naam.VolledigeNaam = MapNaarVolledigeNaam(naam.Voornamen, naam.Voorvoegsel, naam.Geslachtsnaam, naam.AdellijkeTitelPredikaat);
        naam.Voorletters = naam.Voornamen.MapNaarVoorletters();
    }

    public static string MapNaarVolledigeNaam(string voornamen, string voorvoegsel, string geslachtsnaam, Waardetabel adellijkeTitelPredikaat)
    {
        var adellijkeTitel = adellijkeTitelPredikaat.MapNaarAdellijkeTitel();
        var predikaat = adellijkeTitelPredikaat.MapNaarPredikaat();

        var retval = Regex.Replace($"{predikaat} {voornamen} {adellijkeTitel} {voorvoegsel} {geslachtsnaam}", @"\s+", " ").Trim();

        return retval;
    }

    public static string MapNaarAdellijkeTitel(this Waardetabel waardetabel)
    {
        if (waardetabel == null) return string.Empty;

        switch (waardetabel.Code)
        {
            case "BS":
                return "barones";
            case "R":
                return "ridder";
            default:
                return string.Empty;
        }
    }

    public static string MapNaarPredikaat(this Waardetabel waardetabel)
    {
        if (waardetabel == null) return string.Empty;

        switch (waardetabel.Code)
        {
            case "JV":
                return "jonkvrouw";
            default:
                return string.Empty;
        }
    }

    public static string MapNaarVoorletters(this string voornamen)
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
