class World {
    constructor(parameters) {
        this.context = parameters;
        this.context.dataPath = "src/config/BrpService";
        this.context.serverUrl = "http://localhost:5001/haalcentraal/api/brp";
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
                port: 5432
            }
        };
    }
}

// set this environment variable to bypass DEPTH_ZERO_SELF_SIGNED_CERT error when using self-signed certificates
process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";

module.exports = {World}
