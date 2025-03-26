const { World } = require('./world');
const { Pool } = require('pg');
const { setWorldConstructor, setDefaultTimeout, Before, After, AfterAll } = require('@cucumber/cucumber');
const { valideer200Response, valideerProblemDetailsResponse } = require('./responseHelpers');
const { rollbackSqlStatements } = require('./postgresqlHelpers');
const { rollback } = require('./postgresqlHelpers-2');
const fs = require('fs');

setWorldConstructor(World);

// https://github.com/cucumber/cucumber-js/blob/main/docs/support_files/timeouts.md
setDefaultTimeout(30000);

After({tags: 'not @fout-case'}, function({ pickle }) {
    valideer200Response(this.context, !pickle.tags.map((t) => t.name).includes('@valideer-volgorde'));
});

After({tags: '@fout-case'}, function() {
    valideerProblemDetailsResponse(this.context);
});

AfterAll(async function() {
    if(global.pool === undefined) {
        return;
    }

    global.logger.debug(`end pool. Counts => total: ${global.pool.totalCount}, idle: ${global.pool.idleCount}, waiting: ${global.pool.waitingCount}`);
    await global.pool.end();
    global.logger.debug(`pool ended. Counts => total: ${global.pool.totalCount}, idle: ${global.pool.idleCount}, waiting: ${global.pool.waitingCount}`);
});

Before(function({ pickle }) {
    global.scenario = {
        name: pickle.name,
        tags: pickle.tags.map((t) => t.name)
    };

    if(global.logger === undefined) {
        global.logger = this.context.logger;
        global.logger.debug('set global logger');
    }

    if(global.pool === undefined) {
        global.logger.debug('create db pool');
        global.pool = new Pool(this.context.sql.poolConfig);
    }

    if(this.context.logFileToAssert !== undefined && fs.existsSync(this.context.logFileToAssert)) {
        const array = fs.readFileSync(this.context.logFileToAssert).toString().split("\n");
        this.context.nrOfLogLines = array.length;
    }

    this.context.baseUrl = this.context.apiUrl;

    const tags = pickle.tags.map((t) => t.name);
    this.context.isStapDocumentatieScenario = tags.includes('@stap-documentatie');
    this.context.isIntegratieScenario = tags.includes('@integratie');
    this.context.isDeprecatedScenario = tags.includes('@deprecated');
    this.context.isDataApiScenario = tags.includes('@data-api');
});

After(async function() {
    if (this.context.isStapDocumentatieScenario &&
        !this.context.isIntegratieScenario) {
        return;
    }
    if(this.context.data) {
        await rollback(this.context.sql, this.context.sqlData);
    }
    else {
        await rollbackSqlStatements(this.context.sql, this.context.sqlData, global.pool);
    }

    if(this.context.gezag !== undefined) {
        fs.writeFileSync(this.context.gezagDataPath, JSON.stringify([], null, '\t'));
    }
    if(this.context.downstreamApiResponseHeaders !== undefined){
        fs.writeFileSync(this.context.downstreamApiDataPath + '/response-headers.json', JSON.stringify({}, null, '\t'));
    }
    if(this.context.downstreamApiResponseBody !== undefined){
        fs.rmSync(this.context.downstreamApiDataPath + '/response-body.json');
    }

    if(this.context.logFileToAssert !== undefined && fs.existsSync(this.context.logFileToAssert)) {
        let array = fs.readFileSync(this.context.logFileToAssert).toString().split("\n");
        if(this.context.nrOfLogLines + 1 != array.length) {
            // wacht 50 ms en check vervolgens nog een keer of er een log regel is toegevoegd
            await sleep(50);
            array = fs.readFileSync(this.context.logFileToAssert).toString().split("\n");
            if(this.context.nrOfLogLines + 1 !== array.length) {
                global.logger.warn(`${global.scenario.name}. nr of loglines ${array.length} should be ${this.context.nrOfLogLines + 1}`);
            }
        }
    }
});

function sleep(ms) {
    return new Promise((resolve) => setTimeout(resolve, ms));
}
