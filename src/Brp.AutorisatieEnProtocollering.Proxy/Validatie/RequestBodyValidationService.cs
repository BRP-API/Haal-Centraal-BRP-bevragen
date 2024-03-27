using Brp.AutorisatieEnProtocollering.Proxy.Validatie.PersonenApi;
using Brp.Shared.Infrastructure.Validatie;
using Brp.Shared.Infrastructure.Validatie.Validators;
using FluentValidation.Results;
using Newtonsoft.Json.Linq;

namespace Brp.AutorisatieEnProtocollering.Proxy.Validatie;

public class RequestBodyValidationService : IRequestBodyValidator
{
    public ValidationResult ValidateRequestBody(string requestBody)
    {
        var input = JObject.Parse(requestBody);
        return input.Value<string>("type") switch
        {
            "RaadpleegMetBurgerservicenummer" => new RaadpleegMetBurgerservicenummerQueryValidator().Validate(input),
            "ZoekMetGeslachtsnaamEnGeboortedatum" => new ZoekMetGeslachtsnaamEnGeboortedatumQueryValidator().Validate(input),
            "ZoekMetNaamEnGemeenteVanInschrijving" => new ZoekMetNaamEnGemeenteVanInschrijvingQueryValidator().Validate(input),
            "ZoekMetNummeraanduidingIdentificatie" => new ZoekMetNummeraanduidingIdentificatieQueryValidator().Validate(input),
            "ZoekMetPostcodeEnHuisnummer" => new ZoekMetPostcodeEnHuisnummerQueryValidator().Validate(input),
            "ZoekMetStraatHuisnummerEnGemeenteVanInschrijving" => new ZoekMetStraatHuisnummerEnGemeenteVanInschrijvingQueryValidator().Validate(input),
            _ => new RequestBodyValidator(new string[] {
                        "RaadpleegMetBurgerservicenummer",
                        "ZoekMetGeslachtsnaamEnGeboortedatum",
                        "ZoekMetNaamEnGemeenteVanInschrijving",
                        "ZoekMetNummeraanduidingIdentificatie",
                        "ZoekMetPostcodeEnHuisnummer",
                        "ZoekMetStraatHuisnummerEnGemeenteVanInschrijving"
                    }).Validate(input),
        };
    }
}
