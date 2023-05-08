namespace HaalCentraal.BrpProxy.Generated;

public partial class ZoekMetPostcodeEnHuisnummer : IRedactCloneable
{
    public object RedactClone()
    {
        var retval = (ZoekMetPostcodeEnHuisnummer)MemberwiseClone();

        retval.Postcode = retval.Postcode != null
            ? new string('*', retval.Postcode.Length)
            : null;
        retval.Huisnummer = retval.Huisnummer != null
            ? new string('*', retval.Huisnummer.Length)
            : null;

        return retval;
    }
}
