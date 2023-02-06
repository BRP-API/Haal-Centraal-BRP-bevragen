using HaalCentraal.BrpService.Generated;
using System.Linq.Expressions;

namespace HaalCentraal.BrpService.Repositories;

public class InclusiefOverledenPersonenSpecification : Specification<GbaPersoonBeperkt>
{
    private readonly bool _inclusiefOverledenPersonen;

    public InclusiefOverledenPersonenSpecification(bool inclusiefOverledenPersonen)
    {
        _inclusiefOverledenPersonen = inclusiefOverledenPersonen;
    }
    public override Expression<Func<GbaPersoonBeperkt, bool>> ToExpression()
    {
        return _inclusiefOverledenPersonen
            ? persoon => persoon != null
            : persoon => persoon != null &&
              persoon.OpschortingBijhouding != null &&
              persoon.OpschortingBijhouding.Reden != null &&
              persoon.OpschortingBijhouding.Reden.Code == "O";
    }
}
