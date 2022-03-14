using HaalCentraal.BrpService.Generated;

namespace HaalCentraal.BrpService.Repositories
{
    public static class PersonenQueryExtensions
    {
        public static Specification<GbaPersoonBeperkt> ToSpecification(this ZoekMetGeslachtsnaamEnGeboortedatumFilter query)
        {
            var specification = new GeslachtsnaamSpecification(query.Geslachtsnaam).And(new GeboorteDatumSpecification(query.Geboortedatum));
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
                specification = specification.And(new GeslachtsaanduidingSpecification(query.Geslachtsaanduiding));
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
    }
}
