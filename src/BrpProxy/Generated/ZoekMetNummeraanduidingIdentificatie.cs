namespace HaalCentraal.BrpProxy.Generated
{
    [System.CodeDom.Compiler.GeneratedCode("NJsonSchema", "13.15.10.0 (NJsonSchema v10.6.10.0 (Newtonsoft.Json v13.0.0.0))")]
    public partial class ZoekMetNummeraanduidingIdentificatie : PersonenQuery
    {
        [Newtonsoft.Json.JsonProperty("inclusiefOverledenPersonen", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
        public bool? InclusiefOverledenPersonen { get; set; }

        [Newtonsoft.Json.JsonProperty("nummeraanduidingIdentificatie", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
        public string? NummeraanduidingIdentificatie { get; set; }

    }
}
