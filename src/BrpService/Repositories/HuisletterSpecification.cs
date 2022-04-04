using HaalCentraal.BrpService.Generated;
using System.Linq.Expressions;

namespace HaalCentraal.BrpService.Repositories;

public class HuisletterSpecification : Specification<GbaPersoonBeperkt>
{
    private readonly string _huisletter;

    public HuisletterSpecification(string huisletter)
    {
        _huisletter = huisletter;
    }

    public override Expression<Func<GbaPersoonBeperkt, bool>> ToExpression()
    {
        return persoon => persoon != null && persoon.Verblijfplaats != null && string.Compare(persoon.Verblijfplaats.Huisletter, _huisletter, true) == 0;
    }
}
