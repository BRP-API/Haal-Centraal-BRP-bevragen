using Microsoft.AspNetCore.Authentication;
using Newtonsoft.Json.Linq;
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

        _diagnosticContext.Set("Claims", jObject, true);
        principal.AddIdentity(new ClaimsIdentity(claims));

        return Task.FromResult(principal);
    }
}
