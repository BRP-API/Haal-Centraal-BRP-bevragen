using HaalCentraal.BrpService.Generated;
using Microsoft.AspNetCore.Mvc;

namespace HaalCentraal.BrpService.Controllers
{
    [ApiController]
    public class PersoonController : Generated.ControllerBase
    {
        private readonly ILogger<PersoonController> _logger;
        private readonly IWebHostEnvironment _environment;

        public PersoonController(ILogger<PersoonController> logger, IWebHostEnvironment environment)
        {
            _logger = logger;
            _environment = environment;
        }

        public override async Task<ActionResult<PersonenQueryResponse>> GetPersonen([FromBody] PersonenQuery body)
        {
            if (body is RaadpleegMetBurgerservicenummer)
            {
                return await Handle(body as RaadpleegMetBurgerservicenummer);
            }
            if(body is ZoekMetGeslachtsnaamEnGeboortedatum)
            {
                return await Handle(body as ZoekMetGeslachtsnaamEnGeboortedatum);
            }
            if(body is ZoekMetGeslachtsnaamEnGemeenteVanInschrijving)
            {
                return await Handle(body as ZoekMetGeslachtsnaamEnGemeenteVanInschrijving);
            }
            if(body is ZoekMetPostcodeEnHuisnummer)
            {
                return await Handle(body as ZoekMetPostcodeEnHuisnummer);
            }
            throw new InvalidOperationException($"Onbekend type query: {body}");
        }

        private async Task<ActionResult<PersonenQueryResponse>> Handle(ZoekMetPostcodeEnHuisnummer query)
        {
            _logger.LogInformation("ZoekMetPostcodeEnHuisnummer");

            var path = Path.Combine(_environment.ContentRootPath, $"Data/postcode-huisnummer-{query.Postcode}-{query.Huisnummer}.json");
            var data = await System.IO.File.ReadAllTextAsync(path);
            var retval = Newtonsoft.Json.JsonConvert.DeserializeObject<PersonenQueryResponse>(data);

            return Ok(retval);
        }

        private async Task<ActionResult<PersonenQueryResponse>> Handle(ZoekMetGeslachtsnaamEnGemeenteVanInschrijving query)
        {
            _logger.LogInformation("ZoekMetGeslachtsnaamEnGemeenteVanInschrijving");

            var path = Path.Combine(_environment.ContentRootPath, $"Data/geslachtsnaam-gemeente-{query.Geslachtsnaam}-{query.GemeenteVanInschrijving}.json");
            var data = await System.IO.File.ReadAllTextAsync(path);
            var retval = Newtonsoft.Json.JsonConvert.DeserializeObject<PersonenQueryResponse>(data);

            return Ok(retval);
        }

        private async Task<ActionResult<PersonenQueryResponse>> Handle(ZoekMetGeslachtsnaamEnGeboortedatum query)
        {
            _logger.LogInformation("ZoekMetGeslachtsnaamEnGeboortedatum");

            var path = Path.Combine(_environment.ContentRootPath, $"Data/geslachtsnaam-geboortedatum-{query.Geslachtsnaam}-{query.Geboortedatum.Value.ToString("yyyy-MM-dd")}.json");
            var data = await System.IO.File.ReadAllTextAsync(path);
            var retval = Newtonsoft.Json.JsonConvert.DeserializeObject<PersonenQueryResponse>(data);

            return Ok(retval);
        }

        private async Task<ActionResult<PersonenQueryResponse>> Handle(RaadpleegMetBurgerservicenummer query)
        {
            _logger.LogInformation("ZoekMetBurgerservicenummer");

            var path = Path.Combine(_environment.ContentRootPath, $"Data/bsn-{string.Join("-", query.Burgerservicenummer)}.json");
            var data = await System.IO.File.ReadAllTextAsync(path);
            var retval = Newtonsoft.Json.JsonConvert.DeserializeObject<PersonenQueryResponse>(data);

            return Ok(retval);
        }
    }
}
