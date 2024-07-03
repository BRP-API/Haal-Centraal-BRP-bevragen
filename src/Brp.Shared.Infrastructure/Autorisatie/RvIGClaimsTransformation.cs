using Brp.Shared.Infrastructure.Json;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json.Linq;
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
        JObject jObject = new();

        var claimKeyValuePairs = from claim in principal.Claims
                                 where claim.Type == "claims"
                                 let values = claim.Value.Split('=')
                                 select values;
        foreach (var claimKeyValue in claimKeyValuePairs )
        {
            jObject.Add(claimKeyValue[0], claimKeyValue[1]);
            claims.Add(new Claim(claimKeyValue[0], claimKeyValue[1]));
        }

        _httpContextAccessor.HttpContext?.Items.Add("Claims", jObject.ToJsonCompact());

        principal.AddIdentity(new ClaimsIdentity(claims));

        return Task.FromResult(principal);
    }
}
