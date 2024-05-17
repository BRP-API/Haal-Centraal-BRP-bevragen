namespace Brp.Shared.Infrastructure.Autorisatie;

public interface IAuthorisation
{
    AuthorisationResult Authorize(int afnemerCode, int? gemeenteCode, string requestBody);
    AuthorisationResult AuthorizeResponse(int afnemerCode, int? gemeenteCode, string? geleverdeGemeenteCodes);
}
