using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Infrastructure.Validatie.Validators;

public class PostcodeVerplichtValidator : AbstractValidator<JObject>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string PostcodePattern = @"^[1-9]{1}[0-9]{3}[ ]?[A-Za-z]{2}$";
    const string PostcodeErrorMessage = $"pattern||Waarde voldoet niet aan patroon {PostcodePattern}.";

    public PostcodeVerplichtValidator()
    {
        RuleFor(x => x.Value<string>("postcode"))
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(PostcodePattern).WithMessage(PostcodeErrorMessage)
            .OverridePropertyName("postcode");
    }
}
