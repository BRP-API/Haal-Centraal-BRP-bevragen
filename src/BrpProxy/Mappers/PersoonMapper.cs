using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Mappers
{
    public static class PersoonMapper
    {
        public static bool Geheimhouding(this GbaPersoon persoon)
        {
            return persoon.GeheimhoudingPersoonsgegevens > 0;
        }
    }
}
