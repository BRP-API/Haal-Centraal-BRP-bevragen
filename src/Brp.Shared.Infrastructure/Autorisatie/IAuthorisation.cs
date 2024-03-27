namespace Brp.Shared.Infrastructure.Autorisatie;

public interface IAuthorisation
{
    AuthorisationResult Authorize(int afnemerCode, int? gemeenteCode, string requestBody);
    bool Protocolleer(int afnemerCode, string geleverdePersoonslijstIds, string requestBody);
}
