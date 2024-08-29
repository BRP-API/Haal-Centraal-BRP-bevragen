using Brp.Shared.Infrastructure.Logging;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Http;
using System.Security.Claims;

namespace Brp.Shared.Infrastructure.Autorisatie;

public class RvIGClaimsTransformation : IClaimsTransformation
{
    private readonly IHttpContextAccessor _httpContextAccessor;

    public RvIGClaimsTransformation(IHttpContextAccessor httpContextAccessor)
    {
        _httpContextAccessor = httpContextAccessor;
    }

    public Task<ClaimsPrincipal> TransformAsync(ClaimsPrincipal principal)
    {
        List<Claim> claims = new();
        Dictionary<string, string> logInfo = new();

        var claimKeyValuePairs = from claim in principal.Claims
                                 where claim.Type == "claims"
                                 let values = claim.Value.Split('=')
                                 select values;
        foreach (var claimKeyValue in claimKeyValuePairs)
        {
            logInfo.Add(claimKeyValue[0], claimKeyValue[1]);
            claims.Add(new Claim(claimKeyValue[0], claimKeyValue[1]));
        }

        if (_httpContextAccessor.HttpContext != null)
        {
            _httpContextAccessor.HttpContext.GetAutorisatieLog().Claims = logInfo;
        }

        principal.AddIdentity(new ClaimsIdentity(claims));

        return Task.FromResult(principal);
    }
}
