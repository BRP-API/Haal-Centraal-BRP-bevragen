namespace HaalCentraal.BrpProxy.Generated.Gba;

[Newtonsoft.Json.JsonConverter(typeof(JsonInheritanceConverter), "type")]
[JsonInheritanceAttribute("TweehoofdigOuderlijkGezag", typeof(TweehoofdigOuderlijkGezag))]
[JsonInheritanceAttribute("EenhoofdigOuderlijkGezag", typeof(EenhoofdigOuderlijkGezag))]
[JsonInheritanceAttribute("GezamenlijkGezag", typeof(GezamenlijkGezag))]
[JsonInheritanceAttribute("Voogdij", typeof(Voogdij))]
[JsonInheritanceAttribute("TijdelijkGeenGezag", typeof(TijdelijkGeenGezag))]
[JsonInheritanceAttribute("GezagNietTeBepalen", typeof(GezagNietTeBepalen))]
[System.CodeDom.Compiler.GeneratedCode("NJsonSchema", "14.0.3.0 (NJsonSchema v11.0.0.0 (Newtonsoft.Json v13.0.0.0))")]
public partial class AbstractGezagsrelatie
{

    private System.Collections.Generic.IDictionary<string, object> _additionalProperties;

    [Newtonsoft.Json.JsonExtensionData]
    public System.Collections.Generic.IDictionary<string, object> AdditionalProperties
    {
        get { return _additionalProperties ?? (_additionalProperties = new System.Collections.Generic.Dictionary<string, object>()); }
        set { _additionalProperties = value; }
    }

}

public partial class TijdelijkGeenGezag : AbstractGezagsrelatie
{
}

public partial class GezagNietTeBepalen : AbstractGezagsrelatie
{
}
