using FluentValidation;
using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Validators
{
    public class FieldsValidator : AbstractValidator<string?>
    {
        const string RequiredErrorMessage = "required||Parameter is verplicht.";
        const string FieldsPattern = @"^[a-zA-Z0-9\.,_]+$";
        const string FieldsPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {FieldsPattern}.";

        public FieldsValidator()
        {
            RuleFor(x => x)
                .Cascade(CascadeMode.Stop)
                .Must(x => x != null).WithMessage(RequiredErrorMessage)
                .Matches(FieldsPattern).WithMessage(FieldsPatternErrorMessage)
                .Custom((value, context) =>
                {
                    var possibleFields = typeof(Persoon).GetPropertyPaths("HaalCentraal");
                    var fields = value.Split(',');
                    foreach (var field in fields)
                    {
                        var matches = possibleFields.FindAll(x => x.Contains(field));
                    switch (matches.Count)
                    {
                        case 0:
                            context.AddFailure("fields", "fields||Parameter bevat een niet bestaande propertynaam.");
                            break;
                        default:
                            foreach (var match in matches)
                            {
                                Console.WriteLine(match);
                            }
                            matches = matches.FindAll(x => x == field);
                            if(matches.Count != 1)
                            {
                                context.AddFailure("fields", $"fields||Deel van de parameterwaarde niet correct: {field}.");
                            }
                                //if (!field.Contains('.') &&
                                //    !matches.Any(x => x.Split('.')[0] == field))
                                //{
                                //    context.AddFailure("fields", $"fields||Deel van de parameterwaarde niet correct: {field}.");
                                //}
                                break;
                        }
                    }
                });
        }
    }
}
