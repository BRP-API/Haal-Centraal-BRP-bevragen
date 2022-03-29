using HaalCentraal.BrpProxy.Generated;
using Newtonsoft.Json;
using System.Reflection;

namespace BrpProxy.Validators
{
    public static class FieldsHelpers
    {
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

            var retval = (T?)Activator.CreateInstance(entity.GetType());

            foreach (var field in fields)
            {
                if (field == null) continue;

                if (!field.Contains('.'))
                {
                    (var pi, var value) = entity.GetValue(field);
                    if (pi != null)
                    {
                        pi.SetValue(retval, value);
                    }
                }
                else
                {
                    var leftPart = field[..field.IndexOf('.')];
                    var rightPart = field[(field.IndexOf('.') + 1)..];

                    (var pi, var left) = entity.GetValue(leftPart);
                    if (pi != null)
                    {
                        var src = left switch
                        {
                            ICollection<AbstractPartner> p => p.FilterList(new[] { rightPart }),
                            ICollection<AbstractOuder> p => p.FilterList(new[] { rightPart }),
                            ICollection<AbstractNationaliteit> p => p.FilterList(new[] { rightPart }),
                            ICollection<AbstractKind> p => p.FilterList(new[] { rightPart }),
                            _ => left.Filter(new[] { rightPart })
                        };

                        if (src != null)
                        {
                            var dest = pi.GetValue(retval);
                            if (dest == null)
                            {
                                pi.SetValue(retval, src);
                            }
                            else
                            {
                                leftPart = !rightPart.Contains('.') ? rightPart : rightPart[..rightPart.IndexOf('.')];
                                (pi, src) = src.GetValue(leftPart);
                                if (pi != null)
                                {
                                    pi.SetValue(dest, src);
                                }
                            }
                        }
                    }
                }
            }

            return retval;
        }

        private static (PropertyInfo? pi, object? value) GetValue<T>(this T entity, string field)
        {
            if (entity == null) return (null, null);

            var pi = entity.GetType().GetProperty(field, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance);
            if (pi == null) return (null, null);

            var val = pi.GetValue(entity);

            return (pi, val);
        }
    }
}
