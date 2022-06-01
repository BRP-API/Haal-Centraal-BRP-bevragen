using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Mappers;

public static class PartnerHelpers
{
    public static bool IsExPartner(this AbstractPartner? partner) => partner is OntbondenPartner;

    public static bool IsActueelPartner(this AbstractPartner? partner) => !partner.IsExPartner();

    public static bool HeeftGeenPartner(this NaamPersoon persoon)
    {
        return !(persoon.Partners?.Count > 0);
    }

    private static AbstractPartner? SelecteerOudstePartnerRelatie(this IEnumerable<AbstractPartner>? partners)
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
                else if (p.AangaanHuwelijkPartnerschap.Datum < retval.AangaanHuwelijkPartnerschap.Datum)
                {
                    retval = p;
                }
            }
        }

        return retval;
    }

    private static AbstractPartner? SelecteerLaatstOntbondenPartnerRelatie(this IEnumerable<AbstractPartner>? partners)
    {
        if (partners == null) return null;

        OntbondenPartner? retval = null;

        foreach (var partner in partners)
        {
            if (partner is OntbondenPartner p)
            {
                if (retval == null)
                {
                    retval = p;
                }
                else if (p.OntbindingHuwelijkPartnerschap!.Datum > retval.OntbindingHuwelijkPartnerschap!.Datum)
                {
                    retval = p;
                }
            }
        }

        return retval;
    }

    public static AbstractPartner? ActuelePartner(this IEnumerable<AbstractPartner>? partners)
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
