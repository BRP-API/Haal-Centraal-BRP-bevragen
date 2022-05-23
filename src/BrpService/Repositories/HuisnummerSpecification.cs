using HaalCentraal.BrpService.Generated;
using System.Linq.Expressions;

namespace HaalCentraal.BrpService.Repositories;

public class HuisnummerSpecification : Specification<GbaPersoonBeperkt>
{
    private readonly int _huisnummer;

    public HuisnummerSpecification(int huisnummer)
    {
        _huisnummer = huisnummer;
    }

    public override Expression<Func<GbaPersoonBeperkt, bool>> ToExpression()
    {
        return persoon => persoon != null && persoon.Verblijfplaats != null && persoon.Verblijfplaats.Huisnummer == _huisnummer;
    }
}
