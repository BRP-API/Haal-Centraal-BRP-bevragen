using HaalCentraal.BrpProxy.Generated;
using System.Collections.ObjectModel;

namespace BrpProxy.Validators;

public class FieldsHelper
{
    private readonly ILogger<FieldsHelper> _logger;

    public ReadOnlyDictionary<string,string> PersoonFieldShortcuts { get; private set; }
    public ReadOnlyDictionary<string, string> PersoonBeperktFieldShortcuts { get; }
    public ReadOnlyDictionary<string,string> PersoonFieldPaths { get; }
    public ReadOnlyDictionary<string,string> BeperktPersoonFieldPaths { get; }

    private IDictionary<string, string> SetupFieldShortcuts(string persoonFieldsMappingFilePath)
    {
        var dictionary = new Dictionary<string, string>();

        foreach(var kvp in PersoonFieldPaths)
        {
            if (kvp.Key.StartsWith("verblijfplaats") &&
                !new[]
                {
                    "verblijfplaats.verblijfadres.regel1",
                    "verblijfplaats.verblijfadres.regel2",
                    "verblijfplaats.verblijfadres.regel3",
                    "verblijfplaats.verblijfadres.land"
                }.Contains(kvp.Key))
            {
                dictionary.Add(kvp.Key.Replace("verblijfplaats", "verblijfplaatsBinnenland"), kvp.Value);
            }
            dictionary.Add(kvp.Key, kvp.Value);
        }

        return dictionary;
    }

    private IDictionary<string, string> SetupPersoonBeperktFieldShortcuts()
    {
        var dictionary = new Dictionary<string, string>();

        foreach (var kvp in BeperktPersoonFieldPaths)
        {
            //if (kvp.Key.StartsWith("verblijfplaats") &&
            //    !new[]
            //    {
            //        "verblijfplaats.verblijfadres.regel1",
            //        "verblijfplaats.verblijfadres.regel2",
            //        "verblijfplaats.verblijfadres.regel3",
            //        "verblijfplaats.verblijfadres.land"
            //    }.Contains(kvp.Key))
            //{
            //    dictionary.Add(kvp.Key.Replace("verblijfplaats", "verblijfplaatsBinnenland"), kvp.Value);
            //}
            dictionary.Add(kvp.Key, kvp.Value);
        }

        return dictionary;
    }

    public static IDictionary<string, string> SetupFieldInOnderzoekMapping()
    {
        var dictionary = new Dictionary<string, string>();

        var persoonFields = typeof(Persoon).GetPropertyPaths("HaalCentraal");
        var persoonInOnderzoekFields = persoonFields.Where(x => x.IsInOnderzoekField()).OrderBy(x => x);
        foreach (var field in persoonFields)
        {
            if (field.IsInOnderzoekField())
            {
                dictionary.Add(field, "");
            }
            else if (field.Contains('.'))
            {
                dictionary.Add(field, ToNestedInOnderzoekPath(persoonInOnderzoekFields, field));
            }
            else
            {
                dictionary.Add(field, ToInOnderzoekpath(persoonInOnderzoekFields, field));
            }
        }

        return dictionary;
    }

    public static IDictionary<string, string> SetupPersoonBeperktFieldInOnderzoekMapping()
    {
        var dictionary = new Dictionary<string, string>();

        var persoonFields = typeof(PersoonBeperkt).GetPropertyPaths("HaalCentraal");
        var persoonInOnderzoekFields = persoonFields.Where(x => x.IsInOnderzoekField()).OrderBy(x => x);
        foreach (var field in persoonFields)
        {
            if (field.IsInOnderzoekField())
            {
                dictionary.Add(field, "");
            }
            else if (field.Contains('.'))
            {
                dictionary.Add(field, ToNestedInOnderzoekPath(persoonInOnderzoekFields, field));
            }
            else
            {
                dictionary.Add(field, ToInOnderzoekpath(persoonInOnderzoekFields, field));
            }
        }

        return dictionary;
    }

