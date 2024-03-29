using Microsoft.AspNetCore.Authentication;
using Serilog;
using System.Security.Claims;

namespace Brp.Shared.Infrastructure.Autorisatie;

public class RvIGClaimsTransformation : IClaimsTransformation
{
    private readonly IDiagnosticContext _diagnosticContext;

    public RvIGClaimsTransformation(IDiagnosticContext diagnosticContext)
    {
        _diagnosticContext = diagnosticContext;
    }
    public Task<ClaimsPrincipal> TransformAsync(ClaimsPrincipal principal)
    {
        var claims = from claim in principal.Claims
                     where claim.Type == "claims"
                     let values = claim.Value.Split('=')
                     select new Claim(values[0], values[1]);

        _diagnosticContext.Set("claims", claims, true);

        principal.AddIdentity(new ClaimsIdentity(claims));

        return Task.FromResult(principal);
    }
}
