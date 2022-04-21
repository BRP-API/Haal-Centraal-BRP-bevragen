using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Validators;

public class ZoekMetGeslachtsnaamEnGeboortedatumQueryValidator : PersonenQueryValidator<ZoekMetGeslachtsnaamEnGeboortedatum>
{
    public ZoekMetGeslachtsnaamEnGeboortedatumQueryValidator(FieldsHelper fieldsHelper)
        : base(fieldsHelper)
    {}
}
