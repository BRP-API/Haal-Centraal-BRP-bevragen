using FluentValidation;
using HaalCentraal.BrpService.Generated;

namespace HaalCentraal.BrpService.Validators;

public class ZoekMetPostcodeEnHuisnummerQueryValidator : AbstractValidator<ZoekMetPostcodeEnHuisnummer>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string HuisletterPattern = @"^[a-zA-Z]{1}$";
    const string HuisletterErrorMessage = $"pattern||Waarde voldoet niet aan patroon {HuisletterPattern}.";
    const string HuisnummertoevoegingPattern = @"^[a-zA-Z0-9 \-]{1,4}$";
    const string HuisnummertoevoegingErrorMessage = $"pattern||Waarde voldoet niet aan patroon {HuisnummertoevoegingPattern}.";
    const string NumberPattern = @"^[1-9]{1}[0-9]{0,4}$";
    const string NumberErrorMessage = "integer||Waarde is geen geldig getal.";
    const string PostcodePattern = @"^[1-9]{1}[0-9]{3}[ ]?[A-Za-z]{2}$";
    const string PostcodeErrorMessage = $"pattern||Waarde voldoet niet aan patroon {PostcodePattern}.";

    public ZoekMetPostcodeEnHuisnummerQueryValidator()
    {
        RuleFor(x => x.Postcode)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(PostcodePattern).WithMessage(PostcodeErrorMessage);

        RuleFor(x => x.Huisnummer)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(NumberPattern).WithMessage(NumberErrorMessage);

        RuleFor(x => x.Huisletter)
            .Cascade(CascadeMode.Stop)
            .Matches(HuisletterPattern).WithMessage(HuisletterErrorMessage)
            .When(x => !string.IsNullOrWhiteSpace(x.Huisletter));

        RuleFor(x => x.Huisnummertoevoeging)
            .Cascade(CascadeMode.Stop)
            .Matches(HuisnummertoevoegingPattern).WithMessage(HuisnummertoevoegingErrorMessage)
            .When(x => !string.IsNullOrWhiteSpace(x.Huisnummertoevoeging));
    }
}
