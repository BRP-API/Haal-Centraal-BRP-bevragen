using HaalCentraal.BrpService.Generated;
using System.Linq.Expressions;

namespace HaalCentraal.BrpService.Repositories;

public class NummeraanduidingIdentificatieSpecification : Specification<GbaPersoonBeperkt>
{
    private readonly string _nummeraanduidingIdentificatie;

    public NummeraanduidingIdentificatieSpecification(string nummeraanduidingIdentificatie)
    {
        _nummeraanduidingIdentificatie = nummeraanduidingIdentificatie;
    }

    public override Expression<Func<GbaPersoonBeperkt, bool>> ToExpression()
    {
        return persoon => persoon != null &&
                persoon.Verblijfplaats != null &&
                string.Compare(persoon.Verblijfplaats.NummeraanduidingIdentificatie, _nummeraanduidingIdentificatie, true) == 0;
    }
}