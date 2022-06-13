using FluentValidation;
using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Validators;

public class ZoekMetStraatHuisnummerEnGemeenteVanInschrijvingQueryValidator : PersonenQueryValidator<ZoekMetStraatHuisnummerEnGemeenteVanInschrijving>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string NumberPattern = @"\d+";
    const string NumberErrorMessage = "integer||Waarde is geen geldig getal.";
    const string StraatPattern = @"^[a-zA-Z0-9À-ž \-\'\.]{1,80}$|^[a-zA-Z0-9À-ž \-\'\.]{7,79}\*{1}$|^\*{1}[a-zA-Z0-9À-ž \-\'\.]{7,79}$";
    const string StraatPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {StraatPattern}.";

    public ZoekMetStraatHuisnummerEnGemeenteVanInschrijvingQueryValidator(FieldsHelper fieldsHelper)
        : base(fieldsHelper)
    {
        RuleFor(x => x.Straat)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(StraatPattern).WithMessage(StraatPatternErrorMessage)
            ;

        RuleFor(x => x.Huisnummer)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(NumberPattern).WithMessage(NumberErrorMessage)
            ;

        RuleFor(x => x.GemeenteVanInschrijving)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            ;
    }
}
