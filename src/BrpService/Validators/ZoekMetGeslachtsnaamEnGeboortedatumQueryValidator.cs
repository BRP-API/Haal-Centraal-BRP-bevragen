using FluentValidation;
using HaalCentraal.BrpService.Generated;

namespace HaalCentraal.BrpService.Validators;

public class ZoekMetGeslachtsnaamEnGeboortedatumQueryValidator : AbstractValidator<ZoekMetGeslachtsnaamEnGeboortedatum>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string DatePattern = @"\d{4}-\d{2}-\d{2}";
    const string DateErrorMessage = "date||Waarde is geen geldige datum.";
    const string GeslachtPattern = @"^([Mm]|[Vv]|[Oo])$";
    const string GeslachtPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {GeslachtPattern}.";
    const string GeslachtsnaamPattern = @"^[a-zA-Z0-9À-ž \.\-\']{1,200}$|^[a-zA-Z0-9À-ž \.\-\']{3,199}\*{1}$";
    const string GeslachtsnaamPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {GeslachtsnaamPattern}.";
    const string VoornamenPattern = @"^[a-zA-Z0-9À-ž \.\-\']{1,199}\*{0,1}$";
    const string VoornamenPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {VoornamenPattern}.";
    const string VoorvoegselPattern = @"^[a-zA-Z \']{1,10}$";
    const string VoorvoegselPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {VoorvoegselPattern}.";

    public ZoekMetGeslachtsnaamEnGeboortedatumQueryValidator()
    {
        RuleFor(x => x.Geslachtsnaam)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(GeslachtsnaamPattern).WithMessage(GeslachtsnaamPatternErrorMessage);

        RuleFor(x => x.Geboortedatum)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(DatePattern).WithMessage(DateErrorMessage);

        RuleFor(x => x.Voornamen)
            .Matches(VoornamenPattern).WithMessage(VoornamenPatternErrorMessage)
            .When(x => !string.IsNullOrWhiteSpace(x.Voornamen));

        RuleFor(x => x.Voorvoegsel)
            .Matches(VoorvoegselPattern).WithMessage(VoorvoegselPatternErrorMessage)
            .When(x => !string.IsNullOrWhiteSpace(x.Voorvoegsel));

        RuleFor(x => x.Geslacht)
            .Matches(GeslachtPattern).WithMessage(GeslachtPatternErrorMessage)
            .When(x => !string.IsNullOrWhiteSpace(x.Geslacht));
    }
}
