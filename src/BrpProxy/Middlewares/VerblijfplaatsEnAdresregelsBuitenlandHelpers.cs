using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Middlewares;

public static class VerblijfplaatsEnAdresregelsBuitenlandHelpers
{
    public static ICollection<Persoon> ExcludeAdresregelsEnVerblijfplaatsBuitenland(this ICollection<Persoon> personen, IEnumerable<string> fields)
    {
        var adresseringBinnenland = fields.Any(f => f.StartsWith("adresseringBinnenland"));
        var verblijfplaafplaatsBinnenland = fields.Any(f => f.StartsWith("verblijfplaatsBinnenland"));

        var retval = new List<Persoon>();

        foreach(var p in personen)
        {
            if (p.Adressering != null &&
                p.Verblijfplaats is VerblijfplaatsBuitenland &&
                adresseringBinnenland)
            {
                p.Adressering.Adresregel1 = null;
                p.Adressering.Adresregel2 = null;
                p.Adressering.Adresregel3 = null;
                p.Adressering.Land = null;

                if(!p.Adressering.ShouldSerialize())
                {
                    p.Adressering = null;
                }
            }
            if (p.Verblijfplaats is VerblijfplaatsBuitenland &&
                verblijfplaafplaatsBinnenland)
            {
                p.Verblijfplaats = null;
            }

            retval.Add(p);
        }

        return retval;
    }
}
