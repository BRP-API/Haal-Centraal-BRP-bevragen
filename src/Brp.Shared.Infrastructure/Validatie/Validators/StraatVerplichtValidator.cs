using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Infrastructure.Validatie.Validators;

public class StraatVerplichtValidator : AbstractValidator<JObject>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string StraatPattern = @"^[a-zA-Z0-9À-ž \-\'\.]{1,80}$|^[a-zA-Z0-9À-ž \-\'\.]{7,79}\*{1}$|^\*{1}[a-zA-Z0-9À-ž \-\'\.]{7,79}$";
    const string StraatPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {StraatPattern}.";

    public StraatVerplichtValidator()
    {
        RuleFor(x => x.Value<string>("straat"))
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(StraatPattern).WithMessage(StraatPatternErrorMessage)
            .OverridePropertyName("straat");
    }
}
