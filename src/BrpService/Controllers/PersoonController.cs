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

        public override async Task<ActionResult<PersoonBeperktHalCollectie>> GetPersonen([FromBody] ZoekPersonenQuery body)
        {
            if (body is ZoekMetBurgerservicenummer)
            {
                return await Handle(body as ZoekMetBurgerservicenummer);
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
            throw new InvalidOperationException($"Onbekend type query: {this.ControllerContext.HttpContext.Request}");
        }

        private async Task<ActionResult<PersoonBeperktHalCollectie>> Handle(ZoekMetPostcodeEnHuisnummer query)
        {
            _logger.LogInformation("ZoekMetPostcodeEnHuisnummer");

            var path = Path.Combine(_environment.ContentRootPath, $"Data/postcode-huisnummer-{query.Postcode}-{query.Huisnummer}.json");
            var data = await System.IO.File.ReadAllTextAsync(path);
            var retval = Newtonsoft.Json.JsonConvert.DeserializeObject<PersoonBeperktHalCollectie>(data);

            return Ok(retval);
        }

        private async Task<ActionResult<PersoonBeperktHalCollectie>> Handle(ZoekMetGeslachtsnaamEnGemeenteVanInschrijving query)
        {
            _logger.LogInformation("ZoekMetGeslachtsnaamEnGemeenteVanInschrijving");

            var path = Path.Combine(_environment.ContentRootPath, $"Data/geslachtsnaam-gemeente-{query.Geslachtsnaam}-{query.GemeenteVanInschrijving}.json");
            var data = await System.IO.File.ReadAllTextAsync(path);
            var retval = Newtonsoft.Json.JsonConvert.DeserializeObject<PersoonBeperktHalCollectie>(data);

            return Ok(retval);
        }

        private async Task<ActionResult<PersoonBeperktHalCollectie>> Handle(ZoekMetGeslachtsnaamEnGeboortedatum query)
        {
            _logger.LogInformation("ZoekMetGeslachtsnaamEnGeboortedatum");

            var path = Path.Combine(_environment.ContentRootPath, $"Data/geslachtsnaam-geboortedatum-{query.Geslachtsnaam}-{query.Geboortedatum.Value.ToString("yyyy-MM-dd")}.json");
            var data = await System.IO.File.ReadAllTextAsync(path);
            var retval = Newtonsoft.Json.JsonConvert.DeserializeObject<PersoonBeperktHalCollectie>(data);

            return Ok(retval);
        }

        private async Task<ActionResult<PersoonBeperktHalCollectie>> Handle(ZoekMetBurgerservicenummer query)
        {
            _logger.LogInformation("ZoekMetBurgerservicenummer");

            var path = Path.Combine(_environment.ContentRootPath, $"Data/bsn-{string.Join("-", query.Burgerservicenummer)}.json");
            var data = await System.IO.File.ReadAllTextAsync(path);
            var retval = Newtonsoft.Json.JsonConvert.DeserializeObject<PersoonBeperktHalCollectie>(data);

            return Ok(retval);
        }

        public override async Task<ActionResult<PersoonHal>> GetPersoon(Guid persoonIdentificatie, [FromQuery] string fields)
        {
            _logger.LogInformation("RaadpleegPersoon");

            var path = Path.Combine(_environment.ContentRootPath, $"Data/{persoonIdentificatie}.json");
            var data = await System.IO.File.ReadAllTextAsync(path);
            var retval = Newtonsoft.Json.JsonConvert.DeserializeObject<PersoonHal>(data);

            return Ok(retval);
        }
    }
}
