namespace Brp.Shared.Infrastructure.Protocollering;

public interface IProtocollering
{
    bool Protocolleer(int afnemerCode, string geleverdePersoonslijstIds, string requestBody);
}
