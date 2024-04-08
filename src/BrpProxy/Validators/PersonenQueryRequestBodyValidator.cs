using FluentValidation;
using Newtonsoft.Json.Linq;

namespace BrpProxy.Validators
{
    public class PersonenQueryRequestBodyValidator : AbstractValidator<JObject>
    {
        const string RequiredErrorMessage = "required||Parameter is verplicht.";
        const string TypePattern = @"^ZoekMetAdresseerbaarObjectIdentificatie|ZoekMetGeslachtsnaamEnGeboortedatum|ZoekMetNaamEnGemeenteVanInschrijving|RaadpleegMetBurgerservicenummer|ZoekMetPostcodeEnHuisnummer|ZoekMetStraatHuisnummerEnGemeenteVanInschrijving|ZoekMetNummeraanduidingIdentificatie$";
        const string TypePatternErrorMessage = "value||Waarde is geen geldig zoek type.";

        public PersonenQueryRequestBodyValidator()
        {
            RuleFor(x => x.Value<string>("type"))
                .Cascade(CascadeMode.Stop)
                .NotNull().WithMessage(RequiredErrorMessage)
                .Matches(TypePattern).WithMessage(TypePatternErrorMessage);
        }
    }
}
