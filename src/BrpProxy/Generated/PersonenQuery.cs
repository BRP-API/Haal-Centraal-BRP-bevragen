namespace HaalCentraal.BrpProxy.Generated;

[Newtonsoft.Json.JsonConverter(typeof(JsonInheritanceConverter), "type")]
[JsonInheritanceAttribute("ZoekMetGeslachtsnaamEnGeboortedatum", typeof(ZoekMetGeslachtsnaamEnGeboortedatum))]
[JsonInheritanceAttribute("ZoekMetNaamEnGemeenteVanInschrijving", typeof(ZoekMetNaamEnGemeenteVanInschrijving))]
[JsonInheritanceAttribute("RaadpleegMetBurgerservicenummer", typeof(RaadpleegMetBurgerservicenummer))]
[JsonInheritanceAttribute("ZoekMetPostcodeEnHuisnummer", typeof(ZoekMetPostcodeEnHuisnummer))]
[JsonInheritanceAttribute("ZoekMetStraatHuisnummerEnGemeenteVanInschrijving", typeof(ZoekMetStraatHuisnummerEnGemeenteVanInschrijving))]
[JsonInheritanceAttribute("ZoekMetNummeraanduidingIdentificatie", typeof(ZoekMetNummeraanduidingIdentificatie))]
[JsonInheritanceAttribute("ZoekMetAdresseerbaarObjectIdentificatie", typeof(ZoekMetAdresseerbaarObjectIdentificatie))]
[System.CodeDom.Compiler.GeneratedCode("NJsonSchema", "14.0.2.0 (NJsonSchema v11.0.0.0 (Newtonsoft.Json v13.0.0.0))")]
public partial class PersonenQuery
{
    /// <summary>
    /// Hiermee kun je de velden opgeven die je wenst te ontvangen.
    /// <br/>
    /// <br/>Velden die automatisch worden geleverd (inOnderzoek, geheimhoudingPersoonsgegevens, opschortingBijhouding, rni en verificatie) mag je niet opgeven in fields.
    /// <br/>Opgave van een pad dat verwijst naar een niet-bestaand veld of naar een automatisch geleverd veld leidt tot een 400 Bad Request.
    /// <br/>
    /// <br/>Meer details over hoe fields werkt lees je in het [feature overzicht](https://brp-api.github.io/Haal-Centraal-BRP-bevragen/v2/features-overzicht#filteren-van-de-velden-van-de-gevonden-personen).
    /// <br/>Stel je fields eenvoudig samen met de [fields tool](https://brp-api.github.io/Haal-Centraal-BRP-bevragen/v2/fields){:target="_blank" rel="noopener"}.
    /// <br/>
    /// </summary>
    [Newtonsoft.Json.JsonProperty("fields", Required = Newtonsoft.Json.Required.Default, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public System.Collections.Generic.ICollection<string>? Fields { get; set; }

    [Newtonsoft.Json.JsonProperty("gemeenteVanInschrijving", Required = Newtonsoft.Json.Required.Default, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? GemeenteVanInschrijving { get; set; }

    private System.Collections.Generic.IDictionary<string, object> _additionalProperties;

    [Newtonsoft.Json.JsonExtensionData]
    public System.Collections.Generic.IDictionary<string, object> AdditionalProperties
    {
        get { return _additionalProperties ?? (_additionalProperties = new System.Collections.Generic.Dictionary<string, object>()); }
        set { _additionalProperties = value; }
    }

}
