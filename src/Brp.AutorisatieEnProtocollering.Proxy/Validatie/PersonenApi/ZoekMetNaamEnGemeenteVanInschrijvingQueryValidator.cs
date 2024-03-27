using Brp.Shared.Infrastructure.Validatie.Validators;
using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.AutorisatieEnProtocollering.Proxy.Validatie.PersonenApi;

public class ZoekMetNaamEnGemeenteVanInschrijvingQueryValidator : AbstractValidator<JObject>
{
    public ZoekMetNaamEnGemeenteVanInschrijvingQueryValidator()
    {
        Include(new NietGespecificeerdeParametersValidator(GespecificeerdeParameterNamen));
        Include(new GemeenteVanInschrijvingValidator(isVerplichtVeld: true));
        Include(new GeslachtsnaamVerplichtValidator());
        Include(new VoornamenValidator(isVerplichtVeld: true));
        Include(new VoorvoegselOptioneelValidator());
        Include(new GeslachtOptioneelValidator());
        Include(new InclusiefOverledenPersonenOptioneelValidator());
        Include(new FieldsValidator(Constanten.PersoonBeperktFields, Constanten.NotAllowedPersoonFields));
    }

    private readonly List<string> GespecificeerdeParameterNamen = new()
    {
        "type",
        "gemeenteVanInschrijving",
        "geslacht",
        "geslachtsnaam",
        "voornamen",
        "voorvoegsel",
        "inclusiefOverledenPersonen",
        "fields"
    };
}
