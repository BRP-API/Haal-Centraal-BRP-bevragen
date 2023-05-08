namespace HaalCentraal.BrpProxy.Generated;

public partial class ZoekMetNaamEnGemeenteVanInschrijving : IRedactCloneable
{
    public object RedactClone()
    {
        var retval = (ZoekMetNaamEnGemeenteVanInschrijving)MemberwiseClone();

        retval.Geslachtsnaam = retval.Geslachtsnaam != null
            ? new string('*', retval.Geslachtsnaam.Length)
            : null;
        retval.Voornamen = retval.Voornamen != null
            ? new string('*', retval.Voornamen.Length)
            : null;

        return retval;
    }
}
