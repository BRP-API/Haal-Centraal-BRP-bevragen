class World {
    constructor(parameters) {
        this.context = parameters;
        this.context.dataPath = "src/config/BrpService";
        this.context.proxyUrl = "http://localhost:5001/haalcentraal/api/brp";
        this.context.gbaUrl = "http://localhost:8000/haalcentraal/api/brp/v2";
        this.context.extraHeaders = [
            { "naam": "Authorization", "waarde": "Basic OTkwMDA4fDU5OTp0ZW1wc29sdXRpb24h" }
        ];
        this.context.persoon = {};
        this.context.zoekResponse = {
            personen: []
        };
        this.context.sql = {
            useDb: true,
            logStatements: true,
            cleanup: true,
            poolConfig: {
                user: "root",
                host: "localhost",
                database: "rvig_haalcentraal_testdata",
                password: "root",
                port: 5432,
                allowExitOnIdle: true
            }
        };
        this.context.oAuth = {
            enable: true,
            accessTokenUrl: "https://login.dev.idsecure.nl/nidp/oauth/nam/token",
            clients:[
                {
                    afnemerID: "000008",
                    clientId: "5ddfe678-928b-4270-a20a-0d6cd5979f31",
                    clientSecret: "NgRKvAHaG8jJs9mhqfRKvVIH3f_gN0MRa1ycnXPMLYouv1-0HMt51xDrY6pnoz39dgbgZtDlwIy0dwdoB3UwQA",
                    scopes: ["000000099000000080000"]
                }
            ]
        }
    }
}

// set this environment variable to bypass DEPTH_ZERO_SELF_SIGNED_CERT error when using self-signed certificates
process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";

module.exports = {World}
