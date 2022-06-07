namespace HaalCentraal.BrpProxy.Generated;

public partial class Adressering
{
    public bool ShouldSerialize() =>
        !string.IsNullOrWhiteSpace(Aanhef) ||
        !string.IsNullOrWhiteSpace(GebruikInLopendeTekst)
        ;
}
