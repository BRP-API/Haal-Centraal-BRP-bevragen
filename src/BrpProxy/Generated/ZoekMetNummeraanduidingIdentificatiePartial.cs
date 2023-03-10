namespace HaalCentraal.BrpProxy.Generated;

public partial class ZoekMetNummeraanduidingIdentificatie : IRedactCloneable
{
    public object RedactClone()
    {
        var retval = (ZoekMetNummeraanduidingIdentificatie)MemberwiseClone();

        retval.NummeraanduidingIdentificatie = retval.NummeraanduidingIdentificatie != null
            ? new string('*', retval.NummeraanduidingIdentificatie.Length)
            : null;

        return retval;
    }
}
