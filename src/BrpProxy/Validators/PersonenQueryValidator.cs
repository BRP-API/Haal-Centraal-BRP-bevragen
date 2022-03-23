using FluentValidation;
using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Validators
{
    public abstract class PersonenQueryValidator<T> : AbstractValidator<T> where T : PersonenQuery
    {
        const string RequiredErrorMessage = "required||Parameter is verplicht.";

        protected PersonenQueryValidator()
        {
            RuleFor(x => x.Fields)
                .NotNull().WithMessage(RequiredErrorMessage)
                .SetValidator(new FieldsValidator());
        }
    }
}
