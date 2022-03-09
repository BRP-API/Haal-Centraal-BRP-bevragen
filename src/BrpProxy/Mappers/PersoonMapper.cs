using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Mappers
{
    public static class PersoonMapper
    {
        public static Persoon Map(this GbaPersoon persoon)
        {
            return new Persoon
            {
                Burgerservicenummer = persoon.Burgerservicenummer,
                //Geboorte = persoon.Geboorte.Map(),
                //Naam = persoon.Naam.Map(persoon.Partners),
                //Verblijfplaats = persoon.Verblijfplaats.Map()
            };
        }

        public static PersoonBeperkt Map(this GbaPersoonBeperkt persoon)
        {
            return new PersoonBeperkt
            {
                Burgerservicenummer = persoon.Burgerservicenummer,
                Geboorte = persoon.Geboorte.Map(),
                Naam = persoon.Naam.Map()
            };
        }

        public static ICollection<Persoon> Map(this ICollection<GbaPersoon> personen)
        {
            var retval = new List<Persoon>();

            foreach (var item in personen)
            {
                retval.Add(item.Map());
            }

            return retval;
        }

        public static ICollection<PersoonBeperkt> Map(this ICollection<GbaPersoonBeperkt> personen)
        {
            var retval = new List<PersoonBeperkt>();

            foreach (var item in personen)
            {
                retval.Add(item.Map());
            }

            return retval;
        }
    }
}
