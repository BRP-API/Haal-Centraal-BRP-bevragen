using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Mappers;

public static class AdellijkeTitelPredicaatHelpers
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

    private const string HOOGWELGEBORENHEER = "Hoogwelgeboren heer";
    private const string HOOGWELGEBORENVROUWE = "Hoogwelgeboren vrouwe";
    private const string HOOGGEBORENHEER = "Hooggeboren heer";
    private const string HOOGGEBORENVROUWE = "Hooggeboren vrouwe";
    private const string HOOGHEID = "Hoogheid";

    private static readonly Dictionary<string, string> AdellijkeTitels = new()
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

    private static readonly Dictionary<string, string> Predicaten = new()
    {
        { "JH", JONKHEER },
        { "JV", JONKVROUW }
    };

    private static readonly Dictionary<string, string> HoffelijkheidsTitels = new()
    {
        { "B", HOOGWELGEBORENVROUWE },
        { "G", HOOGGEBORENVROUWE },
        { "H", HOOGWELGEBORENVROUWE },
        { "M", HOOGWELGEBORENVROUWE },
        { "P", HOOGHEID }
    };

    private static readonly Dictionary<string, string> AanhefAdellijkeTitelPredicaat = new()
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

    public static string AdellijkeTitelPredicaat(this NaamPersoon naam) => 
        naam.AdellijkeTitelPredicaat != null
            ? naam.AdellijkeTitelPredicaat.Code
            : string.Empty;

    public static string AdellijkeTitelPredicaat(this Partner? partner) =>
        partner?.Naam?.AdellijkeTitelPredicaat != null
            ? partner.Naam.AdellijkeTitelPredicaat.Code
            : String.Empty;

    public static AdellijkeTitelPredicaatType? AdellijkeTitelPredicaatType(this Partner? partner) =>
        partner?.Naam.AdellijkeTitelPredicaat != null
            ? partner.Naam.AdellijkeTitelPredicaat
            : null;

    public static bool HeeftAdellijkeTitel(this NaamPersoon naam) =>
        naam.AdellijkeTitelPredicaat != null &&
        naam.AdellijkeTitelPredicaat.Code != null &&
        AdellijkeTitels.ContainsKey(naam.AdellijkeTitelPredicaat.Code);

    public static bool HeeftAdellijkeTitel(this Partner? partner) =>
        partner?.Naam?.AdellijkeTitelPredicaat != null &&
        AdellijkeTitels.ContainsKey(partner.Naam.AdellijkeTitelPredicaat.Code);

    public static bool HeeftAdellijkeTitelOfPredicaat(this NaamPersoon persoon) => persoon.AdellijkeTitelPredicaat != null;

    public static bool HeeftAdellijkeTitelOfPredicaat(this Partner? partner) =>
        partner?.Naam?.AdellijkeTitelPredicaat != null;

    public static bool HeeftGeenAdellijkeTitelOfPredicaat(this NaamPersoon persoon) => !persoon.HeeftAdellijkeTitelOfPredicaat();

    public static bool HeeftGeenAdellijkeTitelOfPredicaat(this Partner? partner) => !partner.HeeftAdellijkeTitelOfPredicaat();

    public static bool HeeftAdellijkeTitelMetAanspreekvorm(this NaamPersoon persoon)
    {
        if (persoon.AdellijkeTitelPredicaat != null &&
            persoon.AdellijkeTitelPredicaat.Code != null &&
            persoon.Geslacht != null &&
            persoon.Geslacht.Code != null)
        {
            var aanhefKey = $"{persoon.AdellijkeTitelPredicaat.Code}-{persoon.Geslacht.Code}";

            return AanhefAdellijkeTitelPredicaat.ContainsKey(aanhefKey);
        }
        return false;
    }

    public static bool HeeftPredicaat(this NaamPersoon naam) =>
        !string.IsNullOrWhiteSpace(naam.AdellijkeTitelPredicaat?.Code) &&
        Predicaten.ContainsKey(naam.AdellijkeTitelPredicaat.Code);

    public static bool HeeftHoffelijkheidstitelMetAanspreekvorm(this Partner? partner) =>
        partner != null &&
        HoffelijkheidsTitels.ContainsKey(partner.AdellijkeTitelPredicaat());

    public static string BepaalHoffelijkheidstitel(this Partner? partner) => HoffelijkheidsTitels[partner.AdellijkeTitelPredicaat()];

    public static bool HeeftGeenAdellijkeTitelMetAanspreekvorm(this NaamPersoon persoon) => !persoon.HeeftAdellijkeTitelMetAanspreekvorm();

    private static bool HeeftHoffelijkheidsTitel(this NaamPersoon naam) =>
        !string.IsNullOrWhiteSpace(naam.AdellijkeTitelPredicaat.Code) &&
        HoffelijkheidsTitels.ContainsKey(naam.AdellijkeTitelPredicaat.Code);

    public static bool HeeftGeenHoffelijkheidsTitel(this NaamPersoon naam) => !naam.HeeftHoffelijkheidsTitel();

    public static string BepaalAanhefVoorAdellijkeTitelOfPredicaat(this NaamPersoon persoon)
    {
        var aanhefKey = $"{persoon.AdellijkeTitelPredicaat.Code}-{persoon.Geslacht!.Code}";

        return AanhefAdellijkeTitelPredicaat[aanhefKey];
    }

    public static string MapNaarAdellijkeTitel(this IWaardetabel waardetabel, IWaardetabel? geslacht)
    {
        if (waardetabel == null) return string.Empty;

        return waardetabel.Code switch
        {
            "B" => AdellijkeTitels[geslacht.IsVrouw() ? "BS" : "B"],
            "BS" => AdellijkeTitels[geslacht.IsMan() ? "B" : "BS"],
            "G" => AdellijkeTitels[geslacht.IsVrouw() ? "GI" : "G"],
            "GI" => AdellijkeTitels[geslacht.IsMan() ? "G" : "GI"],
            "H" => AdellijkeTitels[geslacht.IsVrouw() ? "HI" : "H"],
            "HI" => AdellijkeTitels[geslacht.IsMan() ? "H" : "HI"],
            "M" => AdellijkeTitels[geslacht.IsVrouw() ? "MI" : "M"],
            "MI" => AdellijkeTitels[geslacht.IsMan() ? "M" : "MI"],
            "P" => AdellijkeTitels[geslacht.IsVrouw() ? "PS" : "P"],
            "PS" => AdellijkeTitels[geslacht.IsMan() ? "P" : "PS"],
            "R" => AdellijkeTitels["R"],
            _ => string.Empty,
        };
    }

    public static string MapNaarAdellijkeTitelVoorAanschrijfwijze(this AdellijkeTitelPredicaatType waardetabel, IWaardetabel? geslacht)
    {
        if (waardetabel == null) return string.Empty;

        if (geslacht?.Code.ToUpperInvariant() == "O") return String.Empty;

        return waardetabel.Code switch
        {
            "B" => AdellijkeTitels[geslacht.IsVrouw() ? "BS" : "B"],
            "BS" => AdellijkeTitels[geslacht.IsMan() ? "B" : "BS"],
            "G" => AdellijkeTitels[geslacht.IsVrouw() ? "GI" : "G"],
            "GI" => AdellijkeTitels[geslacht.IsMan() ? "G" : "GI"],
            "H" => AdellijkeTitels[geslacht.IsVrouw() ? "HI" : "H"],
            "HI" => AdellijkeTitels[geslacht.IsMan() ? "H" : "HI"],
            "M" => AdellijkeTitels[geslacht.IsVrouw() ? "MI" : "M"],
            "MI" => AdellijkeTitels[geslacht.IsMan() ? "M" : "MI"],
            "P" => AdellijkeTitels[geslacht.IsVrouw() ? "PS" : "P"],
            "PS" => AdellijkeTitels[geslacht.IsMan() ? "P" : "PS"],
            "R" => geslacht.IsMan() ? AdellijkeTitels["R"] : String.Empty,
            _ => string.Empty,
        };
    }

    public static string MapNaarPredicaat(this IWaardetabel waardetabel, IWaardetabel? geslacht)
    {
        if (waardetabel == null) return string.Empty;

        return waardetabel.Code switch
        {
            "JH" => geslacht.IsVrouw() ? JONKVROUW : JONKHEER,
            "JV" => geslacht.IsMan() ? JONKHEER : JONKVROUW,
            _ => string.Empty,
        };
    }

    public static string MapNaarPredicaatVoorAanschrijfwijze(this AdellijkeTitelPredicaatType waardetabel, IWaardetabel? geslacht)
    {
        if (waardetabel == null) return string.Empty;

        if (geslacht?.Code.ToUpperInvariant() == "O") return String.Empty;

        return waardetabel.Code switch
        {
            "JH" => geslacht.IsVrouw() ? JONKVROUW : JONKHEER,
            "JV" => geslacht.IsMan() ? JONKHEER : JONKVROUW,
            _ => string.Empty,
        };
    }

    public static string Titel(this Partner? partner, NaamPersoon persoon, IDictionary<string, string> adellijkeTitelsEnPredicaten)
    {
        if (partner == null) return string.Empty;

        var keyPartner = partner.HeeftAdellijkeTitelOfPredicaat()
            ? $"{partner.AdellijkeTitelPredicaat()}-{persoon.Geslacht()}"
            : null;

        return keyPartner != null && adellijkeTitelsEnPredicaten.ContainsKey(keyPartner)
            ? adellijkeTitelsEnPredicaten[keyPartner]
            : string.Empty;
    }

    public static string Titel(this NaamPersoon persoon, IDictionary<string, string> adellijkeTitelsEnPredicaten)
    {
        var key = $"{persoon.AdellijkeTitelPredicaat()}-{persoon.Geslacht()}";

        return adellijkeTitelsEnPredicaten.ContainsKey(key)
            ? adellijkeTitelsEnPredicaten[key]
            : string.Empty;
    }
}
