const { createGegevensgroepAutorisatie } = require('./autorisatie');
const { toDateOrString } = require('./brpDatum');
const axios = require('axios');

function createHeaders(dataTable, extraHeaders) {
    let headers = {};

    if(dataTable !== undefined){
        dataTable.hashes()
        .filter(function(param) {
            return param.naam.startsWith("header:");
        })
        .forEach(function(param) {
            headers[param.naam.slice(8)] = param.waarde;
        });
    }

    if(headers.Accept === undefined) {
        headers.Accept = "application/json";
    }
    if(headers["Content-Type"] === undefined) {
        headers["Content-Type"] = "application/json";
    }
    extraHeaders.forEach(function(header){
        headers[header.naam] = header.waarde;
    });

    return headers;
}

function isRaadpleegMetBurgerservicenummerAanroep(type, param) {
    return type === 'RaadpleegMetBurgerservicenummer' &&
           param.naam === 'burgerservicenummer';
}

function isRaadpleegMetReisdocumentnummerAanroep(type, param) {
    return type === 'RaadpleegMetReisdocumentnummer' &&
           param.naam === 'reisdocumentnummer';
}

function isArrayParameter(type, param, baseUrl = undefined) {
    return isRaadpleegMetBurgerservicenummerAanroep(type, param) ||
           isRaadpleegMetReisdocumentnummerAanroep(type, param) ||
           param.naam === 'fields' ||
           (baseUrl !== undefined && baseUrl.toLowerCase().includes('gezag'));
}

function createRequestBody(dataTable, baseUrl = undefined) {
    if(dataTable === undefined) {
        return undefined;
    }
    
    let requestBody = {};
    const type = dataTable.hashes().find(param => param.naam === 'type')?.waarde;

    dataTable.hashes()
            .filter(function(param) {
                return !param.naam.startsWith("header:");
            })
            .forEach(function(param) {
                if (param.naam === '' && param.waarde === '') {
                    // do nothing
                }
                else if (isArrayParameter(type, param, baseUrl)) {
                        requestBody[param.naam] = param.waarde === '' 
                            ? []
                            : param.waarde.split(',');
                }
                else if (param.naam === 'burgerservicenummer (als string)') {
                    requestBody['burgerservicenummer'] = param.waarde;
                }
                else if (param.naam === 'fields (als string)') {
                    requestBody['fields'] = param.waarde;
                }
                else if (param.waarde === '(131 maal aNummer)') {
                    requestBody[param.naam] = [];
                    for(let count=0; count<=131; count++) {
                        requestBody[param.naam].push('aNummer');
                    }
                }
                else {
                    requestBody[param.naam] = toDateOrString(param.waarde, true);
                }
            });

    return requestBody;
}

async function getOAuthAccessToken(accessTokenUrl, oAuthSettings) {
    const config = {
        method: 'post',
        url: accessTokenUrl,
        headers: { 'content-type': 'application/x-www-form-urlencoded'},
        data: new URLSearchParams({
            grant_type: 'client_credentials',
            client_id: oAuthSettings.clientId,
            client_secret: oAuthSettings.clientSecret,
            scope: oAuthSettings.scopes,
            resourceServer: oAuthSettings.resourceServer
        })
    };

    try {
        const response = await axios(config);
        return response.data.access_token
    }
    catch(e) {
        global.logger.error(e);
    }
}

async function createBearerAuthorizationHeader(afnemerId, gemeenteCode, oAuthSettings) {
    const oAuthClientSettings = oAuthSettings.clients.find(client => client.afnemerID === afnemerId && client.gemeenteCode === gemeenteCode);
    if(oAuthClientSettings === undefined) {
        global.logger.warn(`geen oAuthSettings gevonden voor afnemerId '${afnemerId}' en gemeenteCode: '${gemeenteCode}'`);
        return undefined;
    }

    const key = gemeenteCode === undefined
        ? afnemerId
        : `${afnemerId}-${gemeenteCode}`;

    if(global.accessToken === undefined) {
        global.accessToken = {};
    }
    if(global.accessToken[key] === undefined) {
        global.logger.debug('geen access token. Authenticate');
        global.accessToken[key] = await getOAuthAccessToken(oAuthSettings.accessTokenUrl, oAuthClientSettings);
    }

    return [
        {
            naam: 'Authorization',
            waarde: 'Bearer ' + global.accessToken[key]
        }
    ];
}

function createBasicAuthorizationHeader(afnemerId, gemeenteCode) {
    return [
        {
            naam: 'Authorization',
            waarde: 'Basic ' + Buffer.from(`${afnemerId}|${gemeenteCode}:tempsolution!`).toString('base64')
        }
    ]
}

function addDefaultAutorisatieSettings(context, afnemerID) {
    let sqlData = context.sqlData;
    if(sqlData === undefined) {
        sqlData = [{}];
    }
    
    const heeftAutorisatieSettings = sqlData.filter(s => s['autorisatie'] !== undefined).length > 0;
    if(!heeftAutorisatieSettings){
        let data = sqlData.at(-1);
        data['autorisatie'] = createGegevensgroepAutorisatie(context, afnemerID, undefined);
    }
}

async function sendRequest(config) {
    try {
        return await axios(config);
    }
    catch(e) {
        e.code.should.not.equal('ECONNREFUSED', `${e.config.baseURL}${e.config.url} returns ${e.code}`);
        e.code.should.not.equal('ECONNRESET', `${e.config.baseURL}${e.config.url} returns ${e.code}`);
        return e.response;
    }
}

async function sendBevragenRequest(baseUrl, url, extraHeaders, dataTable, httpMethod) {
    const config = {
        method: httpMethod,
        url: url ? `/${url}` : '',
        baseURL: baseUrl,
        data: createRequestBody(dataTable, baseUrl),
        headers: createHeaders(dataTable, extraHeaders)
    };

    global.logger.debug(config);

    return await sendRequest(config);
}

async function handleRequest(context, endpoint, dataTable, httpMethod='post') {
    const afnemerId = context.afnemerID;
    const gemeenteCode = context.gemeenteCode;
    const url = context.baseUrl;

    const authzHeader = context.oAuth.enable
        ? await createBearerAuthorizationHeader(afnemerId, gemeenteCode, context.oAuth)
        : createBasicAuthorizationHeader(afnemerId, gemeenteCode);
    if(authzHeader === undefined) {
        return;
    }

    context.response = await sendBevragenRequest(url, endpoint, authzHeader, dataTable, httpMethod);
}

module.exports = {
    addDefaultAutorisatieSettings,
    handleRequest
}
