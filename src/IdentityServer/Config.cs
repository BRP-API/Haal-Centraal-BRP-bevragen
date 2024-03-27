using Duende.IdentityServer.Models;

namespace IdentityServer;

public static class Config
{
    public static IEnumerable<IdentityResource> IdentityResources =>
        [ 
            new IdentityResources.OpenId()
        ];

    public static IEnumerable<ApiScope> ApiScopes =>
        [
            new("000000099000000080000", "BRP")
        ];

    public static IEnumerable<Client> Clients =>
        [
            new()
            {
                ClientId = "client met gemeentecode",

                AllowedGrantTypes = GrantTypes.ClientCredentials,

                ClientSecrets =
                {
                    new Secret("secret".Sha256())
                },

                AllowedScopes = { "000000099000000080000" },

                ClientClaimsPrefix = "",
                Claims =
                {
                    new ClientClaim("claims", "OIN=000000099000000080000"),
                    new ClientClaim("claims", "afnemerID=000008"),
                    new ClientClaim("claims", "gemeenteCode=0800")
                }
            },
            new()
            {
                ClientId = "client zonder gemeentecode",

                AllowedGrantTypes = GrantTypes.ClientCredentials,

                ClientSecrets =
                {
                    new Secret("secret".Sha256())
                },

                AllowedScopes = { "000000099000000080000" },

                ClientClaimsPrefix = "",
                Claims =
                {
                    new ClientClaim("claims", "OIN=000000099000000080000"),
                    new ClientClaim("claims", "afnemerID=000008"),
                }
            },
        ];
}