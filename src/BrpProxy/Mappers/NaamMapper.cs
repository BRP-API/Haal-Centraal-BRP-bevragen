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
            "B" => geslacht.IsVrouw() ? BARONES : BARON,
            "BS" => geslacht.IsMan() ? BARON : BARONES,
            "G" => geslacht.IsVrouw() ? GRAVIN : GRAAF,
            "GI" => geslacht.IsMan() ? GRAAF : GRAVIN,
            "H" => geslacht.IsVrouw() ? HERTOGIN : HERTOG,
            "HI" => geslacht.IsMan() ? HERTOG : HERTOGIN,
            "M" => geslacht.IsVrouw() ? MARKIEZIN : MARKIES,
            "MI" => geslacht.IsMan() ? MARKIES : MARKIEZIN,
            "P" => geslacht.IsVrouw() ? PRINSES : PRINS,
            "PS" => geslacht.IsMan() ? PRINS : PRINSES,
            "R" => "ridder",
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
}
