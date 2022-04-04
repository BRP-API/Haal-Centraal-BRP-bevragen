using HaalCentraal.BrpService.Generated;
using System.Linq.Expressions;

namespace HaalCentraal.BrpService.Repositories;

public class VoorvoegselSpecification : Specification<GbaPersoonBeperkt>
{
    private readonly string _voorvoegsel;

    public VoorvoegselSpecification(string voorvoegsel)
    {
        _voorvoegsel = voorvoegsel;
    }
    public override Expression<Func<GbaPersoonBeperkt, bool>> ToExpression()
    {
        return persoon => persoon != null && persoon.Naam != null && string.Compare(persoon.Naam.Voorvoegsel, _voorvoegsel, true) == 0;
    }
}
