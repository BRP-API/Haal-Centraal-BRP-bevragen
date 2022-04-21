using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Validators;

public class ZoekMetNaamEnGemeenteVanInschrijvingQueryValidator : PersonenQueryValidator<ZoekMetNaamEnGemeenteVanInschrijving>
{
    public ZoekMetNaamEnGemeenteVanInschrijvingQueryValidator(FieldsHelper fieldsHelper)
        : base(fieldsHelper)
    {}
}
