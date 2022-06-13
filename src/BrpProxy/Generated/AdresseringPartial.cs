namespace HaalCentraal.BrpProxy.Generated;

public partial class Adressering
{
    public bool ShouldSerialize() =>
        !string.IsNullOrWhiteSpace(Aanhef) ||
        !string.IsNullOrWhiteSpace(GebruikInLopendeTekst) ||
        !string.IsNullOrWhiteSpace(Adresregel1) ||
        !string.IsNullOrWhiteSpace(Adresregel2) ||
        !string.IsNullOrWhiteSpace(Adresregel3) ||
        Land != null
        ;
}
