const { When } = require('@cucumber/cucumber');
const fs = require('fs');
const { executeSqlStatements } = require('./postgresqlHelpers');
const { addDefaultAutorisatieSettings,
        handleRequest } = require('./requestHelpers');

When(/^([a-zA-Z-]*) wordt gezocht met de volgende parameters$/, async function (endpoint, dataTable) {
    if(this.context.afnemerID === undefined) {
        this.context.afnemerID = this.context.oAuth.clients[0].afnemerID;
    }

    if(this.context.gezag !== undefined) {
        fs.writeFileSync(this.context.gezagDataPath, JSON.stringify(this.context.gezag, null, '\t'));
    }

    if(this.context.sqlData === undefined) {
        this.context.sqlData = [{}];
    }
    addDefaultAutorisatieSettings(this.context, this.context.afnemerID);

    await executeSqlStatements(this.context.sql, this.context.sqlData, global.pool);

    await handleRequest(this.context, endpoint, dataTable);
});

When(/^([a-zA-Z-]*) wordt gezocht met een '(\w*)' aanroep$/, async function (endpoint, httpMethod) {
    if(this.context.afnemerID === undefined) {
        this.context.afnemerID = this.context.oAuth.clients[0].afnemerID;
    }

    await handleRequest(this.context, endpoint, undefined, httpMethod);
});
