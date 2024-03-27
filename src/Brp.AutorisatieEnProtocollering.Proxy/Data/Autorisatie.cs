namespace Brp.AutorisatieEnProtocollering.Proxy.Data;

public class Autorisatie
{
    public long AutorisatieId { get; set; }
    public int AfnemerCode { get; set; }
    public char AdHocMedium { get; set; }
    public int? TabelRegelStartDatum { get; set; }
    public int? TabelRegelEindDatum { get; set; }
    public string? RubrieknummerAdHoc { get; set; }
}
