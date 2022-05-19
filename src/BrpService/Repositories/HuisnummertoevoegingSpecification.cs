using HaalCentraal.BrpService.Generated;
using System.Linq.Expressions;

namespace HaalCentraal.BrpService.Repositories;

public class HuisnummertoevoegingSpecification : Specification<GbaPersoonBeperkt>
{
    private readonly string _huisnummertoevoeging;

    public HuisnummertoevoegingSpecification(string huisnummertoevoeging)
    {
        _huisnummertoevoeging = huisnummertoevoeging;
    }

    public override Expression<Func<GbaPersoonBeperkt, bool>> ToExpression()
    {
        return persoon => persoon != null && persoon.Verblijfplaats != null && string.Compare(persoon.Verblijfplaats.Huisnummertoevoeging, _huisnummertoevoeging, true) == 0;
    }
}
