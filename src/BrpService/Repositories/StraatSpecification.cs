using HaalCentraal.BrpService.Generated;
using System.Globalization;
using System.Linq.Expressions;

namespace HaalCentraal.BrpService.Repositories;

public class StraatSpecification : Specification<GbaPersoonBeperkt>
{
    private readonly string _straat;

    public StraatSpecification(string straat)
    {
        _straat = straat;
    }

    public override Expression<Func<GbaPersoonBeperkt, bool>> ToExpression()
    {
        if (!_straat.Contains('*'))
        {
            return persoon => persoon != null &&
                persoon.Verblijfplaats != null &&
                (string.Compare(persoon.Verblijfplaats.Straat, _straat, true) == 0 ||
                string.Compare(persoon.Verblijfplaats.NaamOpenbareRuimte, _straat, true) == 0);
        }
        else if (_straat.EndsWith('*'))
        {
            return persoon => persoon != null &&
                 persoon.Verblijfplaats != null &&
                 (persoon.Verblijfplaats.Straat != null &&
                  persoon.Verblijfplaats.Straat.StartsWith(_straat.Substring(0, _straat.Length - 1), true, CultureInfo.InvariantCulture) ||
                 (persoon.Verblijfplaats.NaamOpenbareRuimte != null &&
                  persoon.Verblijfplaats.NaamOpenbareRuimte.StartsWith(_straat.Substring(0, _straat.Length - 1), true, CultureInfo.InvariantCulture)));
        }
        else if (_straat.StartsWith('*'))
        {
            return persoon => persoon != null &&
                 persoon.Verblijfplaats != null &&
                 (persoon.Verblijfplaats.Straat != null &&
                  persoon.Verblijfplaats.Straat.EndsWith(_straat.Substring(1, _straat.Length - 1), true, CultureInfo.InvariantCulture) ||
                 (persoon.Verblijfplaats.NaamOpenbareRuimte != null &&
                  persoon.Verblijfplaats.NaamOpenbareRuimte.EndsWith(_straat.Substring(1, _straat.Length - 1), true, CultureInfo.InvariantCulture)));
        }
        throw new NotSupportedException();
    }
}
