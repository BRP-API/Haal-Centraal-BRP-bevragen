using FluentValidation;
using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Validators
{
    public abstract class PersonenQueryValidator<T> : AbstractValidator<T> where T : PersonenQuery
    {
        const string RequiredErrorMessage = "required||Parameter is verplicht.";
        const string MinItemsErrorMessage = "minItems||Array bevat minder dan {0} items.";

        protected PersonenQueryValidator(FieldsHelper fieldsHelper)
        {
            RuleFor(x => x.Fields)
                .Cascade(CascadeMode.Stop)
                .NotNull().WithMessage(RequiredErrorMessage)
                .Must(x => x.Count > 0).WithMessage(string.Format(MinItemsErrorMessage, 1));

            RuleForEach(x => x.Fields)
                .SetValidator(new PersoonBeperktFieldsValidator(fieldsHelper));
        }
    }
}
