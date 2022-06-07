using HaalCentraal.BrpProxy.Generated;
using System.Text.RegularExpressions;

namespace BrpProxy.Mappers;

public static class AanhefMapper
{
    private static string? BepaalAanhefZonderAdellijkeTitelOfPredicaat(this NaamPersoon persoon, AbstractPartner? partner)
    {
        // Rule 788 en 789
        if (persoon.HeeftLeegOfOnbekendGeslachtsnaam() &&
            persoon.HeeftGeenPartnerNaamgebruik())
        {
            return null;
        }

        var partnerNaam = partner switch
        {
            Partner p => p.Naam.Achternaam(),
            OntbondenPartner p => p.Naam.Achternaam(),
            _ => ""
        };
        var persoonNaam = persoon.Achternaam();

        // Rule 871 (872-873)
        var geslachtsnaam = persoon.AanduidingNaamgebruik?.Code switch
        {
            "E" => persoonNaam,
            "N" => partnerNaam.IsLeegOfOnbekend() ? persoonNaam : $"{persoonNaam}-{partnerNaam}",
            "V" => partnerNaam.IsLeegOfOnbekend() ? persoonNaam : $"{partnerNaam}-{persoonNaam}",
            "P" => partnerNaam.IsLeegOfOnbekend() ? persoonNaam : partnerNaam,
            _ => persoonNaam
        };

        // Rule 17
        var retval = persoon.Geslacht() switch
        {
            "M" => $"Geachte heer {geslachtsnaam.Capitalize()}",
            "V" => $"Geachte mevrouw {geslachtsnaam.Capitalize()}",
            "O" => !string.IsNullOrWhiteSpace(persoon.Voorletters)
                ? $"Geachte {persoon.Voorletters} {geslachtsnaam}"
                : $"Geachte {geslachtsnaam.Capitalize()}",
            _ => string.Empty
        };

        return Regex.Replace(retval, @"\s+", " ").Trim().ToNull();
    }

    public static string? Aanhef(this NaamPersoon persoon)
    {
        if (persoon == null) return null;

        var partner = persoon.Partners.ActuelePartner();

        // Rule 423 en Rule 871 (874-876)
        if (persoon.HeeftGeenAdellijkeTitelOfPredicaat() &&
            partner.HeeftAdellijkeTitel() &&
            persoon.IsVrouw() &&
            persoon.GebruiktNaamVanPartner())
        {
            // Rule 427
            return partner.HeeftHoffelijkheidstitelMetAanspreekvorm()
                ? partner.BepaalHoffelijkheidstitel()
                : persoon.BepaalAanhefZonderAdellijkeTitelOfPredicaat(partner);
        }

        if (persoon.HeeftAdellijkeTitelOfPredicaat())
        {
            // Rule 786
            if (persoon.HeeftLeegOfOnbekendGeslachtsnaam() &&
                persoon.HeeftGeenPartnerNaamgebruik() &&
                (persoon.HeeftPredicaat() || persoon.HeeftGeenAdellijkeTitelMetAanspreekvorm()) &&
                persoon.HeeftGeenHoffelijkheidsTitel()
                )
            {
                return null;
            }

            // Rule 550
            if (partner.HeeftAdellijkeTitel() &&
                persoon.IsVrouw() &&
                partner.IsMan() &&
                persoon.GebruiktNaamVanPartner() &&
                partner.HeeftHoffelijkheidstitelMetAanspreekvorm()
                )
            {
                return partner.BepaalHoffelijkheidstitel();
            }

            // Rule 211
            if (partner != null &&
                persoon.HeeftPartnerNaamgebruik()
                ) return persoon.BepaalAanhefZonderAdellijkeTitelOfPredicaat(partner);

            // Rule 212
            if (persoon.HeeftPredicaat() &&
                persoon.IsVrouw() &&
                partner.IsActueelPartner()
                ) return persoon.BepaalAanhefZonderAdellijkeTitelOfPredicaat(partner);

            // Rule 213
            if (persoon.HeeftPredicaat() &&
                persoon.IsVrouw() &&
                partner.IsExPartner() &&
                persoon.GebruiktNaamVanPartner()
                ) return persoon.BepaalAanhefZonderAdellijkeTitelOfPredicaat(partner);

            // Rule 210
            return persoon.HeeftAdellijkeTitelMetAanspreekvorm()
                ? persoon.BepaalAanhefVoorAdellijkeTitelOfPredicaat()
                : persoon.BepaalAanhefZonderAdellijkeTitelOfPredicaat(partner);
        }

        return persoon.BepaalAanhefZonderAdellijkeTitelOfPredicaat(partner);
    }
}
