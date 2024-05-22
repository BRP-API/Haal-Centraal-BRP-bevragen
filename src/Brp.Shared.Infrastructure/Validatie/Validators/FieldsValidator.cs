using Brp.Shared.Infrastructure.Text;
using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Infrastructure.Validatie.Validators;

public class FieldsValidator : AbstractValidator<JObject>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string NotArrayErrorMessage = "array||Parameter is geen array.";
    const string MinItemsErrorMessage = "minItems||Array bevat minder dan {0} items.";
    const string MaxItemsErrorMessage = "maxItems||Array bevat meer dan {0} items.";
    const string FieldPattern = @"^[a-zA-Z0-9\._]{1,200}$";
    const string FieldPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {FieldPattern}.";
    const string FieldExistErrorMessage = "fields||Parameter bevat een niet bestaande veldnaam.";
    const string FieldAllowedErrorMessage = "fields||Parameter bevat een niet toegestane veldnaam.";

    public FieldsValidator(IEnumerable<string> fieldNames, IEnumerable<string> notAllowedFieldNames, int maxNumberFields)
    {
        RuleFor(x => x.GetValue("fields"))
            .Cascade(CascadeMode.Stop)
            .NotNull().OverridePropertyName("fields").WithMessage(RequiredErrorMessage)
            .When(x => x != null)
                .Must(x => x!.Type == JTokenType.Array).OverridePropertyName("fields").WithMessage(NotArrayErrorMessage)
        ;

        When(x => x.GetValue("fields") != null &&
                  x.GetValue("fields")!.Type == JTokenType.Array, () =>
        {
            RuleFor(x => x.Value<JArray>("fields"))
                .Cascade(CascadeMode.Stop)
                .Must(x => x!.Count > 0).OverridePropertyName("fields").WithMessage(string.Format(MinItemsErrorMessage, 1))
                .Must(x => x!.Count <= maxNumberFields).OverridePropertyName("fields").WithMessage(string.Format(MaxItemsErrorMessage, maxNumberFields));

            RuleForEach(x => x.Value<JArray>("fields")!.Select(y => (string?)y))
                .SetValidator(new FieldValidator(fieldNames, notAllowedFieldNames))
                .When(x => x.Value<JArray>("fields")!.Count > 0 && x.Value<JArray>("fields")!.Count <= maxNumberFields)
                .OverridePropertyName("fields");
        });
    }

    public class FieldValidator : AbstractValidator<string?>
    {
        public FieldValidator(IEnumerable<string> fieldNames, IEnumerable<string> notAllowedFieldNames)
        {
            RuleFor(x => x)
                .Cascade(CascadeMode.Stop)
                .Must(x => x != null).WithMessage(RequiredErrorMessage)
                .Matches(FieldPattern).WithMessage(FieldPatternErrorMessage)
                .Must(x => fieldNames.Contains(x)).WithMessage(FieldExistErrorMessage)
                .Must(x => !x.ContainsAny(notAllowedFieldNames)).WithMessage(FieldAllowedErrorMessage);
        }
    }
}
