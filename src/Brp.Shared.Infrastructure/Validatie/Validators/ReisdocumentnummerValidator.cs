using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Infrastructure.Validatie.Validators;

public class ReisdocumentnummerValidator : AbstractValidator<JObject>
{
    const string ParameterNaam = "reisdocumentnummer";

    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string ReisdocumentnummerPattern = @"^[0-9]{9}$";
    const string ReisdocumentnummerPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {ReisdocumentnummerPattern}.";

    public ReisdocumentnummerValidator(bool isVerplichtVeld = false)
    {
        if (isVerplichtVeld)
        {
            RuleFor(x => x.Value<string>(ParameterNaam))
                .Cascade(CascadeMode.Stop)
                .NotEmpty().WithMessage(RequiredErrorMessage)
                .Matches(ReisdocumentnummerPattern).WithMessage(ReisdocumentnummerPatternErrorMessage)
                .OverridePropertyName(ParameterNaam)
                ;
        }
        else
        {
            RuleFor(x => x.Value<string>(ParameterNaam))
                .Cascade(CascadeMode.Stop)
                .Matches(ReisdocumentnummerPattern).WithMessage(ReisdocumentnummerPatternErrorMessage)
                .OverridePropertyName(ParameterNaam)
                ;
        }
    }
}
