namespace HaalCentraal.BrpProxy.Generated;

public partial class Immigratie
{
    public bool ShouldSerialize() =>
        DatumVestigingInNederland != null ||
        IndicatieVestigingVanuitBuitenland ||
        InOnderzoek != null ||
        LandVanwaarIngeschreven != null ||
        VanuitVerblijfplaatsOnbekend
        ;
}
