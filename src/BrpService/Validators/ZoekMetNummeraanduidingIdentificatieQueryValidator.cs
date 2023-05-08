using FluentValidation;
using HaalCentraal.BrpService.Generated;

namespace HaalCentraal.BrpService.Validators;

public class ZoekMetNummeraanduidingIdentificatieQueryValidator : AbstractValidator<ZoekMetNummeraanduidingIdentificatie>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string NummeraanduidingIdentificatiePattern = @"^[0-9]{16}$";
    const string NummeraanduidingIdentificatiePatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {NummeraanduidingIdentificatiePattern}.";

    public ZoekMetNummeraanduidingIdentificatieQueryValidator()
    {
        RuleFor(x => x.NummeraanduidingIdentificatie)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(NummeraanduidingIdentificatiePattern).WithMessage(NummeraanduidingIdentificatiePatternErrorMessage);
    }
}
