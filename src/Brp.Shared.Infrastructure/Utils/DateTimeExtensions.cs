using System.Globalization;

namespace Brp.Shared.Infrastructure.Utils;

public static class DateTimeExtensions
{
    static readonly CultureInfo _nl = new("nl-NL");
    const string _dateFormat = "yyyy-MM-dd";

    public static DateTimeOffset ToDateTimeOffset(this string dateTime)
    {
        return DateTimeOffset.ParseExact(dateTime, _dateFormat, _nl.DateTimeFormat, DateTimeStyles.None);
    }

    public static bool IsDateTime(this string? dateTime)
    {
        return DateTime.TryParseExact(dateTime, _dateFormat, _nl.DateTimeFormat, DateTimeStyles.None, out _);
    }
}
