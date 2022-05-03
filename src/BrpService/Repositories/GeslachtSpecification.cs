using HaalCentraal.BrpService.Generated;
using System.Linq.Expressions;

namespace HaalCentraal.BrpService.Repositories;

public class GeslachtSpecification : Specification<GbaPersoonBeperkt>
{
    private readonly string _geslacht;

    public GeslachtSpecification(string geslacht)
    {
        _geslacht = geslacht;
    }

    public override Expression<Func<GbaPersoonBeperkt, bool>> ToExpression()
    {
        return persoon => persoon != null &&
               persoon.Geslacht != null &&
               string.Compare(persoon.Geslacht.Code, _geslacht, true) == 0;
    }
}
