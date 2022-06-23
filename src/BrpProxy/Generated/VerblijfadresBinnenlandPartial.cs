namespace HaalCentraal.BrpProxy.Generated;

public partial class Adres
{
    public bool ShouldSerializeVerblijfadres() =>
        Verblijfadres != null && Verblijfadres.ShouldSerialize();
}

public partial class VerblijfadresBinnenland
{
    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null;

    public bool ShouldSerialize() =>
        !string.IsNullOrWhiteSpace(Straat) ||
        Huisnummer > 0 ||
        !string.IsNullOrWhiteSpace(Huisletter) ||
        !string.IsNullOrWhiteSpace(Huisnummertoevoeging) ||
        AanduidingBijHuisnummer != null ||
        !string.IsNullOrWhiteSpace(Postcode) ||
        !string.IsNullOrWhiteSpace(Woonplaats) ||
        !string.IsNullOrWhiteSpace(KorteNaam) ||
        ShouldSerializeInOnderzoek()
        ;
}

public partial class AdresBeperkt
{
    public VerblijfadresBinnenland? Verblijfadres { get; set; }

    public bool ShouldSerializeVerblijfadres() => false;
}