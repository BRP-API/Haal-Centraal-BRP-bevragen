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
               persoon.GemeenteVanInschrijving != null &&
               persoon.GemeenteVanInschrijving.Code == _gemeenteVanInschrijving;
    }
}
