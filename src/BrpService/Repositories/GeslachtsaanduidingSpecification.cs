using HaalCentraal.BrpService.Generated;
using System.Linq.Expressions;

namespace HaalCentraal.BrpService.Repositories;

public class GeslachtsaanduidingSpecification : Specification<GbaPersoonBeperkt>
{
    private readonly string _geslachtsaanduiding;

    public GeslachtsaanduidingSpecification(string geslachtsaanduiding)
    {
        _geslachtsaanduiding = geslachtsaanduiding;
    }

    public override Expression<Func<GbaPersoonBeperkt, bool>> ToExpression()
    {
        return persoon => persoon != null &&
               persoon.Geslachtsaanduiding != null &&
               string.Compare(persoon.Geslachtsaanduiding.Code, _geslachtsaanduiding, true) == 0;
    }
}
