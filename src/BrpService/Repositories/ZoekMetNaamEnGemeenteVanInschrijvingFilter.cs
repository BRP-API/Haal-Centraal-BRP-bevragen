namespace HaalCentraal.BrpService.Repositories;

public class ZoekMetNaamEnGemeenteVanInschrijvingFilter
{
    public bool InclusiefOverledenPersonen { get; set; }
    public string? Geslachtsaanduiding { get; set; }
    public string Geslachtsnaam { get; set; } = string.Empty;
    public string? Voorvoegsel { get; set; }
    public string Voornamen { get; set; } = string.Empty;
    public string GemeenteVanInschrijving { get; set; } = string.Empty;
}
