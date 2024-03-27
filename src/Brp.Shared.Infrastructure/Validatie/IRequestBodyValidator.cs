namespace Brp.Shared.Infrastructure.Validatie;

public interface IRequestBodyValidator
{
    FluentValidation.Results.ValidationResult ValidateRequestBody(string requestBody);
}
