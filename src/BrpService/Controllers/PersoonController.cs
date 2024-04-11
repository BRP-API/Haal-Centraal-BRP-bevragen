using AutoMapper;
using HaalCentraal.BrpService.Generated;
using HaalCentraal.BrpService.Repositories;
using Microsoft.AspNetCore.Mvc;
using Serilog;
using System.Diagnostics;

namespace HaalCentraal.BrpService.Controllers;

[ApiController]
public class PersoonController : Generated.ControllerBase
{
    private readonly IDiagnosticContext _diagnosticContext;
    private readonly IMapper _mapper;
    private readonly PersoonRepository _repository;

    public PersoonController(IDiagnosticContext diagnosticContext, IMapper mapper, PersoonRepository repository)
    {
        _diagnosticContext = diagnosticContext;
        _mapper = mapper;
        _repository = repository;
    }

    public override async Task<ActionResult<PersonenQueryResponse>> GetPersonen([FromBody] PersonenQuery body)
    {
        var retval = body switch
        {
            RaadpleegMetBurgerservicenummer q => await Handle(q),
            ZoekMetAdresseerbaarObjectIdentificatie q => await Handle(q),
            ZoekMetGeslachtsnaamEnGeboortedatum q => await Handle(q),
            ZoekMetNaamEnGemeenteVanInschrijving q => await Handle(q),
            ZoekMetPostcodeEnHuisnummer q => await Handle(q),
            ZoekMetNummeraanduidingIdentificatie q => await Handle(q),
            ZoekMetStraatHuisnummerEnGemeenteVanInschrijving q => await Handle(q),
            _ => throw new InvalidOperationException($"Onbekend type query: {body}"),
        };

        return Ok(retval);
    }

    private async Task<PersonenQueryResponse> Handle(ZoekMetAdresseerbaarObjectIdentificatie query)
    {
        Activity.Current?.AddEvent(new ActivityEvent("ZoekMetAdresseerbaarObjectIdentificatie"));

        var retval = await _repository.Zoek<ZoekMetAdresseerbaarObjectIdentificatie>(query);

        Activity.Current?.AddEvent(new ActivityEvent("ZoekMetAdresseerbaarObjectIdentificatie query executed"));

        return retval;
    }

    private async Task<PersonenQueryResponse> Handle(ZoekMetPostcodeEnHuisnummer query)
    {
        Activity.Current?.AddEvent(new ActivityEvent("ZoekMetPostcodeEnHuisnummer"));

        var filter = _mapper.Map<ZoekMetPostcodeEnHuisnummerFilter>(query);

        Activity.Current?.AddEvent(new ActivityEvent("ZoekMetPostcodeEnHuisnummer filter created"));

        var retval = await _repository.Zoek<ZoekMetPostcodeEnHuisnummerFilter>(filter);

        Activity.Current?.AddEvent(new ActivityEvent("ZoekMetPostcodeEnHuisnummer query executed"));

        return retval;
    }

    private async Task<PersonenQueryResponse> Handle(ZoekMetNaamEnGemeenteVanInschrijving query)
    {
        Activity.Current?.AddEvent(new ActivityEvent("ZoekMetNaamEnGemeenteVanInschrijving"));

        var filter = _mapper.Map<ZoekMetNaamEnGemeenteVanInschrijvingFilter>(query);

        Activity.Current?.AddEvent(new ActivityEvent("ZoekMetNaamEnGemeenteVanInschrijving filter created"));

        var retval = await _repository.Zoek<ZoekMetNaamEnGemeenteVanInschrijvingFilter>(filter);

        Activity.Current?.AddEvent(new ActivityEvent("ZoekMetNaamEnGemeenteVanInschrijving query executed"));

        return retval;
    }

    private async Task<PersonenQueryResponse> Handle(ZoekMetGeslachtsnaamEnGeboortedatum query)
    {
        Activity.Current?.AddEvent(new ActivityEvent("ZoekMetGeslachtsnaamEnGeboortedatum"));

        var filter = _mapper.Map<ZoekMetGeslachtsnaamEnGeboortedatumFilter>(query);

        Activity.Current?.AddEvent(new ActivityEvent("ZoekMetGeslachtsnaamEnGeboortedatum filter created"));

        var retval = await _repository.Zoek<ZoekMetGeslachtsnaamEnGeboortedatumFilter>(filter);

        Activity.Current?.AddEvent(new ActivityEvent("ZoekMetGeslachtsnaamEnGeboortedatum query executed"));

        return retval;
    }

    private async Task<PersonenQueryResponse> Handle(RaadpleegMetBurgerservicenummer query)
    {
        Activity.Current?.AddEvent(new ActivityEvent("RaadpleegMetBurgerservicenummer"));

        var retval = await _repository.Zoek<RaadpleegMetBurgerservicenummer>(query);

        Activity.Current?.AddEvent(new ActivityEvent("RaadpleegMetBurgerservicenummer query executed"));

        return retval;
    }

    private async Task<PersonenQueryResponse> Handle(ZoekMetNummeraanduidingIdentificatie query)
    {
        Activity.Current?.AddEvent(new ActivityEvent("ZoekMetNummeraanduidingIdentificatie"));

        var retval = await _repository.Zoek<ZoekMetNummeraanduidingIdentificatie>(query);

        Activity.Current?.AddEvent(new ActivityEvent("ZoekMetNummeraanduidingIdentificatie query executed"));

        return retval;
    }

    private async Task<PersonenQueryResponse> Handle(ZoekMetStraatHuisnummerEnGemeenteVanInschrijving query)
    {
        Activity.Current?.AddEvent(new ActivityEvent("ZoekMetStraatHuisnummerEnGemeenteVanInschrijving"));

        var retval = await _repository.Zoek<ZoekMetStraatHuisnummerEnGemeenteVanInschrijving>(query);

        Activity.Current?.AddEvent(new ActivityEvent("ZoekMetStraatHuisnummerEnGemeenteVanInschrijving query executed"));

        return retval;
    }
}
