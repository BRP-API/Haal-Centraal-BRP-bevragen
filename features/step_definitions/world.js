class World {
    constructor(parameters) {
        this.context = parameters;
        this.context.proxyUrl = "http://localhost:5001/haalcentraal/api/brp";
        this.context.apiUrl = "http://localhost:8000/haalcentraal/api/brp";
        this.context.extraHeaders = [
            { "naam": "Authorization", "waarde": "" }
        ];
        this.context.sql = {
            useDb: true,
            logStatements: false,
            cleanup: true,
            poolConfig: {
                user: "",
                host: "",
                database: "rvig_haalcentraal_testdata",
                password: "",
                port: 5432,
                allowExitOnIdle: true
            }
        };
        this.context.oAuth = {
            enable: false,
            accessTokenUrl: "https://login.dev.idsecure.nl/nidp/oauth/nam/token",
            clients:[
                {
                    afnemerID: "000008",
                    clientId: "",
                    clientSecret: "",
                    scopes: ["000000099000000080000"]
                }
            ]
        }
        if(this.context.parameters?.poolConfig !== undefined) {
            this.context.sql.poolConfig.host = this.context.parameters.poolConfig.host;
            this.context.sql.poolConfig.user = this.context.parameters.poolConfig.user;
            this.context.sql.poolConfig.password = this.context.parameters.poolConfig.password
        }
        if(this.context.parameters?.client !== undefined) {
            this.context.oAuth.clients[0].clientId = this.context.parameters.client.clientId; 
            this.context.oAuth.clients[0].clientSecret = this.context.parameters.client.clientSecret; 
        }
    }
}

// set this environment variable to bypass DEPTH_ZERO_SELF_SIGNED_CERT error when using self-signed certificates
process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";

module.exports = {World}
