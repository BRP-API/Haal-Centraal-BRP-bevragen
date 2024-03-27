using Microsoft.AspNetCore.Authentication;
using System.Security.Claims;

namespace Brp.Shared.Infrastructure.Autorisatie;

public class RvIGClaimsTransformation : IClaimsTransformation
{
    public Task<ClaimsPrincipal> TransformAsync(ClaimsPrincipal principal)
    {
        var claims = from claim in principal.Claims
                     where claim.Type == "claims"
                     let values = claim.Value.Split('=')
                     select new Claim(values[0], values[1]);

        principal.AddIdentity(new ClaimsIdentity(claims));

        return Task.FromResult(principal);
    }
}
