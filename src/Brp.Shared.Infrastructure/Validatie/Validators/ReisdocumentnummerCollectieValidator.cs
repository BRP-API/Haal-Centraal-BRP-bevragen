using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Infrastructure.Validatie.Validators;

public class ReisdocumentnummerCollectieValidator : AbstractValidator<JObject>
{
    const string ParameterNaam = "reisdocumentnummer";

    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string NotArrayErrorMessage = "array||Parameter is geen array.";
    const string MinItemsErrorMessage = "minItems||Array bevat minder dan {0} items.";
    const string MaxItemsErrorMessage = "maxItems||Array bevat meer dan {0} items.";
    const string ReisdocumentnummerPattern = @"^[A-Z0-9]{9}$";
    const string ReisdocumentnummerPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {ReisdocumentnummerPattern}.";

    public ReisdocumentnummerCollectieValidator(bool isVerplichtVeld = false)
    {
        if (isVerplichtVeld)
        {
            RuleFor(x => x.GetValue(ParameterNaam))
                .Cascade(CascadeMode.Stop)
                .NotNull().WithMessage(RequiredErrorMessage)
                .When(x => x != null)
                    .Must(x => x!.Type == JTokenType.Array).WithMessage(NotArrayErrorMessage)
                .OverridePropertyName(ParameterNaam)
                ;
        }

        When(x => x.GetValue(ParameterNaam) != null &&
                  x.GetValue(ParameterNaam)!.Type == JTokenType.Array, () =>
                  {
                      RuleFor(x => x.Value<JArray>(ParameterNaam))
                          .Cascade(CascadeMode.Stop)
                          .Must(x => x!.Count > 0).WithMessage(string.Format(MinItemsErrorMessage, 1))
                          .Must(x => x!.Count <= 1).WithMessage(string.Format(MaxItemsErrorMessage, 1))
                          .OverridePropertyName(ParameterNaam)
                          ;

                      RuleForEach(x => x.Value<JArray>(ParameterNaam)!.Select(y => (string?)y))
                          .Matches(ReisdocumentnummerPattern).WithMessage(ReisdocumentnummerPatternErrorMessage)
                          .OverridePropertyName(ParameterNaam)
                          ;
                  });
    }
}
