using FluentValidation;
using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Validators;

public class ZoekMetNaamEnGemeenteVanInschrijvingQueryValidator : PersonenQueryValidator<ZoekMetNaamEnGemeenteVanInschrijving>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string GeslachtsnaamPattern = @"^[a-zA-Z0-9À-ž \.\-\']{1,200}$|^[a-zA-Z0-9À-ž \.\-\']{3,199}\*{1}$";
    const string GeslachtsnaamPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {GeslachtsnaamPattern}.";
    const string VoornamenPattern = @"^[a-zA-Z0-9À-ž \.\-\']{1,200}$";
    const string VoornamenPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {VoornamenPattern}.";
    const string GemeenteVanInschrijvingPattern = @"^[0-9]{4}$";
    const string GemeenteVanInschrijvingPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {GemeenteVanInschrijvingPattern}.";

    public ZoekMetNaamEnGemeenteVanInschrijvingQueryValidator(FieldsHelper fieldsHelper)
        : base(fieldsHelper)
    {
        RuleFor(x => x.Geslachtsnaam)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(GeslachtsnaamPattern).WithMessage(GeslachtsnaamPatternErrorMessage);

        RuleFor(x => x.Voornamen)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(VoornamenPattern).WithMessage(VoornamenPatternErrorMessage);

        RuleFor(x => x.GemeenteVanInschrijving)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(GemeenteVanInschrijvingPattern).WithMessage(GemeenteVanInschrijvingPatternErrorMessage);
    }
}
