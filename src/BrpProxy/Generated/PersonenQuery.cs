namespace HaalCentraal.BrpProxy.Generated;

[Newtonsoft.Json.JsonConverter(typeof(JsonInheritanceConverter), "type")]
[JsonInheritance("ZoekMetGeslachtsnaamEnGeboortedatum", typeof(ZoekMetGeslachtsnaamEnGeboortedatum))]
[JsonInheritance("ZoekMetNaamEnGemeenteVanInschrijving", typeof(ZoekMetNaamEnGemeenteVanInschrijving))]
[JsonInheritance("RaadpleegMetBurgerservicenummer", typeof(RaadpleegMetBurgerservicenummer))]
[JsonInheritance("ZoekMetPostcodeEnHuisnummer", typeof(ZoekMetPostcodeEnHuisnummer))]
[JsonInheritance("ZoekMetStraatHuisnummerEnGemeenteVanInschrijving", typeof(ZoekMetStraatHuisnummerEnGemeenteVanInschrijving))]
[JsonInheritance("ZoekMetNummeraanduidingIdentificatie", typeof(ZoekMetNummeraanduidingIdentificatie))]
[System.CodeDom.Compiler.GeneratedCode("NJsonSchema", "13.15.10.0 (NJsonSchema v10.6.10.0 (Newtonsoft.Json v13.0.0.0))")]
public partial class PersonenQuery
{
    [Newtonsoft.Json.JsonProperty("fields", Required = Newtonsoft.Json.Required.Default, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? Fields { get; set; }

    [Newtonsoft.Json.JsonProperty("gemeenteVanInschrijving", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string GemeenteVanInschrijving { get; set; }

    private IDictionary<string, object> _additionalProperties = new Dictionary<string, object>();

    [Newtonsoft.Json.JsonExtensionData]
    public IDictionary<string, object> AdditionalProperties
    {
        get { return _additionalProperties; }
        set { _additionalProperties = value; }
    }

}
