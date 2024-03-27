const { createLogger, format, transports } = require('winston');

class World {
    constructor(parameters) {
        this.context = parameters;

        this.context.autzUrl = 'http://localhost:8080/haalcentraal/api/brp'
        this.context.apiUrl = 'http://localhost:8000/haalcentraal/api/brp'
        this.context.proxyUrl = 'http://localhost:5002/haalcentraal/api/brp'

        this.context.gezagDataPath = '';

        this.context.sql = {
            useDb: true,
            cleanup: true,
            deleteIndividualRecords: true,
            poolConfig: {
                user: 'root',
                host: 'localhost',
                database: 'rvig_haalcentraal_testdata',
                password: 'root',
                port: 5432,
                allowExitOnIdle: true
            }
        };

        this.context.oAuth = {
            enable: true,
            accessTokenUrl: 'http://identityserver:6000/connect/token',
            clients:[
                {
                    afnemerID: '000008',
                    gemeenteCode: '0800',
                    clientId: 'client met gemeentecode',
                    clientSecret: 'secret',
                    scopes: [ '000000099000000080000' ],
                    resourceServer: 'ResourceServer02'
                },
                {
                    afnemerID: '000008',
                    clientId: 'client zonder gemeentecode',
                    clientSecret: 'secret',
                    scopes: [ '000000099000000080000' ],
                    resourceServer: 'ResourceServer02'
                }
            ]
        }

        this.context.logger = createLogger({
            level: 'warn',
            transports: [
                new transports.Console({ format: format.prettyPrint() })
            ]
        });

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
// process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";

module.exports = { World }

