using HaalCentraal.BrpProxy.Generated;
using Newtonsoft.Json;
using System.Collections;
using System.Collections.ObjectModel;
using System.Reflection;

namespace BrpProxy.Validators
{
    public class FieldsHelper
    {
        private readonly ILogger<FieldsHelper> _logger;

        public Dictionary<string,string> PersoonFieldPaths { get; }
        public ReadOnlyCollection<string> BeperktPersoonFieldPaths { get; }

        public FieldsHelper(ILogger<FieldsHelper> logger)
        {
            _logger = logger;

            PersoonFieldPaths = new Dictionary<string, string>();
            var persoonFields = typeof(Persoon).GetPropertyPaths("HaalCentraal");
            var persoonInOnderzoekFields = persoonFields.Where(x => x.IsInOnderzoekField());
            foreach(var field in persoonFields)
            {
                if (field.IsInOnderzoekField())
                {
                    PersoonFieldPaths.Add(field, "");
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

                    PersoonFieldPaths.Add(field, inOnderzoekField!);
                }
                else
                {
                    var inOnderzoekField = persoonInOnderzoekFields.FirstOrDefault(x => x.Contains(field));

                    PersoonFieldPaths.Add(field, inOnderzoekField!);
                }
            }

            BeperktPersoonFieldPaths = new ReadOnlyCollection<string>(typeof(PersoonBeperkt).GetPropertyPaths("HaalCentraal"));
        }

