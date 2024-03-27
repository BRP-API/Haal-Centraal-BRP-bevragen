namespace Brp.Shared.Infrastructure.Autorisatie;

public class AuthorisationResult
{
    public bool IsValid { get; set; }
    public List<AuthorisationFailure> Errors { get; set; } = new();
}
