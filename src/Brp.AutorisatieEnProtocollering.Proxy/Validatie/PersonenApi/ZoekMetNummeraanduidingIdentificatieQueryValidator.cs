using Brp.Shared.Infrastructure.Validatie.Validators;
using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.AutorisatieEnProtocollering.Proxy.Validatie.PersonenApi;

public class ZoekMetNummeraanduidingIdentificatieQueryValidator : AbstractValidator<JObject>
{
    public ZoekMetNummeraanduidingIdentificatieQueryValidator()
    {
        Include(new NietGespecificeerdeParametersValidator(GespecificeerdeParameterNamen));
        Include(new NummeraanduidingIdentificatieVerplichtValidator());
        Include(new InclusiefOverledenPersonenOptioneelValidator());
        Include(new GemeenteVanInschrijvingValidator());
        Include(new FieldsValidator(Constanten.PersoonBeperktFields, Constanten.NotAllowedPersoonFields));
    }

    private readonly List<string> GespecificeerdeParameterNamen = new()
    {
        "type",
        "gemeenteVanInschrijving",
        "nummeraanduidingIdentificatie",
        "inclusiefOverledenPersonen",
        "fields"
    };
}
