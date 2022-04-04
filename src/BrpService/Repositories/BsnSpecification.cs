using HaalCentraal.BrpService.Generated;
using System.Linq.Expressions;

namespace HaalCentraal.BrpService.Repositories;

public class BsnSpecification : Specification<GbaPersoon>
{
    private readonly IEnumerable<string> _bsns;

    public BsnSpecification(IEnumerable<string> bsns)
    {
        _bsns = bsns;
    }

    public override Expression<Func<GbaPersoon, bool>> ToExpression()
    {
        return persoon => _bsns.Contains(persoon.Burgerservicenummer);
    }
}
