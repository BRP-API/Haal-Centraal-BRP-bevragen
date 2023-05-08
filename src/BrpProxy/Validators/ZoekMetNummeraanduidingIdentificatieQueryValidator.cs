using FluentValidation;
using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Validators;

public class ZoekMetNummeraanduidingIdentificatieQueryValidator : PersonenQueryValidator<ZoekMetNummeraanduidingIdentificatie>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string NummeraanduidingIdentificatiePattern = @"^[0-9]{16}$";
    const string NummeraanduidingIdentificatiePatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {NummeraanduidingIdentificatiePattern}.";

    public ZoekMetNummeraanduidingIdentificatieQueryValidator(FieldsHelper fieldsHelper)
        : base(fieldsHelper)
    {
        RuleForEach(x => x.AdditionalProperties)
            .SetValidator(new AdditionalPropertiesValidator())
            .When(x => x.AdditionalProperties.Count > 0);

        RuleFor(x => x.NummeraanduidingIdentificatie)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(NummeraanduidingIdentificatiePattern).WithMessage(NummeraanduidingIdentificatiePatternErrorMessage);
    }
}
