using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Mappers;

public static class PersoonMapper
{
    public static bool Geheimhouding(this GbaPersoon persoon)
    {
        return persoon.GeheimhoudingPersoonsgegevens > 0;
    }

    private static void InitializePersoonInOnderzoek(this IPersoonInOnderzoek retval, GbaInOnderzoek? gbaInOnderzoek)
    {
        if (gbaInOnderzoek != null)
        {
            switch (gbaInOnderzoek.AanduidingGegevensInOnderzoek)
            {
                case "010000":
                    retval.Burgerservicenummer = true;
                    retval.Geslacht = true;
                    retval.Leeftijd = true;
                    retval.DatumIngangOnderzoekPersoon = gbaInOnderzoek.DatumIngangOnderzoek!.Map();
                    break;
                case "010100":
                case "010120":
                    retval.Burgerservicenummer = true;
                    retval.DatumIngangOnderzoekPersoon = gbaInOnderzoek.DatumIngangOnderzoek!.Map();
                    break;
                case "010300":
                case "010310":
                    retval.Leeftijd = true;
                    retval.DatumIngangOnderzoekPersoon = gbaInOnderzoek.DatumIngangOnderzoek!.Map();
                    break;
                case "010400":
                case "010410":
                    retval.Geslacht = true;
                    retval.DatumIngangOnderzoekPersoon = gbaInOnderzoek.DatumIngangOnderzoek!.Map();
                    break;
                default:
                    break;
            }
        }
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

        retval.InitializePersoonInOnderzoek(persoon.PersoonInOnderzoek);

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

        retval.InitializePersoonInOnderzoek(persoon.PersoonInOnderzoek);

        return retval;
    }

    private static void InitializeAdresseringMetPersoonInOnderzoek(this AdresseringInOnderzoek retval, GbaInOnderzoek? gbaInOnderzoek)
    {
        if (gbaInOnderzoek != null)
        {
            switch (gbaInOnderzoek.AanduidingGegevensInOnderzoek)
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
                    retval.Aanhef = true;
                    retval.Aanschrijfwijze = true;
                    retval.GebruikInLopendeTekst = true;
                    retval.DatumIngangOnderzoekPersoon = gbaInOnderzoek.DatumIngangOnderzoek?.Map();
                    break;
                default:
                    break;
            }
        }
    }

    private static void InitializeAdresseringMetPartnerInOnderzoek(this AdresseringInOnderzoek retval, GbaInOnderzoek? gbaInOnderzoek)
    {
        if(gbaInOnderzoek != null)
        {
            switch (gbaInOnderzoek.AanduidingGegevensInOnderzoek)
            {
                case "050000":
                case "050200":
                case "050220":
                case "050230":
                case "050240":
                    retval.Aanhef = true;
                    retval.Aanschrijfwijze = true;
                    retval.GebruikInLopendeTekst = true;
                    retval.DatumIngangOnderzoekPartner = gbaInOnderzoek.DatumIngangOnderzoek?.Map();
                    break;
                default:
                    break;
            }
        }
    }

    private static void InitializeAdresseringMetVerblijfplaatsInOnderzoek(this IAdresregelsInOnderzoek retval, GbaInOnderzoek? gbaInOnderzoek)
    {
        if (gbaInOnderzoek != null)
        {
            switch (gbaInOnderzoek.AanduidingGegevensInOnderzoek)
            {
                case "080000":
                case "081300":
                case "089999":
                    retval.Adresregel1 = true;
                    retval.Adresregel2 = true;
                    retval.Adresregel3 = true;
                    retval.Land = true;
                    retval.DatumIngangOnderzoekVerblijfplaats = gbaInOnderzoek.DatumIngangOnderzoek!.Map();
                    break;
                case "080900":
                case "080910":
                case "081160":
                case "081170":
                case "081340":
                    retval.Adresregel2 = true;
                    retval.DatumIngangOnderzoekVerblijfplaats = gbaInOnderzoek.DatumIngangOnderzoek!.Map();
                    break;
                case "081100":
                    retval.Adresregel1 = true;
                    retval.Adresregel2 = true;
                    retval.DatumIngangOnderzoekVerblijfplaats = gbaInOnderzoek.DatumIngangOnderzoek!.Map();
                    break;
                case "081110":
                case "081120":
                case "081130":
                case "081140":
                case "081150":
                case "081200":
                case "081210":
                case "081330":
                    retval.Adresregel1 = true;
                    retval.DatumIngangOnderzoekVerblijfplaats = gbaInOnderzoek.DatumIngangOnderzoek!.Map();
                    break;
                case "081310":
                    retval.Land = true;
                    retval.DatumIngangOnderzoekVerblijfplaats = gbaInOnderzoek.DatumIngangOnderzoek!.Map();
                    break;
                case "081350":
                    retval.Adresregel3 = true;
                    retval.DatumIngangOnderzoekVerblijfplaats = gbaInOnderzoek.DatumIngangOnderzoek!.Map();
                    break;
                default:
                    break;
            }
        }
    }

    public static AdresseringInOnderzoek? AdresseringInOnderzoek(this GbaPersoon persoon)
    {
        if(persoon.PersoonInOnderzoek == null &&
            (persoon.Partners == null || persoon.Partners.All(p => p.InOnderzoek == null)) &&
            persoon.Verblijfplaats?.InOnderzoek == null)
        {
            return null;
        }

        AdresseringInOnderzoek retval = new();

        retval.InitializeAdresseringMetPersoonInOnderzoek(persoon.PersoonInOnderzoek);

        var partner = persoon.Partners?.OrderBy(p => p.AangaanHuwelijkPartnerschap?.Datum).FirstOrDefault();

        if (partner != null &&
            partner.InOnderzoek != null &&
            persoon?.Naam?.AanduidingNaamgebruik?.Code != "E")
        {
            retval.InitializeAdresseringMetPartnerInOnderzoek(partner.InOnderzoek);
        }

        retval.InitializeAdresseringMetVerblijfplaatsInOnderzoek(persoon?.Verblijfplaats?.InOnderzoek);

        return retval;
    }

    public static AdresseringInOnderzoekBeperkt? AdresseringInOnderzoek(this GbaPersoonBeperkt persoon)
    {
        if (persoon.Verblijfplaats?.InOnderzoek == null)
        {
            return null;
        }

        AdresseringInOnderzoekBeperkt? retval = new();

        retval.InitializeAdresseringMetVerblijfplaatsInOnderzoek(persoon?.Verblijfplaats?.InOnderzoek);

        return retval.ShouldSerialize() ? retval : null;
    }
}
