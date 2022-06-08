using AutoMapper;
using HaalCentraal.BrpService.Generated;
using HaalCentraal.BrpService.Repositories;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace HaalCentraal.BrpService.Controllers;

[ApiController]
public class PersoonController : Generated.ControllerBase
{
    private readonly ILogger<PersoonController> _logger;
    private readonly IMapper _mapper;
    private readonly PersoonRepository _repository;
    private readonly IWebHostEnvironment _environment;

    public PersoonController(ILogger<PersoonController> logger, IMapper mapper, PersoonRepository repository, IWebHostEnvironment environment)
    {
        _logger = logger;
        _mapper = mapper;
        _repository = repository;
        _environment = environment;
    }

    public override async Task<ActionResult<PersonenQueryResponse>> GetPersonen([FromBody] PersonenQuery body)
    {
        System.IO.File.WriteAllText(Path.Combine(_environment.ContentRootPath, "Data", "requestBody.json"),
                                    JsonConvert.SerializeObject(body));

        return body switch
        {
            RaadpleegMetBurgerservicenummer q => await Handle(q),
            ZoekMetGeslachtsnaamEnGeboortedatum q => await Handle(q),
            ZoekMetNaamEnGemeenteVanInschrijving q => await Handle(q),
            ZoekMetPostcodeEnHuisnummer q => await Handle(q),
            ZoekMetNummeraanduidingIdentificatie q => await Handle(q),
            _ => throw new InvalidOperationException($"Onbekend type query: {body}"),
        };
    }

    private async Task<ActionResult<PersonenQueryResponse>> Handle(ZoekMetPostcodeEnHuisnummer query)
    {
        _logger.LogDebug("Request body: {@query}", JsonConvert.SerializeObject(query));

        var filter = _mapper.Map<ZoekMetPostcodeEnHuisnummerFilter>(query);

        var retval = await _repository.Zoek<ZoekMetPostcodeEnHuisnummerFilter>(filter);

        _logger.LogDebug("Response: {@response}", JsonConvert.SerializeObject(retval));

        return Ok(retval);
    }

    private async Task<ActionResult<PersonenQueryResponse>> Handle(ZoekMetNaamEnGemeenteVanInschrijving query)
    {
        _logger.LogDebug("Request body: {@query}", JsonConvert.SerializeObject(query));

        var filter = _mapper.Map<ZoekMetNaamEnGemeenteVanInschrijvingFilter>(query);

        var retval = await _repository.Zoek<ZoekMetNaamEnGemeenteVanInschrijvingFilter>(filter);

        _logger.LogDebug("Response: {@response}", JsonConvert.SerializeObject(retval));

        return Ok(retval);
    }

    private async Task<ActionResult<PersonenQueryResponse>> Handle(ZoekMetGeslachtsnaamEnGeboortedatum query)
    {
        _logger.LogDebug("Request body: {@query}", JsonConvert.SerializeObject(query));

        var filter = _mapper.Map<ZoekMetGeslachtsnaamEnGeboortedatumFilter>(query);

        var retval = await _repository.Zoek<ZoekMetGeslachtsnaamEnGeboortedatumFilter>(filter);

        _logger.LogDebug("Response: {@response}", JsonConvert.SerializeObject(retval));

        return Ok(retval);
    }

    private async Task<ActionResult<PersonenQueryResponse>> Handle(RaadpleegMetBurgerservicenummer query)
    {
        _logger.LogDebug("Request body: {@query}", JsonConvert.SerializeObject(query));

        var retval = await _repository.Zoek<RaadpleegMetBurgerservicenummer>(query);

        _logger.LogDebug("Response: {@response}", JsonConvert.SerializeObject(retval));

        return Ok(retval);
    }

    private async Task<ActionResult<PersonenQueryResponse>> Handle(ZoekMetNummeraanduidingIdentificatie query)
    {
        _logger.LogDebug("Request body: {@query}", JsonConvert.SerializeObject(query));

        var retval = await _repository.Zoek<ZoekMetNummeraanduidingIdentificatie>(query);

        _logger.LogDebug("Response: {@response}", JsonConvert.SerializeObject(retval));

        return Ok(retval);
    }
}
