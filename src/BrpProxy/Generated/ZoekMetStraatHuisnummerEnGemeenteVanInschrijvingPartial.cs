namespace HaalCentraal.BrpProxy.Generated;

public partial class ZoekMetStraatHuisnummerEnGemeenteVanInschrijving : IRedactCloneable
{
    public object RedactClone()
    {
        var retval = (ZoekMetStraatHuisnummerEnGemeenteVanInschrijving)MemberwiseClone();

        retval.Straat = retval.Straat != null
            ? new string('*', retval.Straat.Length)
            : null;
        retval.Huisnummer = retval.Huisnummer != null
            ? new string('*', retval.Huisnummer.Length)
            : null;

        return retval;
    }
}
