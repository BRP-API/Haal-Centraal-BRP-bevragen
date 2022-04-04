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

    public async Task<TResult> Zoek<T, TResult>(T query) where TResult : PersonenQueryResponse
    {
        var filename = query switch
        {
            RaadpleegMetBurgerservicenummer => "bsn.json",
            ZoekMetGeslachtsnaamEnGeboortedatumFilter => "geslachtsnaam-geboortedatum.json",
            ZoekMetNaamEnGemeenteVanInschrijvingFilter => "naam-gemeentevaninschrijving.json",
            ZoekMetPostcodeEnHuisnummerFilter => "postcode-huisnummer.json",
            _ => throw new NotSupportedException($"{query}")
        };

        var path = Path.Combine(_environment.ContentRootPath, "Data", filename);
        if (!File.Exists(path))
        {
            throw new FileNotFoundException($"invalid file: '{path}'");
        }

        var data = await File.ReadAllTextAsync(path);
        var retval = JsonConvert.DeserializeObject<TResult>(data);

        return retval!;
    }
}
