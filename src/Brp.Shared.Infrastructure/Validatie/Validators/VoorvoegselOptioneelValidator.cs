using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Infrastructure.Validatie.Validators;

public class VoorvoegselOptioneelValidator : AbstractValidator<JObject>
{
    const string VoorvoegselPattern = @"^[a-zA-Z \']{1,10}$";
    const string VoorvoegselPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {VoorvoegselPattern}.";

    public VoorvoegselOptioneelValidator()
    {
        RuleFor(x => x.Value<string>("voorvoegsel"))
            .Cascade(CascadeMode.Stop)
            .Matches(VoorvoegselPattern).WithMessage(VoorvoegselPatternErrorMessage)
            .OverridePropertyName("voorvoegsel");
    }
}
