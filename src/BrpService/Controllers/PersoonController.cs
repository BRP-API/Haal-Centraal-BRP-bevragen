using HaalCentraal.BrpService.Generated;
using HaalCentraal.BrpService.Repositories;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace HaalCentraal.BrpService.Controllers
{
    [ApiController]
    public class PersoonController : Generated.ControllerBase
    {
        private readonly ILogger<PersoonController> _logger;
        private readonly PersoonRepository _repository;

        public PersoonController(ILogger<PersoonController> logger, PersoonRepository repository)
        {
            _logger = logger;
            _repository = repository;
        }

        public override async Task<ActionResult<PersonenQueryResponse>> GetPersonen([FromBody] PersonenQuery body)
        {
            return body switch
            {
                RaadpleegMetBurgerservicenummer q => await Handle(q),
                ZoekMetGeslachtsnaamEnGeboortedatum q => await Handle(q),
                ZoekMetNaamEnGemeenteVanInschrijving q => await Handle(q),
                ZoekMetPostcodeEnHuisnummer q => await Handle(q),
                _ => throw new InvalidOperationException($"Onbekend type query: {body}"),
            };
        }

        private async Task<ActionResult<PersonenQueryResponse>> Handle(ZoekMetPostcodeEnHuisnummer query)
        {
            _logger.LogDebug(nameof(ZoekMetPostcodeEnHuisnummer));

            var retval = await _repository.Zoek<ZoekMetPostcodeEnHuisnummer, ZoekMetPostcodeEnHuisnummerResponse>(query);

            retval.Personen = retval.Personen.Where(x => string.Compare(x.Verblijfplaats?.Postcode, query.Postcode, true) == 0 &&
                                                         x.Verblijfplaats?.Huisnummer == query.Huisnummer).ToList();

            return Ok(retval);
        }

        private async Task<ActionResult<PersonenQueryResponse>> Handle(ZoekMetNaamEnGemeenteVanInschrijving query)
        {
            _logger.LogDebug(nameof(ZoekMetNaamEnGemeenteVanInschrijving));

            var retval = await _repository.Zoek<ZoekMetNaamEnGemeenteVanInschrijving, ZoekMetNaamEnGemeenteVanInschrijvingResponse>(query);

            retval.Personen = retval.Personen.Where(x => string.Compare(x.Naam?.Geslachtsnaam, query.Geslachtsnaam, true) == 0 &&
                                                         string.Compare(x.Naam?.Voornamen, query.Voornamen, true) == 0 &&
                                                         x.Verblijfplaats?.GemeenteVanInschrijving?.Code == query.GemeenteVanInschrijving).ToList();
            return Ok(retval);
        }

        private async Task<ActionResult<PersonenQueryResponse>> Handle(ZoekMetGeslachtsnaamEnGeboortedatum query)
        {
            _logger.LogDebug("ZoekMetGeslachtsnaamEnGeboortedatum: {query}", query);

            var retval = await _repository.Zoek<ZoekMetGeslachtsnaamEnGeboortedatum, ZoekMetGeslachtsnaamEnGeboortedatumResponse>(query);

            retval.Personen = retval.Personen.AsQueryable().Where(query.ToSpecification().ToExpression()).ToList();

            return Ok(retval);
        }

        private async Task<ActionResult<PersonenQueryResponse>> Handle(RaadpleegMetBurgerservicenummer query)
        {
            _logger.LogDebug("Request body: {@query}", JsonConvert.SerializeObject(query));

            var retval = await _repository.Zoek<RaadpleegMetBurgerservicenummer, RaadpleegMetBurgerservicenummerResponse>(query);

            retval.Personen = retval.Personen.AsQueryable().Where(query.ToSpecification().ToExpression()).ToList();

            _logger.LogDebug("Response: {@response}", JsonConvert.SerializeObject(retval));

            return Ok(retval);
        }
    }
}
