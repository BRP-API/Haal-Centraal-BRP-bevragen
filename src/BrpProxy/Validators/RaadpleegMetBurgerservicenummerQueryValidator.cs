﻿using FluentValidation;
using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Validators;

public class RaadpleegMetBurgerservicenummerQueryValidator : AbstractValidator<RaadpleegMetBurgerservicenummer>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string MinItemsErrorMessage = "minItems||Array bevat minder dan {0} items.";
    const string MaxItemsErrorMessage = "maxItems||Array bevat meer dan {0} items.";
    const string BsnPattern = @"^[0-9]{9}$";
    const string BsnPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {BsnPattern}.";

    public RaadpleegMetBurgerservicenummerQueryValidator(FieldsHelper fieldsHelper)
    {
        RuleFor(x => x.Burgerservicenummer)
            .Cascade(CascadeMode.Stop)
            .NotNull().WithMessage(RequiredErrorMessage)
            .Must(x => x.Count > 0).WithMessage(string.Format(MinItemsErrorMessage, 1))
            .Must(x => x.Count <= 20).WithMessage(string.Format(MaxItemsErrorMessage, 20));

        RuleForEach(x => x.Burgerservicenummer)
            .Matches(BsnPattern).WithMessage(BsnPatternErrorMessage);

        RuleFor(x => x.Fields)
            .Cascade(CascadeMode.Stop)
            .NotNull().WithMessage(RequiredErrorMessage)
            .Must(x => x!.Count > 0).WithMessage(string.Format(MinItemsErrorMessage, 1))
            .Must(x => x!.Count < 131).WithMessage(string.Format(MaxItemsErrorMessage, 130));

        RuleForEach(x => x.Fields)
            .SetValidator(new PersoonFieldsValidator(fieldsHelper))
            .When(x => x.Fields != null && x.Fields.Count > 0 && x.Fields.Count < 131);
    }
}
