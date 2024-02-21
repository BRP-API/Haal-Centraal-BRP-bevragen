using Brp.Gezag.Mock.Generated;
using GezagMock.Generated;
using Newtonsoft.Json;

namespace GezagMock.Repositories;

public class GezagsrelatieRepository
{
    private readonly IWebHostEnvironment _environment;

    public GezagsrelatieRepository(IWebHostEnvironment environment)
    {
        _environment = environment;
    }

    public async Task<ICollection<Gezagsrelatie>> Zoek(string bsn)
    {
        var path = Path.Combine(_environment.ContentRootPath, "Data", "test-data.json");
        if(!File.Exists(path))
        {
            throw new FileNotFoundException($"invalid file: '{path}'");
        }

        var data = await File.ReadAllTextAsync(path);

        var retval = JsonConvert.DeserializeObject<List<Gezag>>(data)?.Find(x => x.Burgerservicenummer == bsn);

        return retval?.Gezagsrelaties ?? new List<Gezagsrelatie>();
    }
}
