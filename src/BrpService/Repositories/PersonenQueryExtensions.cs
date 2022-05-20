using HaalCentraal.BrpService.Generated;

namespace HaalCentraal.BrpService.Repositories;

public static class PersonenQueryExtensions
{
    public static Specification<GbaPersoonBeperkt> ToSpecification(this ZoekMetGeslachtsnaamEnGeboortedatumFilter query)
    {
        var specification = new GeslachtsnaamSpecification(query.Geslachtsnaam)
            .And(new GeboorteDatumSpecification(query.Geboortedatum));

        if (!string.IsNullOrWhiteSpace(query.Voornamen))
        {
            specification = specification.And(new VoornamenSpecification(query.Voornamen));
        }
        if(!string.IsNullOrWhiteSpace(query.Voorvoegsel))
        {
            specification = specification.And(new VoorvoegselSpecification(query.Voorvoegsel));
        }
        if(!string.IsNullOrWhiteSpace(query.Geslachtsaanduiding))
        {
            specification = specification.And(new GeslachtSpecification(query.Geslachtsaanduiding));
        }
        if(!string.IsNullOrWhiteSpace(query.Geboorteplaats))
        {
            specification = specification.And(new GeboorteplaatsSpecification(query.Geboorteplaats));
        }
        specification = specification.And(new InclusiefOverledenPersonenSpecification(query.InclusiefOverledenPersonen));

        return specification;
    }

    public static Specification<GbaPersoon> ToSpecification(this RaadpleegMetBurgerservicenummer query)
    {
        return new BsnSpecification(query.Burgerservicenummer);
    }

    public static Specification<GbaPersoonBeperkt> ToSpecification(this ZoekMetPostcodeEnHuisnummerFilter query)
    {
        var specification = new PostcodeSpecification(query.Postcode)
            .And(new HuisnummerSpecification(query.Huisnummer));

        if (!string.IsNullOrWhiteSpace(query.Huisletter))
        {
            specification = specification.And(new HuisletterSpecification(query.Huisletter));
        }
        if (!string.IsNullOrWhiteSpace(query.Huisnummertoevoeging))
        {
            specification = specification.And(new HuisnummertoevoegingSpecification(query.Huisnummertoevoeging));
        }
        specification = specification.And(new InclusiefOverledenPersonenSpecification(query.InclusiefOverledenPersonen));

        return specification;
    }

    public static Specification<GbaPersoonBeperkt> ToSpecification(this ZoekMetNaamEnGemeenteVanInschrijvingFilter query)
    {
        var specification = new GeslachtsnaamSpecification(query.Geslachtsnaam)
            .And(new VoornamenSpecification(query.Voornamen))
            .And(new GemeenteVanInschrijvingSpecification(query.GemeenteVanInschrijving));

        if (!string.IsNullOrWhiteSpace(query.Voorvoegsel))
        {
            specification = specification.And(new VoorvoegselSpecification(query.Voorvoegsel));
        }

        return specification;
    }
}
