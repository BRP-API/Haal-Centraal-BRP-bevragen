using FluentValidation;
using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Validators;

public class RaadpleegMetBurgerservicenummerQueryValidator : AbstractValidator<RaadpleegMetBurgerservicenummer>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";

    public RaadpleegMetBurgerservicenummerQueryValidator(FieldsHelper fieldsHelper)
    {
        RuleFor(x => x.Fields)
            .NotNull().WithMessage(RequiredErrorMessage)
            .SetValidator(new PersoonFieldsValidator(fieldsHelper));
    }
}