    public FieldsHelper(IConfiguration configuration, ILogger<FieldsHelper> logger)
    {
        _logger = logger;

        PersoonFieldPaths = new ReadOnlyDictionary<string, string>(SetupFieldInOnderzoekMapping());
        BeperktPersoonFieldPaths = new ReadOnlyDictionary<string, string>(SetupPersoonBeperktFieldInOnderzoekMapping());
        PersoonFieldShortcuts = new ReadOnlyDictionary<string, string>(SetupFieldShortcuts(configuration["PersoonFieldsMapping"]));
        PersoonBeperktFieldShortcuts = new ReadOnlyDictionary<string, string>(SetupPersoonBeperktFieldShortcuts());
    }

    public ICollection<string> AddExtraPersoonFields(ICollection<string> fields)
    {
        var retval = fields
            .Where(f => !f.Contains("inOnderzoek"))
            .ReplaceDatumWaardeTabelVerblijfplaatsBinnenlandPropertyFieldPaths()
            .AddInOnderzoekFields()
            .ToList();

        retval.AddRange(new[]
            {
            "geheimhoudingPersoonsgegevens",
            "opschortingBijhouding"
            });

        _logger.LogDebug("extra persoon fields: {@fields}", retval);

        return retval;
    }

    public ICollection<string> AddExtraPersoonBeperktFields(ICollection<string> fields)
    {
        var retval = fields
            .ReplaceDatumWaardeTabelVerblijfplaatsBinnenlandPropertyFieldPaths()
            .AddInOnderzoekFields()
            .ToList();

        retval.AddRange(new[]
            {
            "geheimhoudingPersoonsgegevens",
            "opschortingBijhouding"
            });

        _logger.LogDebug("extra persoon beperkt fields: {@fields}", retval);

        return retval.Distinct().ToList();
    }

    private static string ToInOnderzoekpath(IEnumerable<string> inOnderzoekPaths, string path)
    {
        var inOnderzoekPath = $"inOnderzoek.{path}";
        if (inOnderzoekPaths.Any(x => x == inOnderzoekPath))
        {
            return inOnderzoekPath;
        }

        inOnderzoekPath = $"{path}.inOnderzoek";
        if (inOnderzoekPaths.Any(x => x == inOnderzoekPath))
        {
            return inOnderzoekPath;
        }

        return string.Empty;
    }

    private static string ToNestedInOnderzoekPath(IEnumerable<string> inOnderzoekPaths, string path)
    {
        var inOnderzoekPath = $"{path}.inOnderzoek";

        if (inOnderzoekPaths.Any(x => x == inOnderzoekPath))
        {
            return inOnderzoekPath;
        }

        var pathParts = path.Split('.');

        var s1 = pathParts.Last();
        var s2 = string.Join('.', pathParts.Take(pathParts.Length - 1));

        if (new[] { "code", "omschrijving" }.Contains(s1))
        {
            inOnderzoekPath = pathParts.Length == 2
                ? $"inOnderzoek.{s2}"
                : $"{s2}.inOnderzoek";
            if (inOnderzoekPaths.Any(x => x == inOnderzoekPath))
            {
                return inOnderzoekPath;
            }
        }

        inOnderzoekPath = $"{s2}.inOnderzoek.{s1}";

        if (inOnderzoekPaths.Any(x => x == inOnderzoekPath))
        {
            return inOnderzoekPath;
        }

        if(pathParts.Length - 2 > 0)
        {
            s1 = pathParts[pathParts.Length - 2];
            s2 = string.Join('.', pathParts.Take(pathParts.Length - 2));

            inOnderzoekPath = $"{s2}.inOnderzoek.{s1}";

            if (inOnderzoekPaths.Any(x => x == inOnderzoekPath))
            {
                return inOnderzoekPath;
            }
        }

        return string.Empty;
    }
}
