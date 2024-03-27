using Brp.Shared.Infrastructure.Validatie.Validators;
using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.AutorisatieEnProtocollering.Proxy.Validatie.PersonenApi;

public class ZoekMetGeslachtsnaamEnGeboortedatumQueryValidator : AbstractValidator<JObject>
{
    public ZoekMetGeslachtsnaamEnGeboortedatumQueryValidator()
    {
        Include(new NietGespecificeerdeParametersValidator(GespecificeerdeParameterNamen));
        Include(new GeboortedatumVerplichtValidator());
        Include(new GeslachtsnaamVerplichtValidator());
        Include(new VoornamenValidator());
        Include(new VoorvoegselOptioneelValidator());
        Include(new GeslachtOptioneelValidator());
        Include(new InclusiefOverledenPersonenOptioneelValidator());
        Include(new GemeenteVanInschrijvingValidator());
        Include(new FieldsValidator(Constanten.PersoonBeperktFields, Constanten.NotAllowedPersoonFields));
    }

    private readonly List<string> GespecificeerdeParameterNamen = new()
    {
        "type",
        "geboortedatum",
        "geslachtsnaam",
        "voornamen",
        "voorvoegsel",
        "geslacht",
        "inclusiefOverledenPersonen",
        "gemeenteVanInschrijving",
        "fields"
    };
}
