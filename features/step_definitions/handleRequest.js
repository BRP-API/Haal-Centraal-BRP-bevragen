const axios = require('axios');
const { createRequestBody } = require('./gba.js');

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

async function postBevragenRequestWithBasicAuth(baseUrl, extraHeaders, dataTable) {
    const config = {
        method: 'post',
        url: '/personen',
        baseURL: baseUrl,
        data: createRequestBody(dataTable),
        headers: createHeaders(dataTable, extraHeaders)
    };

    try {
        return await axios(config);
    }
    catch(e) {
        e.code.should.not.equal('ECONNREFUSED', `${e.config.baseURL}${e.config.url} returns ${e.code}`);
        e.code.should.not.equal('ECONNRESET', `${e.config.baseURL}${e.config.url} returns ${e.code}`);
        return e.response;
    }
}

async function handleOAuthRequest(accessToken, oAuth, afnemerId, endpointUrl, dataTable) {
    const accessTokenUrl = oAuth.accessTokenUrl;
    const oAuthSettings = afnemerId === undefined
        ? oAuth.clients[0]
        : oAuth.clients.find(client => client.afnemerID === afnemerId);

    if(oAuthSettings === undefined) {
        console.log(`geen oAuthSettings gevonden voor afnemerId '${afnemerId}'`);
        return undefined;
    }

    if(accessToken === undefined) {
        console.log("no access token. authenticate");
        accessToken = await getOAuthAccessToken(accessTokenUrl, oAuthSettings);
    }

    const requestBody = createRequestBody(dataTable);
    let response = await postBevragenRequestWithOAuth(endpointUrl, accessToken, dataTable, 'post', requestBody);
    if(response.status === 401) {
        console.log("access denied. access token expired");
        accessToken = await getOAuthAccessToken(accessTokenUrl, oAuthSettings);
        response = await postBevragenRequestWithOAuth(endpointUrl, accessToken, dataTable, 'post', requestBody);
    }

    return { response: response, accessToken: accessToken};
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
        console.log(e);
    }
}

async function postBevragenRequestWithOAuth(baseUrl, access_token, dataTable, method, body) {
    const config = {
        method: method,
        url: '/personen',
        baseURL: baseUrl,
        data: body,
        headers: createHeaders(dataTable, [
            {
                naam: 'Authorization',
                waarde: 'Bearer ' + access_token
            }
        ])
    };

    try {
        return await axios(config);
    }
    catch(e) {
        e.code.should.not.equal('ECONNREFUSED', `${e.config.baseURL}${e.config.url} returns ${e.code}`);
        e.code.should.not.equal('ECONNRESET', `${e.config.baseURL}${e.config.url} returns ${e.code}`);
        return e.response;
    }
}

module.exports = { postBevragenRequestWithBasicAuth, handleOAuthRequest }
