using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Infrastructure.Validatie.Validators;

public class NummeraanduidingIdentificatieVerplichtValidator : AbstractValidator<JObject>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string NummeraanduidingIdentificatiePattern = @"^[0-9]{16}$";
    const string NummeraanduidingIdentificatiePatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {NummeraanduidingIdentificatiePattern}.";

    public NummeraanduidingIdentificatieVerplichtValidator()
    {
        RuleFor(x => x.Value<string>("nummeraanduidingIdentificatie"))
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(NummeraanduidingIdentificatiePattern).WithMessage(NummeraanduidingIdentificatiePatternErrorMessage)
            .OverridePropertyName("nummeraanduidingIdentificatie");
    }
}
