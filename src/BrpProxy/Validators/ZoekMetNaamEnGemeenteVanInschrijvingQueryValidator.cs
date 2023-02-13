using FluentValidation;
using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Validators;

public class ZoekMetNaamEnGemeenteVanInschrijvingQueryValidator : PersonenQueryValidator<ZoekMetNaamEnGemeenteVanInschrijving>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string GemeenteVanInschrijvingPattern = @"^[0-9]{4}$";
    const string GemeenteVanInschrijvingPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {GemeenteVanInschrijvingPattern}.";
    const string GeslachtPattern = @"^([Mm]|[Vv]|[Oo])$";
    const string GeslachtPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {GeslachtPattern}.";
    const string GeslachtsnaamPattern = @"^[a-zA-Z0-9À-ž \.\-\']{1,200}$|^[a-zA-Z0-9À-ž \.\-\']{3,199}\*{1}$";
    const string GeslachtsnaamPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {GeslachtsnaamPattern}.";
    const string VoornamenPattern = @"^[a-zA-Z0-9À-ž \.\-\']{1,200}$|^[a-zA-Z0-9À-ž \.\-\']{3,199}\*{1}$";
    const string VoornamenPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {VoornamenPattern}.";
    const string VoorvoegselPattern = @"^[a-zA-Z \']{1,10}$";
    const string VoorvoegselPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {VoorvoegselPattern}.";

    public ZoekMetNaamEnGemeenteVanInschrijvingQueryValidator(FieldsHelper fieldsHelper)
        : base(fieldsHelper)
    {
        RuleForEach(x => x.AdditionalProperties)
            .SetValidator(new AdditionalPropertiesValidator())
            .When(x => x.AdditionalProperties.Count > 0);

        RuleFor(x => x.GemeenteVanInschrijving)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(GemeenteVanInschrijvingPattern).WithMessage(GemeenteVanInschrijvingPatternErrorMessage);

        RuleFor(x => x.Geslacht)
            .Matches(GeslachtPattern).WithMessage(GeslachtPatternErrorMessage)
            .When(x => !string.IsNullOrWhiteSpace(x.Geslacht));

        RuleFor(x => x.Geslachtsnaam)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(GeslachtsnaamPattern).WithMessage(GeslachtsnaamPatternErrorMessage);

        RuleFor(x => x.Voornamen)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(VoornamenPattern).WithMessage(VoornamenPatternErrorMessage);

        RuleFor(x => x.Voorvoegsel)
            .Matches(VoorvoegselPattern).WithMessage(VoorvoegselPatternErrorMessage)
            .When(x => !string.IsNullOrWhiteSpace(x.Voorvoegsel));
    }
}
