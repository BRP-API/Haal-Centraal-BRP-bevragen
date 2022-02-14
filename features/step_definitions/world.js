class World {
    constructor({parameters}) {
        this.context = {
            dataPath: "src/BrpService/Data",
            // serverUrl: "https://localhost:7098/haalcentraal/api/brp",
            serverUrl: "https://localhost:7074",
            persoon: {},
            zoekResponse: {
                personen: []
            }
        };
    }
}

// set this environment variable to bypass DEPTH_ZERO_SELF_SIGNED_CERT error when using self-signed certificates
process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";

module.exports = {World}
