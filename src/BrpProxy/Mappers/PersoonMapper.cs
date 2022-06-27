using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Mappers
{
    public static class PersoonMapper
    {
        public static bool Geheimhouding(this GbaPersoon persoon)
        {
            return persoon.GeheimhoudingPersoonsgegevens > 0;
        }

        public static PersoonInOnderzoek? InOnderzoek(this GbaPersoon persoon)
        {
            if(persoon.PersoonInOnderzoek == null &&
                persoon.GezagInOnderzoek == null &&
                persoon.Verblijfplaats?.InOnderzoek == null)
            {
                return null;
            }

            PersoonInOnderzoek retval = new();

            if(persoon.PersoonInOnderzoek != null)
            {
                switch (persoon.PersoonInOnderzoek.AanduidingGegevensInOnderzoek)
                {
                    case "010000":
                        retval.Burgerservicenummer = true;
                        retval.Geslacht = true;
                        retval.Leeftijd = true;
                        retval.DatumIngangOnderzoekPersoon = persoon.PersoonInOnderzoek.DatumIngangOnderzoek?.Map();
                        break;
                    case "010100":
                    case "010120":
                        retval.Burgerservicenummer = true;
                        retval.DatumIngangOnderzoekPersoon = persoon.PersoonInOnderzoek.DatumIngangOnderzoek?.Map();
                        break;
                    case "010400":
                    case "010410":
                        retval.Geslacht = true;
                        retval.DatumIngangOnderzoekPersoon = persoon.PersoonInOnderzoek.DatumIngangOnderzoek?.Map();
                        break;
                    default:
                        break;
                }
            }

            if(persoon.GezagInOnderzoek != null)
            {
                switch (persoon.GezagInOnderzoek.AanduidingGegevensInOnderzoek)
                {
                    case "110000":
                        retval.IndicatieGezagMinderjarige = true;
                        retval.IndicatieCurateleRegister = true;
                        retval.DatumIngangOnderzoekGezag = persoon.GezagInOnderzoek.DatumIngangOnderzoek?.Map();
                        break;
                    case "113200":
                    case "113210":
                        retval.IndicatieGezagMinderjarige = true;
                        retval.DatumIngangOnderzoekGezag = persoon.GezagInOnderzoek.DatumIngangOnderzoek?.Map();
                        break;
                    case "113300":
                    case "113310":
                        retval.IndicatieCurateleRegister = true;
                        retval.DatumIngangOnderzoekGezag = persoon.GezagInOnderzoek.DatumIngangOnderzoek?.Map();
                        break;
                    default:
                        break;
                }
            }

            if(persoon.Verblijfplaats?.InOnderzoek != null)
            {
                switch (persoon.Verblijfplaats.InOnderzoek.AanduidingGegevensInOnderzoek)
                {
                    case "080000":
                    case "080900":
                        retval.GemeenteVanInschrijving = true;
                        retval.DatumInschrijvingInGemeente = true;
                        retval.DatumIngangOnderzoekGemeente = persoon.Verblijfplaats.InOnderzoek.DatumIngangOnderzoek?.Map();
                        break;
                    case "080910":
                        retval.GemeenteVanInschrijving = true;
                        retval.DatumIngangOnderzoekGemeente = persoon.Verblijfplaats.InOnderzoek.DatumIngangOnderzoek?.Map();
                        break;
                    case "080920":
                        retval.DatumInschrijvingInGemeente = true;
                        retval.DatumIngangOnderzoekGemeente = persoon.Verblijfplaats.InOnderzoek.DatumIngangOnderzoek?.Map();
                        break;
                    default:
                        break;
                }
            }

            return retval;
        }
    }
}
