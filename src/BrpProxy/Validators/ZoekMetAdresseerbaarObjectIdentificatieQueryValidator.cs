using FluentValidation;
using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Validators;

public class ZoekMetAdresseerbaarObjectIdentificatieQueryValidator : PersonenQueryValidator<ZoekMetAdresseerbaarObjectIdentificatie>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string AdresseerbaarObjectIdentificatiePattern = @"^[0-9]{16}$";
    const string AdresseerbaarObjectIdentificatiePatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {AdresseerbaarObjectIdentificatiePattern}.";

    public ZoekMetAdresseerbaarObjectIdentificatieQueryValidator(FieldsHelper fieldsHelper)
        : base(fieldsHelper)
    {
        RuleForEach(x => x.AdditionalProperties)
            .SetValidator(new AdditionalPropertiesValidator())
            .When(x => x.AdditionalProperties.Count > 0);

        RuleFor(x => x.AdresseerbaarObjectIdentificatie)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(AdresseerbaarObjectIdentificatiePattern).WithMessage(AdresseerbaarObjectIdentificatiePatternErrorMessage);
    }
}
