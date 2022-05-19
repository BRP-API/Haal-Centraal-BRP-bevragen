using HaalCentraal.BrpService.Generated;
using System.Linq.Expressions;

namespace HaalCentraal.BrpService.Repositories;

public class GeboorteDatumSpecification : Specification<GbaPersoonBeperkt>
{
    private readonly DateTimeOffset _datum;

    public GeboorteDatumSpecification(DateTimeOffset datum)
    {
        _datum = datum;
    }

    public override Expression<Func<GbaPersoonBeperkt, bool>> ToExpression()
    {
        return persoon => persoon != null && persoon.Geboorte != null && persoon.Geboorte.Datum == _datum.ToString("yyyyMMdd");
    }
}
