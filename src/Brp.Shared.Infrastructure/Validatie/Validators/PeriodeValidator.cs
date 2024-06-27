using Brp.Shared.Infrastructure.Utils;
using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Infrastructure.Validatie.Validators;

public class PeriodeValidator : AbstractValidator<JObject>
{
    public PeriodeValidator(string naamVanParameter, string naamTotParameter)
    {
        Include(new DatumValidator(naamTotParameter, true));
        Include(new DatumValidator(naamVanParameter, true));

        RuleFor(x => x.Value<string>(naamTotParameter)!.ToDateTimeOffset())
            .GreaterThan(x => x.Value<string>(naamVanParameter)!.ToDateTimeOffset()).WithMessage($"date||{naamTotParameter} moet na {naamVanParameter} liggen.")
            .OverridePropertyName(naamTotParameter)
            .When(x => x.Value<string>(naamTotParameter).IsDateTime() && x.Value<string>(naamVanParameter).IsDateTime());
    }
}
