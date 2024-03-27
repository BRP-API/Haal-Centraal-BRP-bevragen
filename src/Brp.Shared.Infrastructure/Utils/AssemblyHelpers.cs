using System.Reflection;

namespace Brp.Shared.Infrastructure.Utils;

public static class AssemblyHelpers
{
    public static string Version
    {
        get
        {
            return Assembly.GetEntryAssembly()
                            ?.GetCustomAttribute<AssemblyInformationalVersionAttribute>()
                            ?.InformationalVersion ?? string.Empty;
        }
    }

    public static string Name
    {
        get
        {
            return Assembly.GetEntryAssembly()?.GetName()?.Name?.Replace('.', ' ') ?? string.Empty;
        }
    }
}
