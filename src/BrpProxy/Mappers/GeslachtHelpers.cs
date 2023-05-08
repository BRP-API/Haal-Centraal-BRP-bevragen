using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Mappers;

public static class GeslachtHelpers
{
    public static bool IsVrouw(this IWaardetabel? geslacht) => geslacht?.Code.ToUpperInvariant() == "V";

    public static bool IsVrouw(this NaamPersoon naam) => naam.Geslacht.IsVrouw();

    public static bool IsMan(this IWaardetabel? geslacht) => geslacht?.Code.ToUpperInvariant() == "M";

    public static bool IsMan(this Partner? partner) => partner != null && partner.Geslacht.IsMan();

    public static bool IsMan(this NaamPersoon naam) => naam.Geslacht.IsMan();

    public static string? Geslacht(this NaamPersoon persoon) => persoon.Geslacht?.Code.ToUpperInvariant();
}
