using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Mappers
{
    public static class PersoonMapper
    {
        public static bool Geheimhouding(this GbaPersoon persoon)
        {
            return persoon.GeheimhoudingPersoonsgegevens > 0;
        }

        public static ICollection<string> FilterOnbekendReisdocumentnummers(this IEnumerable<string> reisdocumentnummers)
        {
            return (from reisdocumentnummer in reisdocumentnummers
                   where reisdocumentnummer != "........."
                   select reisdocumentnummer).ToList();
        }
    }
}
