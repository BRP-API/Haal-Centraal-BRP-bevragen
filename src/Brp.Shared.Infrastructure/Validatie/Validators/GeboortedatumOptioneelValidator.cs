using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Infrastructure.Validatie.Validators;

public class GeboortedatumOptioneelValidator : AbstractValidator<JObject>
{
    const string DatePattern = @"\d{4}-\d{2}-\d{2}";
    const string DateErrorMessage = "date||Waarde is geen geldige datum.";

    public GeboortedatumOptioneelValidator()
    {
        RuleFor(x => x.Value<string>("geboortedatum"))
            .Cascade(CascadeMode.Stop)
            .Matches(DatePattern).WithMessage(DateErrorMessage)
            .OverridePropertyName("geboortedatum");
    }
}
