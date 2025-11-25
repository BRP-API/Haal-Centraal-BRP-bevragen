const { World } = require('./world');
const { Pool } = require('pg');
const { setWorldConstructor, setDefaultTimeout, Before, After, AfterAll, AfterStep } = require('@cucumber/cucumber');
const { valideer200Response, valideerProblemDetailsResponse } = require('./responseHelpers');
const { rollbackSqlStatements } = require('./postgresqlHelpers');
const { rollback } = require('./postgresqlHelpers-2');
const fs = require('node:fs');

setWorldConstructor(World);

// https://github.com/cucumber/cucumber-js/blob/main/docs/support_files/timeouts.md
setDefaultTimeout(30000);

function persoonAanduidingenVerwijderen(personen) {
    if(personen) {
        for (const persoon of personen) {
            delete persoon.id;
        }
    }
}

After({tags: 'not @fout-case'}, function({ pickle }) {
    // tijdelijk in dan stap toegevoegde persoon aanduiding verwijderen
    persoonAanduidingenVerwijderen(this.context.expected?.personen);

    valideer200Response(this.context, !pickle.tags.map((t) => t.name).includes('@valideer-volgorde'));
});

After({tags: '@fout-case'}, function() {
    valideerProblemDetailsResponse(this.context);
});

AfterAll(async function() {
    if(globalThis.pool === undefined) {
        return;
    }

    globalThis.logger.debug(`end pool. Counts => total: ${globalThis.pool.totalCount}, idle: ${globalThis.pool.idleCount}, waiting: ${globalThis.pool.waitingCount}`);
    await globalThis.pool.end();
    globalThis.logger.debug(`pool ended. Counts => total: ${globalThis.pool.totalCount}, idle: ${globalThis.pool.idleCount}, waiting: ${globalThis.pool.waitingCount}`);
});

Before(function({ pickle }) {
    globalThis.scenario = {
        name: pickle.name,
        tags: pickle.tags.map((t) => t.name)
    };

    if(globalThis.logger === undefined) {
        globalThis.logger = this.context.logger;
        globalThis.logger.debug('set global logger');
    }

    if(globalThis.pool === undefined) {
        globalThis.logger.debug('create db pool');
        globalThis.pool = new Pool(this.context.sql.poolConfig);
    }

    if(this.context.logFileToAssert !== undefined && fs.existsSync(this.context.logFileToAssert)) {
        const array = fs.readFileSync(this.context.logFileToAssert).toString().split("\n");
        this.context.nrOfLogLines = array.length;
    }

    this.context.baseUrl = this.context.apiUrl;

    const tags = pickle.tags.map((t) => t.name);
    this.context.isStapDocumentatieScenario = tags.includes('@stap-documentatie');
    this.context.isIntegratieScenario = tags.includes('@integratie');
    this.context.isDeprecatedScenario = tags.includes('@deprecated') || this.context.parameters.tagScenariosAsDeprecated ? this.context.parameters.tagScenariosAsDeprecated : false;
    this.context.isAllApiScenario = !tags.includes('@info-api') && !tags.includes('@data-api') && !tags.includes('@gezag-api');
    this.context.isInfoApiScenario = tags.includes('@info-api');
    this.context.isDataApiScenario = tags.includes('@data-api');
    this.context.isGezagApiScenario = tags.includes('@gezag-api');
    this.context.isAllApiAanroep = this.context.parameters.api !== 'info-api' && this.context.parameters.api !== 'data-api' && this.context.parameters.api !== 'gezag-api';
    this.context.isInfoApiAanroep = this.context.parameters.api === 'info-api';
    this.context.isDataApiAanroep = this.context.parameters.api === 'data-api';
    this.context.isGezagApiAanroep = this.context.parameters.api === 'gezag-api';

    globalThis.logger.info(`scenario '${pickle.name}' met tags ${JSON.stringify(tags)} (deprecated: ${this.context.isDeprecatedScenario})`);
});

AfterStep(function({ pickleStep }) {
    switch(pickleStep.type) {
        case 'Context':
        case 'Unknown':
            globalThis.logger.info(`Gegeven ${pickleStep.text}`, this.context.data);
            break;
        case 'Action':
            globalThis.logger.info(`Als ${pickleStep.text}`, {
                headers: this.context.response?.headers,
                body: this.context.response?.data
            });
            break;
        case 'Outcome':
            globalThis.logger.info(`Dan ${pickleStep.text}`, this.context.expected);
            break;
        default:
            globalThis.logger.info(`Unsupported type ${pickleStep.type}`);
            break;
    }
});

After(async function() {
    if (this.context.isStapDocumentatieScenario &&
        !this.context.isIntegratieScenario) {
        return;
    }

    await rollbackDbChanges(this.context, globalThis.pool);

    rollbackTempfiles(this.context);

    await assertExpectedLogLines(this.context, globalThis.logger, globalThis.scenario);
});

async function rollbackDbChanges(context, pool) {
    if (context.data) {
        await rollback(context.sql, context.data);
    }
    else {
        await rollbackSqlStatements(context.sql, context.sqlData, pool);
    }
}

function rollbackTempfiles(context) {
    if(context.gezag !== undefined) {
        fs.writeFileSync(context.gezagDataPath, JSON.stringify([], null, '\t'));
    }
    if(context.downstreamApiResponseHeaders !== undefined){
        fs.writeFileSync(context.downstreamApiDataPath + '/response-headers.json', JSON.stringify({}, null, '\t'));
    }
    if(context.downstreamApiResponseBody !== undefined){
        fs.rmSync(context.downstreamApiDataPath + '/response-body.json');
    }
}

async function assertExpectedLogLines(context, logger, scenario) {
    if(context.logFileToAssert !== undefined && fs.existsSync(context.logFileToAssert)) {
        let array = fs.readFileSync(context.logFileToAssert).toString().split("\n");
        if(context.nrOfLogLines + 1 != array.length) {
            // wacht 50 ms en check vervolgens nog een keer of er een log regel is toegevoegd
            await sleep(50);
            array = fs.readFileSync(context.logFileToAssert).toString().split("\n");
            if(context.nrOfLogLines + 1 !== array.length) {
                logger.warn(`${scenario.name}. nr of loglines ${array.length} should be ${context.nrOfLogLines + 1}`);
            }
        }
    }
}

function sleep(ms) {
    return new Promise((resolve) => setTimeout(resolve, ms));
}
