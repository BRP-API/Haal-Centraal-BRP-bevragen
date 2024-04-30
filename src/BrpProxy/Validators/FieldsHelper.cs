using HaalCentraal.BrpProxy.Generated;
using Serilog;
using System.Collections.ObjectModel;

namespace BrpProxy.Validators;

public class FieldsHelper
{
    private readonly IDiagnosticContext _diagnosticContext;

    public ReadOnlyDictionary<string,string> PersoonFieldShortcuts { get; private set; }
    public ReadOnlyDictionary<string, string> PersoonBeperktFieldShortcuts { get; }
    public ReadOnlyDictionary<string, string> GezagPersoonBeperktFieldShortcuts { get; }
    public ReadOnlyDictionary<string,string> PersoonFieldPaths { get; }
    public ReadOnlyDictionary<string,string> BeperktPersoonFieldPaths { get; }
    public ReadOnlyDictionary<string, string> BeperktGezagPersoonFieldPaths { get; }

    private IDictionary<string, string> SetupFieldShortcuts()
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
            else if (kvp.Key.StartsWith("adressering") &&
                !new[]
                {
                    "adressering.adresregel3",
                    "adressering.land"
                }.Contains(kvp.Key))
            {
                dictionary.Add(kvp.Key.Replace("adressering", "adresseringBinnenland"), kvp.Value);
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
            if (kvp.Key.StartsWith("adressering") &&
                !new[]
                {
                    "adressering.adresregel3",
                    "adressering.land"
                }.Contains(kvp.Key))
            {
                dictionary.Add(kvp.Key.Replace("adressering", "adresseringBinnenland"), kvp.Value);
            }
            dictionary.Add(kvp.Key, kvp.Value);
        }

        return dictionary;
    }

    private IDictionary<string, string> SetupGezagPersoonBeperktFieldShortcuts()
    {
        var dictionary = new Dictionary<string, string>();

        foreach (var kvp in BeperktGezagPersoonFieldPaths)
        {
            if (kvp.Key.StartsWith("adressering") &&
                !new[]
                {
                    "adressering.adresregel3",
                    "adressering.land"
                }.Contains(kvp.Key))
            {
                dictionary.Add(kvp.Key.Replace("adressering", "adresseringBinnenland"), kvp.Value);
            }
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

    public static IDictionary<string, string> SetupGezagPersoonBeperktFieldInOnderzoekMapping()
    {
        var dictionary = new Dictionary<string, string>();

        var persoonFields = typeof(GezagPersoonBeperkt).GetPropertyPaths("HaalCentraal");
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

    public FieldsHelper(IDiagnosticContext diagnosticContext)
    {
        _diagnosticContext = diagnosticContext;

        PersoonFieldPaths = new ReadOnlyDictionary<string, string>(SetupFieldInOnderzoekMapping());
        BeperktPersoonFieldPaths = new ReadOnlyDictionary<string, string>(SetupPersoonBeperktFieldInOnderzoekMapping());
        BeperktGezagPersoonFieldPaths = new ReadOnlyDictionary<string, string>(SetupGezagPersoonBeperktFieldInOnderzoekMapping());
        PersoonFieldShortcuts = new ReadOnlyDictionary<string, string>(SetupFieldShortcuts());
        PersoonBeperktFieldShortcuts = new ReadOnlyDictionary<string, string>(SetupPersoonBeperktFieldShortcuts());
        GezagPersoonBeperktFieldShortcuts = new ReadOnlyDictionary<string, string>(SetupGezagPersoonBeperktFieldShortcuts());
    }

    public ICollection<string> AddExtraPersoonFields(ICollection<string> fields)
    {
        var retval = fields
            .Where(f => !f.Contains("inOnderzoek"))
            .ReplaceDatumWaardeTabelVerblijfplaatsBinnenlandPropertyFieldPaths()
            .AddAlwaysReturnedFields()
            .AddInOnderzoekFields()
            .Distinct()
            .ToList();

        _diagnosticContext.Set("fields (gevraagd + automatisch geleverd)", retval);

        return retval;
    }

    public ICollection<string> AddExtraPersoonBeperktFields(ICollection<string> fields)
    {
        var retval = fields
            .Where(f => !f.Contains("inOnderzoek"))
            .ReplaceDatumWaardeTabelVerblijfplaatsBinnenlandPropertyFieldPaths()
            .AddAlwaysReturnedFields()
            .AddInOnderzoekFields()
            .Distinct()
            .ToList();

        _diagnosticContext.Set("fields (gevraagd + automatisch geleverd)", retval);

        return retval;
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

        var s1 = pathParts[^1];
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
