using FluentValidation;

namespace BrpProxy.Validators
{
    public class PersoonBeperktFieldsValidator : AbstractValidator<string>
    {
        const string RequiredErrorMessage = "required||Parameter is verplicht.";
        const string FieldPattern = @"^[a-zA-Z0-9\._]{1,199}$";
        const string FieldPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {FieldPattern}.";
        const string FieldExistErrorMessage = "fields||Parameter bevat een niet bestaande veldnaam.";

        public PersoonBeperktFieldsValidator(FieldsHelper fieldsHelper)
        {
            var possibleFields = fieldsHelper.PersoonBeperktFieldShortcuts;
            RuleFor(x => x)
                .Cascade(CascadeMode.Stop)
                .Must(x => x != null).WithMessage(RequiredErrorMessage)
                .Matches(FieldPattern).WithMessage(FieldPatternErrorMessage)
                .Must(x => possibleFields.ContainsKey(x)).WithMessage(FieldExistErrorMessage);
        }
    }
}
