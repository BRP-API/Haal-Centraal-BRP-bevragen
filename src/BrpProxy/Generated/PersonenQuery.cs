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
    /// <summary>
    /// Hiermee kun je de inhoud van de resource naar behoefte aanpassen door een lijst van paden die verwijzen naar de gewenste velden op te nemen ([zie functionele specificaties 'fields' properties](https://raw.githubusercontent.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/develop/features/fields.feature)). 
    /// <br/>De te gebruiken paden zijn beschreven in [fields-Persoon.csv](https://raw.githubusercontent.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/develop/features/fields-Persoon.csv) (voor gebruik fields bij raadplegen) en [fields-PersoonBeperkt.csv](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/blob/develop/features/fields-PersoonBeperkt.csv) (voor gebruik fields bij zoeken) waarbij in de eerste kolom het fields-pad staat en in de tweede kolom het volledige pad naar het gewenste veld.
    /// <br/>
    /// </summary>
    [Newtonsoft.Json.JsonProperty("fields", Required = Newtonsoft.Json.Required.Default, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public ICollection<string>? Fields { get; set; }

    [Newtonsoft.Json.JsonProperty("gemeenteVanInschrijving", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? GemeenteVanInschrijving { get; set; }

    private IDictionary<string, object> _additionalProperties = new Dictionary<string, object>();

    [Newtonsoft.Json.JsonExtensionData]
    public IDictionary<string, object> AdditionalProperties
    {
        get { return _additionalProperties; }
        set { _additionalProperties = value; }
    }

}
