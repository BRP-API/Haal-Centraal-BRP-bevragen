using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Infrastructure.Validatie.Validators;

public class HuisletterValidator : AbstractValidator<JObject>
{
    const string HuisletterPattern = @"^[a-zA-Z]{1}$";
    const string HuisletterErrorMessage = $"pattern||Waarde voldoet niet aan patroon {HuisletterPattern}.";

    public HuisletterValidator()
    {
        RuleFor(x => x.Value<string>("huisletter"))
            .Cascade(CascadeMode.Stop)
            .Matches(HuisletterPattern).WithMessage(HuisletterErrorMessage)
            .When(x => !string.IsNullOrWhiteSpace(x.Value<string>("huisletter")))
            .OverridePropertyName("huisletter");
    }
}
