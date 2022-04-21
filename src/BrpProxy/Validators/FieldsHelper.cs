using HaalCentraal.BrpProxy.Generated;
using System.Collections;
using System.Collections.ObjectModel;

namespace BrpProxy.Validators
{
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

        private static IDictionary<string, string> SetupFieldInOnderzoekMapping()
        {
            var dictionary = new Dictionary<string, string>();

            var persoonFields = typeof(Persoon).GetPropertyPaths("HaalCentraal");
            var persoonInOnderzoekFields = persoonFields.Where(x => x.IsInOnderzoekField());
            foreach (var field in persoonFields)
            {
                if (field.IsInOnderzoekField())
                {
                    dictionary.Add(field, "");
                }
                else if (field.Contains('.'))
                {
                    var inOnderzoekField = ToInOnderzoekPath(persoonInOnderzoekFields, field);
                    if (string.IsNullOrEmpty(inOnderzoekField))
                    {
                        var fieldPart = field[0..field.LastIndexOf('.')];
                        inOnderzoekField = fieldPart.Contains('.')
                            ? ToInOnderzoekPath(persoonInOnderzoekFields, fieldPart)
                            : persoonInOnderzoekFields.FirstOrDefault(x => x.Contains(fieldPart));
                    }

                    dictionary.Add(field, inOnderzoekField!);
                }
                else
                {
                    var inOnderzoekField = persoonInOnderzoekFields.FirstOrDefault(x => x.Contains(field));

                    dictionary.Add(field, inOnderzoekField!);
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
            }

            _logger.LogDebug("extra persoon beperkt fields: {@fields}", retval);

            return retval;
        }

        private static string ToInOnderzoekPath(IEnumerable<string> inOnderzoekPaths, string path)
        {
            var pathParts = path.Split('.');
            var s1 = pathParts.Last();
            var s2 = string.Join('.', pathParts.Take(pathParts.Length - 1));

            return inOnderzoekPaths.FirstOrDefault(x => x.Contains($"{s2}.inOnderzoek.{s1}")) ?? "";
        }
    }
}
