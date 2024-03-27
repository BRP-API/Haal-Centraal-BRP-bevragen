using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Infrastructure.Validatie.Validators;

public class RequestBodyValidator : AbstractValidator<JObject>
{
    const string RequiredErrorMessage = "type||required||Parameter is verplicht.";
    const string TypePatternErrorMessage = "type||value||Waarde is geen geldig zoek type.";

    public RequestBodyValidator(string[] types)
    {
        var typePattern = $"^{string.Join('|', types)}$";

        RuleFor(x => x.Value<string>("type"))
            .Cascade(CascadeMode.Stop)
            .NotNull().WithMessage(RequiredErrorMessage)
            .Matches(typePattern).WithMessage(TypePatternErrorMessage);
    }
}
