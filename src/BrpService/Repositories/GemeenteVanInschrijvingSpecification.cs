using HaalCentraal.BrpService.Generated;
using System.Linq.Expressions;

namespace HaalCentraal.BrpService.Repositories;

public class GemeenteVanInschrijvingSpecification : Specification<GbaPersoonBeperkt>
{
    private readonly string _gemeenteVanInschrijving;

    public GemeenteVanInschrijvingSpecification(string gemeenteVanInschrijving)
    {
        _gemeenteVanInschrijving = gemeenteVanInschrijving;
    }

    public override Expression<Func<GbaPersoonBeperkt, bool>> ToExpression()
    {
        return persoon => persoon != null &&
               persoon.Verblijfplaats != null &&
               persoon.Verblijfplaats.GemeenteVanInschrijving != null &&
               persoon.Verblijfplaats.GemeenteVanInschrijving.Code == _gemeenteVanInschrijving;
    }
}
