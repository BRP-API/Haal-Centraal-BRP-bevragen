const { When } = require('@cucumber/cucumber');
const fs = require('fs');
const { executeSqlStatements } = require('./postgresqlHelpers');
const { execute } = require('./postgresqlHelpers-2');
const { generateSqlStatementsFrom } = require('./sqlStatementsFactory');
const { arrayOfArraysToDataTable } = require('./dataTableFactory');

const { addDefaultAutorisatieSettings,
        handleRequest } = require('./requestHelpers');

When(/^([a-zA-Z-]*) wordt gezocht met de volgende parameters$/, async function (endpoint, dataTable) {
    if(this.context.afnemerID === undefined) {
        this.context.afnemerID = this.context.oAuth.clients[0].afnemerID;
        this.context.gemeenteCode = this.context.oAuth.clients[0].gemeenteCode;
    }

    if(this.context.gezag !== undefined) {
        fs.writeFileSync(this.context.gezagDataPath, JSON.stringify(this.context.gezag, null, '\t'));
    }
    if(this.context.downstreamApiResponseHeaders !== undefined) {
        fs.writeFileSync(this.context.downstreamApiDataPath + '/response-headers.json',
                         JSON.stringify(this.context.downstreamApiResponseHeaders[0], null, '\t'));
    }
    if(this.context.downstreamApiResponseBody !== undefined) {
        fs.writeFileSync(this.context.downstreamApiDataPath + '/response-body.json',
                         this.context.downstreamApiResponseBody);
    }

    if(this.context.sqlData === undefined) {
        this.context.sqlData = [{}];
    }
    addDefaultAutorisatieSettings(this.context, this.context.afnemerID);

    if(this.context.data) {
        await execute(generateSqlStatementsFrom(this.context.data));
    }
    else {
        await executeSqlStatements(this.context.sql, this.context.sqlData, global.pool);
    }

    const relativeUrl = this.context.apiEndpointPrefixMap.has(endpoint)
        ? `${this.context.apiEndpointPrefixMap.get(endpoint)}/${endpoint}`
        : '';

    await handleRequest(this.context, relativeUrl, dataTable);
});

When(/^([a-zA-Z-]*) wordt gezocht met een '(\w*)' aanroep$/, async function (endpoint, httpMethod) {
    if(this.context.afnemerID === undefined) {
        this.context.afnemerID = this.context.oAuth.clients[0].afnemerID;
    }

    const relativeUrl = this.context.apiEndpointPrefixMap.has(endpoint)
        ? `${this.context.apiEndpointPrefixMap.get(endpoint)}/${endpoint}`
        : '';

    await handleRequest(this.context, relativeUrl, undefined, httpMethod);
});

When(/^gezag wordt gevraagd van '(.*)'$/, async function (aanduiding) {
    if(this.context.afnemerID === undefined) {
        this.context.afnemerID = this.context.oAuth.clients[0].afnemerID;
        this.context.gemeenteCode = this.context.oAuth.clients[0].gemeenteCode;
    }

    if(this.context.gezag !== undefined) {
        fs.writeFileSync(this.context.gezagDataPath, JSON.stringify(this.context.gezag, null, '\t'));
    }
    if(this.context.downstreamApiResponseHeaders !== undefined) {
        fs.writeFileSync(this.context.downstreamApiDataPath + '/response-headers.json',
                         JSON.stringify(this.context.downstreamApiResponseHeaders[0], null, '\t'));
    }
    if(this.context.downstreamApiResponseBody !== undefined) {
        fs.writeFileSync(this.context.downstreamApiDataPath + '/response-body.json',
                         this.context.downstreamApiResponseBody);
    }

    if(this.context.sqlData === undefined) {
        this.context.sqlData = [{}];
    }
    addDefaultAutorisatieSettings(this.context, this.context.afnemerID);

    if(this.context.data) {
        await execute(generateSqlStatementsFrom(this.context.data));
    }
    else {
        await executeSqlStatements(this.context.sql, this.context.sqlData, global.pool);
    }

    const aanduidingen = aanduiding.split(',');
    let bsns = [];
    
    aanduidingen.forEach(a => {
        let burger_service_nr = this.context.data.personen.find(p => p.id === `persoon-${a}`).persoon.at(-1).burger_service_nr;
        bsns.push(burger_service_nr);
    });

    const bsnString = bsns.filter(Boolean).join(",");
    
    const data = [
        ["type", "RaadpleegMetBurgerservicenummer"],
        ["burgerservicenummer", bsnString],
        ["fields", "gezag"]
    ];

    const relativeUrl = this.context.apiEndpointPrefixMap.has("personen")
    ? `${this.context.apiEndpointPrefixMap.get("personen")}/personen`
    : '';

    const dataTable = arrayOfArraysToDataTable(data);

    await handleRequest(this.context, relativeUrl, dataTable);
})