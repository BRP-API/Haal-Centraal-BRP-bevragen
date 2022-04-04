using HaalCentraal.BrpService.Generated;
using System.Linq.Expressions;

namespace HaalCentraal.BrpService.Repositories;

public class GeslachtsnaamSpecification : Specification<GbaPersoonBeperkt>
{
    private readonly string _geslachtsnaam;

    public GeslachtsnaamSpecification(string geslachtsnaam)
    {
        _geslachtsnaam = geslachtsnaam;
    }

    public override Expression<Func<GbaPersoonBeperkt, bool>> ToExpression()
    {
        if(!_geslachtsnaam.Contains('*'))
        {
            return persoon => persoon != null &&
                   persoon.Naam != null &&
                   string.Compare(persoon.Naam.Geslachtsnaam, _geslachtsnaam, true) == 0;
        }
        else if(_geslachtsnaam.EndsWith('*'))
        {
            return persoon => persoon != null &&
                   persoon.Naam != null &&
                   persoon.Naam.Geslachtsnaam.ToLower()
                    .StartsWith(_geslachtsnaam.Substring(0, _geslachtsnaam.Length - 1).ToLower());
        }
        throw new NotSupportedException();
    }
}
