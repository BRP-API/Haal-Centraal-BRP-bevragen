namespace HaalCentraal.BrpProxy.Generated;

[Newtonsoft.Json.JsonObject(memberSerialization: Newtonsoft.Json.MemberSerialization.OptOut)]
public class OntbondenPartner : AbstractPartner
{
    public NaamGerelateerde? Naam { get; set; }
    public OntbindingHuwelijkPartnerschap? OntbindingHuwelijkPartnerschap { get; set; }
}

public class OntbindingHuwelijkPartnerschap
{
    public AbstractDatum Datum { get; set; }
}