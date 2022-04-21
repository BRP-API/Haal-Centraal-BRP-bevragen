using FluentValidation;

namespace BrpProxy.Validators
{
    public class PersoonFieldsValidator : AbstractValidator<string?>
    {
        const string RequiredErrorMessage = "required||Parameter is verplicht.";
        const string FieldsPattern = @"^[a-zA-Z0-9\.,_]+$";
        const string FieldsPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {FieldsPattern}.";

        public PersoonFieldsValidator(FieldsHelper fieldsHelper)
        {
            RuleFor(x => x)
                .Cascade(CascadeMode.Stop)
                .Must(x => x != null).WithMessage(RequiredErrorMessage)
                .Matches(FieldsPattern).WithMessage(FieldsPatternErrorMessage)
                .Custom((value, context) =>
                {
                    var possibleFields = fieldsHelper.PersoonFieldShortcuts;
                    var fields = value.Split(',');
                    foreach (var field in fields)
                    {
                        if(!possibleFields.ContainsKey(field))
                        {
                            context.AddFailure("fields", "fields||Parameter bevat een niet bestaande veldnaam.");
                        }
                    }
                });
        }
    }
}
