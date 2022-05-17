using FluentValidation;

namespace BrpProxy.Validators
{
    public class PersoonFieldsValidator : AbstractValidator<ICollection<string>>
    {
        const string RequiredErrorMessage = "required||Parameter is verplicht.";
        const string FieldPattern = @"^[a-zA-Z0-9\._]+$";
        const string FieldPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {FieldPattern}.";
        const string FieldExistErrorMessage = "fields||Parameter bevat een niet bestaande veldnaam.";

        public PersoonFieldsValidator(FieldsHelper fieldsHelper)
        {
            var possibleFields = fieldsHelper.PersoonFieldShortcuts;
            RuleForEach(x => x)
                .Must(x => x != null).WithMessage(RequiredErrorMessage)
                .Matches(FieldPattern).WithMessage(FieldPatternErrorMessage)
                .Must(x => possibleFields.ContainsKey(x)).WithMessage(FieldExistErrorMessage);
        }
    }
}
