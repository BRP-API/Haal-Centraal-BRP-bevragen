using HaalCentraal.BrpService.Generated;
using System.Linq.Expressions;

namespace HaalCentraal.BrpService.Repositories;

public class PostcodeSpecification : Specification<GbaPersoonBeperkt>
{
    private readonly string _postcode;

    public PostcodeSpecification(string postcode)
    {
        _postcode = postcode;
    }

    public override Expression<Func<GbaPersoonBeperkt, bool>> ToExpression()
    {
        return persoon => persoon != null && persoon.Verblijfplaats != null && string.Compare(persoon.Verblijfplaats.Postcode, _postcode, true) == 0;
    }
}
