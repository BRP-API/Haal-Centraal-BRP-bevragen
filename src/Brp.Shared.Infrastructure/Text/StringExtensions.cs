namespace Brp.Shared.Infrastructure.Text;

public static class StringExtensions
{
    public static string RemoveAllWhitespace(this string str)
    {
        return string.Join("", str.Split(default(string[]), StringSplitOptions.RemoveEmptyEntries));
    }

    public static bool ContainsAny(this string str, IEnumerable<string> subStrings)
    {
        return subStrings.Any(subString => str.Contains(subString));
    }
}
