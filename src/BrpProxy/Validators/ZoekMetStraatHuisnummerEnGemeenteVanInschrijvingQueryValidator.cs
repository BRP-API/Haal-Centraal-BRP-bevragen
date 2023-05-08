using FluentValidation;
using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Validators;

public class ZoekMetStraatHuisnummerEnGemeenteVanInschrijvingQueryValidator : PersonenQueryValidator<ZoekMetStraatHuisnummerEnGemeenteVanInschrijving>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string HuisletterPattern = @"^[a-zA-Z]{1}$";
    const string HuisletterErrorMessage = $"pattern||Waarde voldoet niet aan patroon {HuisletterPattern}.";
    const string HuisnummertoevoegingPattern = @"^[a-zA-Z0-9 \-]{1,4}$";
    const string HuisnummertoevoegingErrorMessage = $"pattern||Waarde voldoet niet aan patroon {HuisnummertoevoegingPattern}.";
    const string StraatPattern = @"^[a-zA-Z0-9À-ž \-\'\.]{1,80}$|^[a-zA-Z0-9À-ž \-\'\.]{7,79}\*{1}$|^\*{1}[a-zA-Z0-9À-ž \-\'\.]{7,79}$";
    const string StraatPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {StraatPattern}.";

    public ZoekMetStraatHuisnummerEnGemeenteVanInschrijvingQueryValidator(FieldsHelper fieldsHelper)
        : base(fieldsHelper)
    {
        RuleForEach(x => x.AdditionalProperties)
            .SetValidator(new AdditionalPropertiesValidator())
            .When(x => x.AdditionalProperties.Count > 0);

        RuleFor(x => x.GemeenteVanInschrijving)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            ;

        RuleFor(x => x.Huisletter)
            .Cascade(CascadeMode.Stop)
            .Matches(HuisletterPattern).WithMessage(HuisletterErrorMessage)
            .When(x => !string.IsNullOrWhiteSpace(x.Huisletter));

        RuleFor(x => x.Huisnummer)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .SetValidator(new HuisnummerValidator());

        RuleFor(x => x.Huisnummertoevoeging)
            .Cascade(CascadeMode.Stop)
            .Matches(HuisnummertoevoegingPattern).WithMessage(HuisnummertoevoegingErrorMessage)
            .When(x => !string.IsNullOrWhiteSpace(x.Huisnummertoevoeging));

        RuleFor(x => x.Straat)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(StraatPattern).WithMessage(StraatPatternErrorMessage)
            ;

    }
}
