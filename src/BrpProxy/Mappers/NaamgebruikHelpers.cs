using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Mappers;

public static class NaamgebruikHelpers
{
    private static bool HeeftEigenNaamgebruik(this NaamPersoon naam) => naam.AanduidingNaamgebruik() == "E";

    public static bool GebruiktNaamVanPartner(this NaamPersoon naam) => !naam.HeeftEigenNaamgebruik();

    public static bool HeeftPartnerNaamgebruik(this NaamPersoon naam) => naam.AanduidingNaamgebruik() == "P";

    public static bool HeeftGeenPartnerNaamgebruik(this NaamPersoon naam) => !naam.HeeftPartnerNaamgebruik();

    public static string? AanduidingNaamgebruik(this NaamPersoon naam) => naam.AanduidingNaamgebruik?.Code;
}
