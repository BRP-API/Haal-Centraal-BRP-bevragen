using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Middlewares
{
    public static class AfgevoerdePersoonHelpers
    {
        public static ICollection<Persoon> FilterAfgevoerdePersoon(this ICollection<Persoon> personen)
        {
            var retval = new List<Persoon>();

            foreach (var p in personen)
            {
                if (p.OpschortingBijhouding?.Reden?.Code == "F")
                {
                    p.Adressering = null;
                    p.DatumEersteInschrijvingGBA = null;
                    p.DatumInschrijvingInGemeente = null;
                    p.EuropeesKiesrecht = null;
                    p.Geboorte = null;
                    p.GeheimhoudingPersoonsgegevens = false;
                    p.GemeenteVanInschrijving = null;
                    p.Geslacht = null;
                    p.Immigratie = null;
                    p.IndicatieCurateleRegister = false;
                    p.IndicatieGezagMinderjarige = null;
                    p.InOnderzoek = null;
                    p.Kinderen = null;
                    p.Leeftijd = 0;
                    p.Naam = null;
                    p.Nationaliteiten = null;
                    p.Ouders = null;
                    p.Overlijden = null;
                    p.Partners = null;
                    p.Rni = null;
                    p.UitsluitingKiesrecht = null;
                    p.Verblijfplaats = null;
                    p.Verblijfstitel = null;
                    p.Verificatie = null;
                }
                retval.Add(p);
            }

            return retval;
        }

        public static ICollection<PersoonBeperkt> ExcludeAfgevoerdePersoon(this ICollection<PersoonBeperkt> personen)
        {
            var retval = new List<PersoonBeperkt>();

            foreach(var p in personen)
            {
                if(p.OpschortingBijhouding?.Reden?.Code != "F")
                {
                    retval.Add(p);
                }
            }

            return retval;
        }

        public static ICollection<GezagPersoonBeperkt> ExcludeAfgevoerdePersoon(this ICollection<GezagPersoonBeperkt> personen)
        {
            var retval = new List<GezagPersoonBeperkt>();

            foreach (var p in personen)
            {
                if (p.OpschortingBijhouding?.Reden?.Code != "F")
                {
                    retval.Add(p);
                }
            }

            return retval;
        }
    }
}
