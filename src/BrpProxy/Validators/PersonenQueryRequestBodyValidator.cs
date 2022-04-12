using FluentValidation;
using Newtonsoft.Json.Linq;

namespace BrpProxy.Validators
{
    public class PersonenQueryRequestBodyValidator : AbstractValidator<JObject>
    {
        const string RequiredErrorMessage = "required||Parameter is verplicht.";
        const string TypePattern = @"^ZoekMetGeslachtsnaamEnGeboortedatum|ZoekMetNaamEnGemeenteVanInschrijving$";
        const string TypePatternErrorMessage = "value||Waarde is geen geldig zoek type.";

        public PersonenQueryRequestBodyValidator()
        {
            RuleFor(x => x.Value<string>("type"))
                .Cascade(CascadeMode.Stop)
                .NotEmpty().WithMessage(RequiredErrorMessage)
                .Matches(TypePattern).WithMessage(TypePatternErrorMessage);
        }
    }
}
