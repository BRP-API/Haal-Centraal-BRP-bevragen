using FluentValidation;

namespace BrpProxy.Validators
{
    public class HuisnummerValidator : AbstractValidator<string?>
    {
        const string RequiredErrorMessage = "required||Parameter is verplicht.";
        const string NumberPattern = @"\d+";
        const string NumberErrorMessage = "integer||Waarde is geen geldig getal.";
        const string HuisnummerMinimumErrorMessage = "minimum||Waarde is lager dan minimum 1.";
        const string HuisnummerMaximumErrorMessage = "maximum||Waarde is hoger dan maximum 99999.";

        private static int? StringToNullableInt(string? value) =>
            int.TryParse(value, out var result)
                ? result
                : null;

        public HuisnummerValidator()
        {
            RuleFor(x => x)
                .NotEmpty().WithMessage(RequiredErrorMessage)
                .Matches(NumberPattern).WithMessage(NumberErrorMessage);

            RuleFor(x => StringToNullableInt(x))
                .GreaterThan(0).WithMessage(HuisnummerMinimumErrorMessage);

            RuleFor(x => StringToNullableInt(x))
                .LessThan(100000).WithMessage(HuisnummerMaximumErrorMessage);
        }
    }
}
