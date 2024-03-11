using Brp.Gezag.Mock.Generated;

namespace GezagMock.Generated;

public class Gezag
{
    [Newtonsoft.Json.JsonProperty("burgerservicenummer", Required = Newtonsoft.Json.Required.Always)]
    public string? Burgerservicenummer { get; set; }

    [Newtonsoft.Json.JsonProperty("gezagsrelaties", Required = Newtonsoft.Json.Required.Always)]
    public ICollection<Gezagsrelatie>? Gezagsrelaties { get; set; } = default;
}
