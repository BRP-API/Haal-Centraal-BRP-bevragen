namespace HaalCentraal.BrpService.Generated;

[System.CodeDom.Compiler.GeneratedCode("NJsonSchema", "13.15.10.0 (NJsonSchema v10.6.10.0 (Newtonsoft.Json v13.0.0.0))")]
public partial class ZoekMetGeslachtsnaamEnGeboortedatum : PersonenQuery
{
    [Newtonsoft.Json.JsonProperty("inclusiefOverledenPersonen", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public bool InclusiefOverledenPersonen { get; set; }

    /// <summary>
    /// Je kunt alleen zoeken met een volledig geboortedatum. Zie [functionele specificaties](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/blob/v1.3.0/features/parametervalidatie.feature)
    /// <br/>
    /// </summary>
    [Newtonsoft.Json.JsonProperty("geboortedatum", Required = Newtonsoft.Json.Required.Default, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? Geboortedatum { get; set; }

    [Newtonsoft.Json.JsonProperty("geslachtsnaam", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? Geslachtsnaam { get; set; }

    [Newtonsoft.Json.JsonProperty("geslacht", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? Geslacht { get; set; }

    [Newtonsoft.Json.JsonProperty("voorvoegsel", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? Voorvoegsel { get; set; }

    [Newtonsoft.Json.JsonProperty("voornamen", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? Voornamen { get; set; }

}
