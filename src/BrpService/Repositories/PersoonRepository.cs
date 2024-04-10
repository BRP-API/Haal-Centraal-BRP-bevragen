using HaalCentraal.BrpService.Generated;
using Newtonsoft.Json;

namespace HaalCentraal.BrpService.Repositories;

public class PersoonRepository
{
    private readonly IWebHostEnvironment _environment;

    public PersoonRepository(IWebHostEnvironment environment)
    {
        _environment = environment;
    }

    public async Task<PersonenQueryResponse> Zoek<T>(T query)
    {
        var path = Path.Combine(_environment.ContentRootPath, "Data", "test-data.json");
        if (!File.Exists(path))
        {
            throw new FileNotFoundException($"invalid file: '{path}'");
        }

        var data = await File.ReadAllTextAsync(path);
        return query switch
        {
            RaadpleegMetBurgerservicenummer f => new RaadpleegMetBurgerservicenummerResponse
            {
                Personen = JsonConvert.DeserializeObject<List<GbaPersoon>>(data)?
                    .AsQueryable().Where(f.ToSpecification().ToExpression()).ToList()
            },
            ZoekMetGeslachtsnaamEnGeboortedatumFilter f => new ZoekMetGeslachtsnaamEnGeboortedatumResponse
            {
                Personen = JsonConvert.DeserializeObject<List<GbaPersoonBeperkt>>(data)?
                    .AsQueryable().Where(f.ToSpecification().ToExpression()).ToList()
            },
            ZoekMetNaamEnGemeenteVanInschrijvingFilter f => new ZoekMetNaamEnGemeenteVanInschrijvingResponse
            {
                Personen = JsonConvert.DeserializeObject<List<GbaPersoonBeperkt>>(data)?
                    .AsQueryable().Where(f.ToSpecification().ToExpression()).ToList()
            },
            ZoekMetPostcodeEnHuisnummerFilter f => new ZoekMetPostcodeEnHuisnummerResponse
            {
                Personen = JsonConvert.DeserializeObject<List<GbaPersoonBeperkt>>(data)?
                    .AsQueryable().Where(f.ToSpecification().ToExpression()).ToList()
            },
            ZoekMetNummeraanduidingIdentificatie f => new ZoekMetNummeraanduidingIdentificatieResponse
            {
                Personen = JsonConvert.DeserializeObject<List<GbaPersoonBeperkt>>(data)?
                    .AsQueryable().Where(f.ToSpecification().ToExpression()).ToList()
            },
            ZoekMetStraatHuisnummerEnGemeenteVanInschrijving f => new ZoekMetStraatHuisnummerEnGemeenteVanInschrijvingResponse
            {
                Personen = JsonConvert.DeserializeObject<List<GbaPersoonBeperkt>>(data)?
                    .AsQueryable().Where(f.ToSpecification().ToExpression()).ToList()
            },
            ZoekMetAdresseerbaarObjectIdentificatie f => new ZoekMetAdresseerbaarObjectIdentificatieResponse
            {
                Personen = JsonConvert.DeserializeObject<List<GbaGezagPersoonBeperkt>>(data)?
                    .AsQueryable().Where(f.ToSpecification().ToExpression()).ToList()
            },
            _ => throw new NotSupportedException($"{query}"),
        };
    }
}
