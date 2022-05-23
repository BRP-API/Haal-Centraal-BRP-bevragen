using HaalCentraal.BrpService.Generated;
using System.Linq.Expressions;

namespace HaalCentraal.BrpService.Repositories;

public class VoornamenSpecification : Specification<GbaPersoonBeperkt>
{
    private readonly string _voornamen;

    public VoornamenSpecification(string voornamen)
    {
        _voornamen = voornamen;
    }

    public override Expression<Func<GbaPersoonBeperkt, bool>> ToExpression()
    {
        if (_voornamen.EndsWith('*'))
        {
            return persoon => persoon != null && persoon.Naam != null && persoon.Naam.Voornamen.ToLower().StartsWith(_voornamen.Substring(0, _voornamen.Length - 1).ToLower());
        }
        return persoon => persoon != null && persoon.Naam != null && string.Compare(persoon.Naam.Voornamen, _voornamen, true) == 0;
    }
}
