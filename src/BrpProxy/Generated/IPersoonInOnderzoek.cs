namespace HaalCentraal.BrpProxy.Generated;

public interface IPersoonInOnderzoek
{
    bool? Burgerservicenummer { get; set; }
    bool? Geslacht { get; set; }
    bool? Leeftijd { get; set; }
    AbstractDatum DatumIngangOnderzoekPersoon { get; set; }
}
