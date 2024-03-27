using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Infrastructure.Validatie.Validators;

public class GeslachtOptioneelValidator : AbstractValidator<JObject>
{
    const string GeslachtPattern = @"^([Mm]|[Vv]|[Oo])$";
    const string GeslachtPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {GeslachtPattern}.";

    public GeslachtOptioneelValidator()
    {
        RuleFor(x => x.Value<string>("geslacht"))
            .Matches(GeslachtPattern).WithMessage(GeslachtPatternErrorMessage)
            .OverridePropertyName("geslacht");
    }
}
