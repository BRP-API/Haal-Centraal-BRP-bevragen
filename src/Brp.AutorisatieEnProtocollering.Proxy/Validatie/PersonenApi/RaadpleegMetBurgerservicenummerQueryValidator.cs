using Brp.Shared.Infrastructure.Validatie.Validators;
using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.AutorisatieEnProtocollering.Proxy.Validatie.PersonenApi;

public class RaadpleegMetBurgerservicenummerQueryValidator : AbstractValidator<JObject>
{

    public RaadpleegMetBurgerservicenummerQueryValidator()
    {
        Include(new NietGespecificeerdeParametersValidator(GespecificeerdeParameterNamen));
        Include(new BurgerservicenummerVerplichtCollectieValidator());
        Include(new GemeenteVanInschrijvingValidator());
        Include(new FieldsValidator(Constanten.PersoonFields, Constanten.NotAllowedPersoonFields));
    }

    private readonly List<string> GespecificeerdeParameterNamen = new()
    {
        "type",
        "burgerservicenummer",
        "fields",
        "gemeenteVanInschrijving"
    };
}
