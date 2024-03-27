using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Infrastructure.Validatie.Validators;

public class BurgerservicenummerVerplichtCollectieValidator : AbstractValidator<JObject>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string NotArrayErrorMessage = "array||Parameter is geen array.";
    const string MinItemsErrorMessage = "minItems||Array bevat minder dan {0} items.";
    const string MaxItemsErrorMessage = "maxItems||Array bevat meer dan {0} items.";
    const string BsnPattern = @"^[0-9]{9}$";
    const string BsnPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {BsnPattern}.";

    public BurgerservicenummerVerplichtCollectieValidator()
    {
        RuleFor(x => x.GetValue("burgerservicenummer"))
            .Cascade(CascadeMode.Stop)
            .NotNull().OverridePropertyName("burgerservicenummer").WithMessage(RequiredErrorMessage)
            .When(x => x != null)
                .Must(x => x!.Type == JTokenType.Array).OverridePropertyName("burgerservicenummer").WithMessage(NotArrayErrorMessage)
            ;

        When(x => x.GetValue("burgerservicenummer") != null &&
                  x.GetValue("burgerservicenummer")!.Type == JTokenType.Array, () =>
                  {
                      RuleFor(x => x.Value<JArray>("burgerservicenummer"))
                          .Cascade(CascadeMode.Stop)
                          .Must(x => x!.Count > 0).OverridePropertyName("burgerservicenummer").WithMessage(string.Format(MinItemsErrorMessage, 1))
                          .Must(x => x!.Count <= 20).OverridePropertyName("burgerservicenummer").WithMessage(string.Format(MaxItemsErrorMessage, 20));

                      RuleForEach(x => x.Value<JArray>("burgerservicenummer")!.Select(y => (string?)y))
                          .Matches(BsnPattern).OverridePropertyName("burgerservicenummer").WithMessage(BsnPatternErrorMessage);
                  });
    }
}
