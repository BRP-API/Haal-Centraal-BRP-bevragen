using FluentValidation;
using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Validators;

public class AdditionalPropertiesValidator : AbstractValidator<KeyValuePair<string, object>>
{
	public AdditionalPropertiesValidator()
	{
		RuleFor(x => x.Key)
			.Null().WithMessage("{PropertyValue}||unknownParam||Parameter is niet verwacht.");
	}
}
