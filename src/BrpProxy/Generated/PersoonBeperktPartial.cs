namespace HaalCentraal.BrpProxy.Generated;

public partial class PersoonBeperkt
{
    public bool ShouldSerializeAdressering() => Adressering != null && Adressering.ShouldSerialize();
    public bool ShouldSerializeRni() => Rni != null && Rni.Count > 0;
}
