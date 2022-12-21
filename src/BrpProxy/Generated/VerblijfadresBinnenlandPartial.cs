namespace HaalCentraal.BrpProxy.Generated;

public partial class Adres
{
    public override bool ShouldSerialize() =>
        !string.IsNullOrWhiteSpace(AdresseerbaarObjectIdentificatie) ||
        DatumIngangGeldigheid != null ||
        DatumVan != null ||
        FunctieAdres != null ||
        NummeraanduidingIdentificatie != null ||
        Verblijfadres != null
        ;

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();

    public bool ShouldSerializeVerblijfadres() => Verblijfadres != null;
}

public partial class AdresInOnderzoek
{
    public bool ShouldSerialize() =>
        AdresseerbaarObjectIdentificatie.HasValue ||
        DatumIngangGeldigheid.HasValue ||
        DatumVan.HasValue ||
        FunctieAdres.HasValue ||
        NummeraanduidingIdentificatie.HasValue ||
        Type.HasValue
        ;
}

public partial class VerblijfadresBinnenland
{
    public bool ShouldSerialize() =>
        AanduidingBijHuisnummer != null ||
        !string.IsNullOrWhiteSpace(Huisletter) ||
        Huisnummer > 0 ||
        !string.IsNullOrWhiteSpace(Huisnummertoevoeging) ||
        !string.IsNullOrWhiteSpace(KorteNaam) ||
        !string.IsNullOrWhiteSpace(Postcode) ||
        !string.IsNullOrWhiteSpace(Straat) ||
        !string.IsNullOrWhiteSpace(Woonplaats) ||
        InOnderzoek != null
        ;

    public bool ShouldSerializeInOnderzoek() => InOnderzoek != null && InOnderzoek.ShouldSerialize();
}

public partial class VerblijfadresBinnenlandInOnderzoek
{
    public bool ShouldSerialize() =>
        AanduidingBijHuisnummer.HasValue ||
        Huisletter.HasValue ||
        Huisnummer.HasValue ||
        Huisnummertoevoeging.HasValue ||
        KorteNaam.HasValue ||
        Postcode.HasValue ||
        Straat.HasValue ||
        Woonplaats.HasValue;
}

public partial class AdresBeperkt
{
    public VerblijfadresBinnenland? Verblijfadres { get; set; }

    public bool ShouldSerializeVerblijfadres() => false;
}