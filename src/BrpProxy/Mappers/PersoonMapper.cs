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
                    case "010300":
                    case "010310":
                        retval.Leeftijd = true;
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

        public static PersoonInOnderzoekBeperkt? InOnderzoek(this GbaPersoonBeperkt persoon)
        {
            if (persoon.PersoonInOnderzoek == null )
            {
                return null;
            }

            PersoonInOnderzoekBeperkt retval = new();

            if (persoon.PersoonInOnderzoek != null)
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
                    case "010300":
                    case "010310":
                        retval.Leeftijd = true;
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

            return retval;
        }

        public static AdresseringInOnderzoek? AdresseringInOnderzoek(this GbaPersoon persoon)
        {
            if(persoon.PersoonInOnderzoek == null &&
                (persoon.Partners == null || persoon.Partners.All(p => p.InOnderzoek == null)) &&
                persoon.Verblijfplaats?.InOnderzoek == null)
            {
                return null;
            }

            AdresseringInOnderzoek? retval = null;

            if(persoon.PersoonInOnderzoek != null)
            {
                switch (persoon.PersoonInOnderzoek.AanduidingGegevensInOnderzoek)
                {
                    case "010000":
                    case "010200":
                    case "010210":
                    case "010220":
                    case "010230":
                    case "010240":
                    case "010400":
                    case "010410":
                    case "016100":
                    case "016110":
                        if (retval == null) retval = new();
                        retval.Aanhef = true;
                        retval.Aanschrijfwijze = true;
                        retval.GebruikInLopendeTekst = true;
                        retval.DatumIngangOnderzoekPersoon = persoon.PersoonInOnderzoek.DatumIngangOnderzoek?.Map();
                        break;
                    default:
                        retval = null;
                        break;
                }
            }

            var partner = persoon.Partners?.OrderBy(p => p.AangaanHuwelijkPartnerschap?.Datum).FirstOrDefault();

            if (partner != null &&
                partner.InOnderzoek != null &&
                persoon?.Naam?.AanduidingNaamgebruik?.Code != "E")
            {
                var inOnderzoek = partner.InOnderzoek;
                switch (inOnderzoek.AanduidingGegevensInOnderzoek)
                {
                    case "050000":
                    case "050200":
                    case "050220":
                    case "050230":
                    case "050240":
                        if (retval == null) retval = new();
                        retval.Aanhef = true;
                        retval.Aanschrijfwijze = true;
                        retval.GebruikInLopendeTekst = true;
                        retval.DatumIngangOnderzoekPartner= inOnderzoek.DatumIngangOnderzoek?.Map();
                        break;
                    default:
                        break;
                }
            }

            if(persoon?.Verblijfplaats != null && persoon.Verblijfplaats.InOnderzoek != null)
            {
                var inOnderzoek = persoon.Verblijfplaats.InOnderzoek;
                switch (inOnderzoek.AanduidingGegevensInOnderzoek)
                {
                    case "080000":
                    case "081300":
                        if (retval == null) retval = new();
                        retval.Adresregel1 = true;
                        retval.Adresregel2 = true;
                        retval.Adresregel3 = true;
                        retval.Land = true;
                        retval.DatumIngangOnderzoekVerblijfplaats = inOnderzoek.DatumIngangOnderzoek?.Map();
                        break;
                    case "080900":
                    case "080910":
                    case "081160":
                    case "081170":
                    case "081340":
                        if (retval == null) retval = new();
                        retval.Adresregel2 = true;
                        retval.DatumIngangOnderzoekVerblijfplaats = inOnderzoek.DatumIngangOnderzoek?.Map();
                        break;
                    case "081100":
                        if (retval == null) retval = new();
                        retval.Adresregel1 = true;
                        retval.Adresregel2 = true;
                        retval.DatumIngangOnderzoekVerblijfplaats = inOnderzoek.DatumIngangOnderzoek?.Map();
                        break;
                    case "081110":
                    case "081115":
                    case "081120":
                    case "081130":
                    case "081140":
                    case "081150":
                    case "081200":
                    case "081210":
                    case "081330":
                        if (retval == null) retval = new();
                        retval.Adresregel1 = true;
                        retval.DatumIngangOnderzoekVerblijfplaats = inOnderzoek.DatumIngangOnderzoek?.Map();
                        break;
                    case "081310":
                        if (retval == null) retval = new();
                        retval.Land = true;
                        retval.DatumIngangOnderzoekVerblijfplaats = inOnderzoek.DatumIngangOnderzoek?.Map();
                        break;
                    case "081350":
                        if (retval == null) retval = new();
                        retval.Adresregel3 = true;
                        retval.DatumIngangOnderzoekVerblijfplaats = inOnderzoek.DatumIngangOnderzoek?.Map();
                        break;
                    default:
                        break;
                }
            }

            return retval;
        }
    }
}
