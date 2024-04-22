namespace Brp.Shared.Infrastructure.Autorisatie;

public class AuthorisationResult
{
    public AuthorisationResult(bool isValid, IEnumerable<AuthorisationFailure> errors)
    {
        IsValid = isValid;
        Errors = new(errors);
    }

    public bool IsValid { get; }
    public List<AuthorisationFailure> Errors { get; }
}
