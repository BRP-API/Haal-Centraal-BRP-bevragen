using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Infrastructure.Validatie.Validators;

public class BurgerservicenummerValidator : AbstractValidator<JObject>
{
    const string ParameterNaam = "burgerservicenummer";

    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string BsnPattern = @"^[0-9]{9}$";
    const string BsnPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {BsnPattern}.";

    public BurgerservicenummerValidator(bool isVerplichtVeld = false)
    {
        if (isVerplichtVeld)
        {
            RuleFor(x => x.Value<string>(ParameterNaam))
                .Cascade(CascadeMode.Stop)
                .NotEmpty().WithMessage(RequiredErrorMessage)
                .Matches(BsnPattern).WithMessage(BsnPatternErrorMessage)
                .OverridePropertyName(ParameterNaam)
                ;
        }
        else
        {
            RuleFor(x => x.Value<string>(ParameterNaam))
                .Cascade(CascadeMode.Stop)
                .Matches(BsnPattern).WithMessage(BsnPatternErrorMessage)
                .OverridePropertyName(ParameterNaam)
                ;
        }
    }
}
