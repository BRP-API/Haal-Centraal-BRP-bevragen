using HaalCentraal.BrpService.Generated;
using System.Linq.Expressions;

namespace HaalCentraal.BrpService.Repositories;

public class AdresseerbaarObjectIdentificatieSpecification : Specification<GbaGezagPersoonBeperkt>
{
    private readonly string _adresseerbaarObjectIdentificatie;

    public AdresseerbaarObjectIdentificatieSpecification(string adresseerbaarObjectIdentificatie)
    {
        _adresseerbaarObjectIdentificatie = adresseerbaarObjectIdentificatie;
    }

    public override Expression<Func<GbaGezagPersoonBeperkt, bool>> ToExpression()
    {
        return persoon => persoon != null &&
                persoon.Verblijfplaats != null &&
                string.Compare(persoon.Verblijfplaats.AdresseerbaarObjectIdentificatie, _adresseerbaarObjectIdentificatie, true) == 0;
    }
}
