namespace HaalCentraal.BrpProxy.Generated;

public partial class ZoekMetGeslachtsnaamEnGeboortedatum : IRedactCloneable
{
    public object RedactClone()
    {
        var retval = (ZoekMetGeslachtsnaamEnGeboortedatum)MemberwiseClone();

        retval.Geboortedatum = retval.Geboortedatum != null
            ? new string('*', retval.Geboortedatum.Length)
            : null;
        retval.Geslachtsnaam = retval.Geslachtsnaam != null
            ? new string('*', retval.Geslachtsnaam.Length)
            : null;
        retval.Voornamen= retval.Voornamen != null
            ? new string('*', retval.Voornamen.Length)
            : null;
        retval.Voorvoegsel = retval.Voorvoegsel != null
            ? new string('*', retval.Voorvoegsel.Length)
            : null;

        return retval;
    }
}
