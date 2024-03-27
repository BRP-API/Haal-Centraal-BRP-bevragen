namespace Brp.AutorisatieEnProtocollering.Proxy.Data;

public class Protocollering
{
    public string RequestId { get; set; } = string.Empty;
    public int AfnemerCode { get; set; }
    public long PersoonslijstId { get; set; }
    public string? RequestZoekRubrieken { get; set; }
    public string? RequestGevraagdeRubrieken { get; set; }
}
