using HaalCentraal.BrpProxy.Generated;
using System.Collections.ObjectModel;

namespace BrpProxy.Validators;

public class FieldsHelper
{
    private readonly ILogger<FieldsHelper> _logger;

    public ReadOnlyDictionary<string,string> PersoonFieldShortcuts { get; private set; }
    public ReadOnlyDictionary<string, string> PersoonBeperktFieldShortcuts { get; }
    public ReadOnlyDictionary<string,string> PersoonFieldPaths { get; }
    public ReadOnlyCollection<string> BeperktPersoonFieldPaths { get; }

    private static IDictionary<string, string> SetupFieldShortcuts(string persoonFieldsMappingFilePath)
    {
        var dictionary = new Dictionary<string, string>();

        foreach (var line in File.ReadAllLines(persoonFieldsMappingFilePath).Skip(1))
        {
            var lineItems = line.Split(',');
            dictionary.Add(lineItems[0], lineItems[1]);
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

    public FieldsHelper(IConfiguration configuration, ILogger<FieldsHelper> logger)
    {
        _logger = logger;

        PersoonFieldShortcuts = new ReadOnlyDictionary<string, string>(SetupFieldShortcuts(configuration["PersoonFieldsMapping"]));
        PersoonBeperktFieldShortcuts = new ReadOnlyDictionary<string, string>(SetupFieldShortcuts(configuration["PersoonBeperktFieldsMapping"]));
        PersoonFieldPaths = new ReadOnlyDictionary<string, string>(SetupFieldInOnderzoekMapping());
        BeperktPersoonFieldPaths = new ReadOnlyCollection<string>(typeof(PersoonBeperkt).GetPropertyPaths("HaalCentraal"));
    }

    public ICollection<string> AddExtraPersoonFields(ICollection<string> fields)
    {
        var retval = new List<string>()
        {
            "geheimhoudingPersoonsgegevens",
            "opschortingBijhouding.reden"
        };

        foreach(var field in fields)
        {
            var fieldFullPath = PersoonFieldShortcuts[field];
            retval.Add(fieldFullPath);

            if (new[] { "adressering.aanhef", "adressering.aanschrijfwijze", "adressering.gebruikInLopendeTekst" }.Contains(fieldFullPath))
            {
                retval.Add("adressering.inOnderzoek.datumIngangOnderzoekPersoon");
                retval.Add("adressering.inOnderzoek.datumIngangOnderzoekPartner");
            }
            if (new[] { "adressering.adresregel1", "adressering.adresregel2", "adressering.adresregel3" }.Contains(fieldFullPath))
            {
                retval.Add("adressering.inOnderzoek.datumIngangOnderzoekVerblijfplaats");
            }
            if (new[] { "aNummer", "burgerservicenummer", "leeftijd", "geslacht", "geslacht.code", "geslacht.omschrijving" }.Contains(fieldFullPath))
            {
                retval.Add("inOnderzoek.datumIngangOnderzoekPersoon");
            }
            if (new[] { "gemeenteVanInschrijving", "datumInschrijvingInGemeente" }.Contains(fieldFullPath))
            {
                retval.Add("inOnderzoek.datumIngangOnderzoekGemeente");
            }
            if (field.Contains("overlijden"))
            {
                retval.Add("overlijden.indicatieOverleden");
                retval.Add("overlijden.inOnderzoek.indicatieOverleden");
            }
            if (new[] {"indicatieGezagMinderjarige", "indicatieCurateleRegister" }.Contains(fieldFullPath))
            {
                retval.Add("inOnderzoek.datumIngangOnderzoekGezag");
            }

            var inOnderzoekField = PersoonFieldPaths[fieldFullPath];
            if (!string.IsNullOrEmpty(inOnderzoekField))
            {
                retval.Add(inOnderzoekField);
                var datumIngangOnderzoekField = inOnderzoekField.EndsWith("inOnderzoek")
                    ? $"{inOnderzoekField}.datumIngangOnderzoek"
                    : $"{inOnderzoekField[0..inOnderzoekField.LastIndexOf('.')]}.datumIngangOnderzoek";
                retval.Add(datumIngangOnderzoekField);
            }
        }

        retval = retval.Distinct().ToList();

        _logger.LogDebug("extra persoon fields: {@fields}", retval);

        return retval;
    }

    public ICollection<string> AddExtraPersoonBeperktFields(ICollection<string> fields)
    {
        var retval = new List<string>()
        {
            "geheimhoudingPersoonsgegevens",
            "opschortingBijhouding.reden"
        };

        foreach (var field in fields)
        {
            var fieldFullPath = PersoonBeperktFieldShortcuts[field];
            retval.Add(fieldFullPath);
            if (field.Contains("overlijden"))
            {
                retval.Add("overlijden.indicatieOverleden");
                retval.Add("overlijden.inOnderzoek.indicatieOverleden");
            }
        }

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
