using AutoMapper;
using HaalCentraal.BrpService.Generated;
using HaalCentraal.BrpService.Repositories;
using Microsoft.AspNetCore.Mvc;

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
        _logger.LogDebug("Request headers: {@headers}", HttpContext.Request.Headers);
        _logger.LogDebug("Request body: {@body}", body);


        var retval = body switch
        {
            RaadpleegMetBurgerservicenummer q => await Handle(q),
            ZoekMetGeslachtsnaamEnGeboortedatum q => await Handle(q),
            ZoekMetNaamEnGemeenteVanInschrijving q => await Handle(q),
            ZoekMetPostcodeEnHuisnummer q => await Handle(q),
            ZoekMetNummeraanduidingIdentificatie q => await Handle(q),
            ZoekMetStraatHuisnummerEnGemeenteVanInschrijving q => await Handle(q),
            _ => throw new InvalidOperationException($"Onbekend type query: {body}"),
        };

        _logger.LogDebug("Response body: {@responsebody}", retval);

        return Ok(retval);
    }

    private async Task<PersonenQueryResponse> Handle(ZoekMetPostcodeEnHuisnummer query)
    {
        var filter = _mapper.Map<ZoekMetPostcodeEnHuisnummerFilter>(query);

        return await _repository.Zoek<ZoekMetPostcodeEnHuisnummerFilter>(filter);
    }

    private async Task<PersonenQueryResponse> Handle(ZoekMetNaamEnGemeenteVanInschrijving query)
    {
        var filter = _mapper.Map<ZoekMetNaamEnGemeenteVanInschrijvingFilter>(query);

        return await _repository.Zoek<ZoekMetNaamEnGemeenteVanInschrijvingFilter>(filter);
    }

    private async Task<PersonenQueryResponse> Handle(ZoekMetGeslachtsnaamEnGeboortedatum query)
    {
        var filter = _mapper.Map<ZoekMetGeslachtsnaamEnGeboortedatumFilter>(query);

        return await _repository.Zoek<ZoekMetGeslachtsnaamEnGeboortedatumFilter>(filter);
    }

    private async Task<PersonenQueryResponse> Handle(RaadpleegMetBurgerservicenummer query)
    {
        return await _repository.Zoek<RaadpleegMetBurgerservicenummer>(query);
    }

    private async Task<PersonenQueryResponse> Handle(ZoekMetNummeraanduidingIdentificatie query)
    {
        return await _repository.Zoek<ZoekMetNummeraanduidingIdentificatie>(query);
    }

    private async Task<PersonenQueryResponse> Handle(ZoekMetStraatHuisnummerEnGemeenteVanInschrijving query)
    {
        return await _repository.Zoek<ZoekMetStraatHuisnummerEnGemeenteVanInschrijving>(query);
    }
}
