using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Infrastructure.Validatie.Validators;

public class HuisnummerVerplichtValidator : AbstractValidator<JObject>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string NumberPattern = @"^\d+$";
    const string NumberErrorMessage = "integer||Waarde is geen geldig getal.";
    const string HuisnummerMinimumErrorMessage = "minimum||Waarde is lager dan minimum 1.";
    const string HuisnummerMaximumErrorMessage = "maximum||Waarde is hoger dan maximum 99999.";

    private static int? StringToNullableInt(string? value) =>
        int.TryParse(value, out var result)
            ? result
            : null;
    public HuisnummerVerplichtValidator()
    {
        RuleFor(x => x.Value<string>("huisnummer"))
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(NumberPattern).WithMessage(NumberErrorMessage)
            .OverridePropertyName("huisnummer");

        RuleFor(x => StringToNullableInt(x.Value<string>("huisnummer")))
            .Cascade(CascadeMode.Stop)
            .GreaterThan(0).WithMessage(HuisnummerMinimumErrorMessage)
            .LessThan(100000).WithMessage(HuisnummerMaximumErrorMessage)
            .OverridePropertyName("huisnummer");
    }
}
