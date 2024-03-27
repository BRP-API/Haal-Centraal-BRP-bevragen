using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Infrastructure.Validatie.Validators;

public class InclusiefOverledenPersonenOptioneelValidator : AbstractValidator<JObject>
{
    public InclusiefOverledenPersonenOptioneelValidator()
    {
        RuleFor(x => x.Value<string>("inclusiefOverledenPersonen"))
            .Must(y => bool.TryParse(y, out var inclusiefOverledenPersonen)).WithMessage("boolean||Waarde is geen boolean.")
            .OverridePropertyName("inclusiefOverledenPersonen")
            .When(x => x.Properties().Any(p => p.Name == "inclusiefOverledenPersonen"));
    }
}
