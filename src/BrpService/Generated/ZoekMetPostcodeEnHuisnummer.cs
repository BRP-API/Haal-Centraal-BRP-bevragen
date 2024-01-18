namespace HaalCentraal.BrpService.Generated;

[System.CodeDom.Compiler.GeneratedCode("NJsonSchema", "14.0.2.0 (NJsonSchema v11.0.0.0 (Newtonsoft.Json v13.0.0.0))")]
public partial class ZoekMetPostcodeEnHuisnummer : PersonenQuery
{
    [Newtonsoft.Json.JsonProperty("inclusiefOverledenPersonen", Required = Newtonsoft.Json.Required.Default, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public bool InclusiefOverledenPersonen { get; set; }

    [Newtonsoft.Json.JsonProperty("huisletter", Required = Newtonsoft.Json.Required.Default, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? Huisletter { get; set; }

    [Newtonsoft.Json.JsonProperty("huisnummer", Required = Newtonsoft.Json.Required.Default, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? Huisnummer { get; set; }

    [Newtonsoft.Json.JsonProperty("huisnummertoevoeging", Required = Newtonsoft.Json.Required.Default, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? Huisnummertoevoeging { get; set; }

    [Newtonsoft.Json.JsonProperty("postcode", Required = Newtonsoft.Json.Required.Default, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? Postcode { get; set; }

}