        public ICollection<string> AddExtraPersoonFields(ICollection<string> fields)
        {
            var retval = new List<string>(fields)
            {
                "geheimhoudingPersoonsgegevens",
                "opschortingBijhouding.reden"
            };

            foreach(var field in fields)
            {
                var inOnderzoekField = PersoonFieldPaths[field];
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

        private static string ToInOnderzoekPath(IEnumerable<string> inOnderzoekPaths, string path)
        {
            var pathParts = path.Split('.');
            var s1 = pathParts.Last();
            var s2 = string.Join('.', pathParts.Take(pathParts.Length - 1));

            return inOnderzoekPaths.FirstOrDefault(x => x.Contains($"{s2}.inOnderzoek.{s1}")) ?? "";
        }
    }

    public static class FieldsHelperExtensions
    {
        public static bool IsInOnderzoekField(this string field)
        {
            return field.Contains("inOnderzoek");
        }

        public static List<string> GetPropertyPaths(this Type type, string baseNamespace, string path = "")
        {
            List<string> retval = new();

            var attributes = type.GetCustomAttributes(false);
            foreach (var attribute in attributes)
            {
                switch (attribute)
                {
                    case JsonConverterAttribute a:
                        var prop = a.ConverterParameters?[0] as string;
                        if (!string.IsNullOrWhiteSpace(prop))
                        {
                            retval.Add(prop.ToFullPath(path));
                        }
                        break;
                    case JsonInheritanceAttribute a:
                        retval.AddRange(a.Type.GetPropertyPaths(baseNamespace, path));
                        break;
                    default:
                        break;
                }
            }
            foreach (var property in type.GetProperties())
            {
                var name = property.JsonName();

                if (string.IsNullOrWhiteSpace(name))
                {
                    continue;
                }
                if (name != "AdditionalProperties")
                {
                    retval.Add(name.ToFullPath(path));
                }
                if (property.PropertyType.FullNameStartsWith(baseNamespace))
                {
                    retval.AddRange(property.PropertyType.GetPropertyPaths(baseNamespace, name.ToFullPath(path)));
                }
                if (property.PropertyType.IsGenericType)
                {
                    var genericType = property.PropertyType.GetGenericArguments()[0];
                    if (genericType.FullNameStartsWith(baseNamespace))
                    {
                        retval.AddRange(genericType.GetPropertyPaths(baseNamespace, name.ToFullPath(path)));
                    }
                }
            }

            return retval.Distinct().ToList();
        }

        private static string? JsonName(this PropertyInfo? property)
        {
            if (property == null) return null;

            var jsonProperty = property.GetCustomAttribute<JsonPropertyAttribute>();

            return jsonProperty != null
                ? jsonProperty.PropertyName
                : property.Name;
        }

        private static bool FullNameStartsWith(this Type? type, string baseNamespace)
        {
            return type != null &&
                   !string.IsNullOrWhiteSpace(type.FullName) &&
                   type.FullName.StartsWith(baseNamespace);
        }

        private static string ToFullPath(this string name, string path)
        {
            return string.IsNullOrWhiteSpace(path)
                    ? name
                    : $"{path}.{name}";
        }

        public static ICollection<T>? FilterList<T>(this ICollection<T> list, IEnumerable<string> fields)
        {
            if (list == null)
            {
                return default;
            }

            var retval = Activator.CreateInstance(list.GetType()) as ICollection<T>;
            if (retval == null)
            {
                return default;
            }

            foreach (var entity in list)
            {
                var newEntity = entity.Filter(fields);
                if (newEntity != null)
                {
                    retval.Add(newEntity);
                }
            }

            return retval;
        }

        public static T? Filter<T>(this T entity, IEnumerable<string> fields)
        {
            if (entity == null)
            {
                return default;
            }

            var retval = Activator.CreateInstance(entity.GetType());

            foreach (var field in fields.Where(f => !(f.Contains("kinderen") || f.Contains("nationaliteiten") || f.Contains("ouders") || f.Contains("partners"))))
            {
                var fieldParts = field.Split('.');

                object? src = entity;
                object? dest = retval!;
                for (var index = 0; index < fieldParts.Length; index++)
                {
                    var fieldPart = fieldParts[index];

                    (var pi, var srcValue) = src.GetValue(fieldPart);
                    if (pi != null && srcValue != null)
                    {
                        if (index == fieldParts.Length-1)
                        {
                            pi.SetValue(dest, srcValue);
                        }
                        else
                        {
                            var val = pi.GetValue(dest);
                            if (val == null)
                            {
                                pi.SetValue(dest, Activator.CreateInstance(srcValue != null ? srcValue.GetType() : pi.PropertyType));
                            }
                            dest = pi.GetValue(dest);
                        }
                        src = srcValue;
                    }
                }
            }

            foreach(var relatieNaam in new[] { "kinderen", "nationaliteiten", "ouders", "partners" })
            {
                (var pi, var srcValue) = entity.GetValue(relatieNaam);
                if (pi == null || srcValue == null)
                {
                    continue;
                }

                var relatieFields = from field in fields
                                   where field.StartsWith(relatieNaam)
                                   select field.Replace($"{relatieNaam}.", "");

                if (relatieFields.Any(x => x == relatieNaam))
                {
                    // alle velden van de relatie moeten worden geretourneerd
                    pi.SetValue(retval, srcValue);
                }
                else if (relatieFields.Any())
                {
                    switch (srcValue)
                    {
                        case ICollection<AbstractKind> val:
                            pi.SetValue(retval, val.FilterList(relatieFields));
                            break;
                        case ICollection<AbstractNationaliteit> val:
                            pi.SetValue(retval, val.FilterList(relatieFields));
                            break;
                        case ICollection<AbstractOuder> val:
                            pi.SetValue(retval, val.FilterList(relatieFields));
                            break;
                        case ICollection<AbstractPartner> val:
                            pi.SetValue(retval, val.FilterList(relatieFields));
                            break;
                        default:
                            break;
                    }
                }
            }

            return (T?)retval;
        }

        public static (PropertyInfo? pi, object? value) GetValue<T>(this T entity, string field)
        {
            if (entity == null) return (null, null);

            var pi = entity.GetType().GetProperty(field, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance);
            if (pi == null) return (null, null);

            var val = pi.GetValue(entity);
            if (val == null) return (null, null);

            return (pi, val);
        }

        public static (PropertyInfo? pi, TResult? value) GetValue<T,TResult>(this T entity, string field)
        {
            if (entity == null) return (null, default);

            var pi = entity.GetType().GetProperty(field, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance);
            if (pi == null) return (null, default);

            var val = pi.GetValue(entity);
            if (val == null) return (null, default);

            return (pi, (TResult)val);
        }
    }
}
