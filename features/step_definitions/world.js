class World {
    constructor(parameters) {
        this.context = parameters;
        this.context.dataPath = "src/config/BrpService";
        this.context.serverUrl = "http://localhost:5000/haalcentraal/api/brp";
        this.context.persoon = {};
        this.context.zoekResponse = {
            personen: []
        };
    }
}

// set this environment variable to bypass DEPTH_ZERO_SELF_SIGNED_CERT error when using self-signed certificates
process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";

module.exports = {World}
