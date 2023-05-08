namespace HaalCentraal.BrpProxy.Generated;

public partial class RaadpleegMetBurgerservicenummer : IRedactCloneable
{
    public object RedactClone()
    {
        var retval = (RaadpleegMetBurgerservicenummer)MemberwiseClone();

        var clone = new List<string>();
        foreach (var bsn in retval.Burgerservicenummer)
        {
            clone.Add(new string('*', bsn.Length));
        }
        retval.Burgerservicenummer = clone;
        
        return retval;
    }
}
