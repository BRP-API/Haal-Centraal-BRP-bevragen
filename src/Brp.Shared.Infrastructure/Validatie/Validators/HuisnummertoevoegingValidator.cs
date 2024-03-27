using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Infrastructure.Validatie.Validators;

public class HuisnummertoevoegingValidator : AbstractValidator<JObject>
{
    const string HuisnummertoevoegingPattern = @"^[a-zA-Z0-9 \-]{1,4}$";
    const string HuisnummertoevoegingErrorMessage = $"pattern||Waarde voldoet niet aan patroon {HuisnummertoevoegingPattern}.";

    public HuisnummertoevoegingValidator()
    {
        RuleFor(x => x.Value<string>("huisnummertoevoeging"))
            .Cascade(CascadeMode.Stop)
            .Matches(HuisnummertoevoegingPattern).WithMessage(HuisnummertoevoegingErrorMessage)
            .When(x => !string.IsNullOrWhiteSpace(x.Value<string>("huisnummertoevoeging")))
            .OverridePropertyName("huisnummertoevoeging");
    }
}
