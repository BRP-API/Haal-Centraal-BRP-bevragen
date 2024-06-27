using Brp.Shared.Infrastructure.Utils;
using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Infrastructure.Validatie.Validators;

public class DatumValidator : AbstractValidator<JObject>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string DatePattern = @"\d{4}-\d{2}-\d{2}";
    const string DateErrorMessage = "date||Waarde is geen geldige datum.";

    public DatumValidator(string parameterNaam, bool isVerplichtVeld = false)
    {
        if (isVerplichtVeld)
        {
            RuleFor(x => x.Value<string>(parameterNaam))
                .Cascade(CascadeMode.Stop)
                .NotEmpty().WithMessage(RequiredErrorMessage)
                .Matches(DatePattern).WithMessage(DateErrorMessage)
                .OverridePropertyName(parameterNaam)
                .Custom((datumTot, context) =>
                {
                    if (!datumTot.IsDateTime())
                    {
                        context.AddFailure(DateErrorMessage);
                    }
                })
                ;
        }
    }
}
