using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Mappers;

public static class PartnerHelpers
{
    public static bool IsExPartner(this Partner? partner) => partner != null && partner.OntbindingHuwelijkPartnerschap != null;

    public static bool IsActueelPartner(this Partner? partner) => partner != null && !partner.IsExPartner();

    public static bool HeeftGeenPartner(this NaamPersoon persoon)
    {
        return !(persoon.Partners?.Count > 0);
    }

    private static Partner? SelecteerOudstePartnerRelatie(this IEnumerable<Partner>? partners)
    {
        if (partners == null) return null;

        Partner? retval = null;

        foreach (var partner in partners)
        {
            if (partner is Partner p)
            {
                if (retval == null)
                {
                    retval = p;
                }
                else if (
                    p.AangaanHuwelijkPartnerschap != null &&
                    retval.AangaanHuwelijkPartnerschap != null &&
                    p.AangaanHuwelijkPartnerschap.Datum < retval.AangaanHuwelijkPartnerschap.Datum)
                {
                    retval = p;
                }
            }
        }

        return retval;
    }

    private static Partner? SelecteerLaatstOntbondenPartnerRelatie(this IEnumerable<Partner>? partners)
    {
        if (partners == null) return null;

        Partner? retval = null;

        foreach (var partner in partners)
        {
            if (partner.OntbindingHuwelijkPartnerschap != null &&
                (retval == null ||
                 partner.OntbindingHuwelijkPartnerschap.Datum > retval.OntbindingHuwelijkPartnerschap.Datum)
               )
            {
                retval = partner;
            }
        }

        return retval;
    }

    public static Partner? ActuelePartner(this IEnumerable<Partner>? partners)
    {
        // Rule 650
        var partner = partners.SelecteerOudstePartnerRelatie();
        if (partner == null)
        {
            // Rule 692
            partner = partners.SelecteerLaatstOntbondenPartnerRelatie();
        }
        return partner;
    }
}
