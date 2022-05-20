namespace HaalCentraal.BrpService.Repositories;

public class ZoekMetGeslachtsnaamEnGeboortedatumFilter
{
    public bool InclusiefOverledenPersonen { get; set; }
    public DateTimeOffset Geboortedatum { get; set; }
    public string? Geboorteplaats { get; set; }
    public string Geslachtsnaam { get; set; } = String.Empty;
    public string? Geslachtsaanduiding { get; set; }
    public string? Voorvoegsel { get; set; }
    public string? Voornamen { get; set; }
}
