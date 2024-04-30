using FluentValidation;
using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Validators;

public class ZoekMetAdresseerbaarObjectIdentificatieQueryValidator : AbstractValidator<ZoekMetAdresseerbaarObjectIdentificatie>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string AdresseerbaarObjectIdentificatiePattern = @"^[0-9]{16}$";
    const string AdresseerbaarObjectIdentificatiePatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {AdresseerbaarObjectIdentificatiePattern}.";
    const string MinItemsErrorMessage = "minItems||Array bevat minder dan {0} items.";
    const string MaxItemsErrorMessage = "maxItems||Array bevat meer dan {0} items.";

    public ZoekMetAdresseerbaarObjectIdentificatieQueryValidator(FieldsHelper fieldsHelper)
    {
        RuleForEach(x => x.AdditionalProperties)
            .SetValidator(new AdditionalPropertiesValidator())
            .When(x => x.AdditionalProperties.Count > 0);

        RuleFor(x => x.AdresseerbaarObjectIdentificatie)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(AdresseerbaarObjectIdentificatiePattern).WithMessage(AdresseerbaarObjectIdentificatiePatternErrorMessage);

        RuleFor(x => x.Fields)
            .Cascade(CascadeMode.Stop)
            .NotNull().WithMessage(RequiredErrorMessage)
            .Must(x => x!.Count > 0).WithMessage(string.Format(MinItemsErrorMessage, 1))
            .Must(x => x!.Count < 131).WithMessage(string.Format(MaxItemsErrorMessage, 130));

        RuleForEach(x => x.Fields)
            .SetValidator(new GezagPersoonBeperktFieldsValidator(fieldsHelper))
            .When(x => x.Fields != null && x.Fields.Count > 0 && x.Fields.Count < 131);
    }
}
