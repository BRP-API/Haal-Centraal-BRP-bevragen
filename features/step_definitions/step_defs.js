const { World } = require('./world');
const { createCollectieDataFromArray, createArrayFrom, createVoorkomenDataFromArray } = require('./dataTable2Array.js');
const { createObjectFrom, mapRowToProperty } = require('./dataTable2Object.js');
const { stringifyValues } = require('./stringify.js');
const { postBevragenRequestWithBasicAuth, handleOAuthRequest } = require('./handleRequest.js');
const { Pool } = require('pg');
const { noSqlData, executeSqlStatements, rollbackSqlStatements, insertIntoPersoonlijstStatement, insertIntoAdresStatement, insertIntoStatement } = require('./postgresqlHelpers.js');
const { Given, When, Then, setWorldConstructor, Before, After, setDefaultTimeout } = require('@cucumber/cucumber');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();
const { tableNameMap, columnNameMap, createAutorisatieSettingsFor, createRequestBody, createBasicAuthorizationHeader, createAdresseringBinnenlandAutorisatieSettingsFor, createVerblijfplaatsBinnenlandAutorisatieSettingsFor } = require('./gba.js');
const fs = require('fs');

setWorldConstructor(World);

// https://github.com/cucumber/cucumber-js/blob/main/docs/support_files/timeouts.md
setDefaultTimeout(30000);

let pool = undefined;
let logSqlStatements = false;
let accessToken = undefined;

Given(/^landelijke tabel "([\w\-]*)" heeft de volgende waarden$/, function (_tabelNaam, _dataTable) {
    // doe nog niets
});

Given(/^(?:de|een) persoon met burgerservicenummer '(\d*)' heeft de volgende gegevens$/, function (burgerservicenummer, dataTable) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [];
    }
    this.context.sqlData.push({});

    let sqlData = this.context.sqlData.at(-1);

    sqlData["inschrijving"] = [[[ 'geheim_ind', '0' ]]];
    sqlData["persoon"] = [
        createCollectieDataFromArray("persoon", [
            ['burger_service_nr', burgerservicenummer]
        ]).concat(createArrayFrom(dataTable, columnNameMap))
    ];
});

function createPersoonMetGegevensgroep(burgerservicenummer, gegevensgroep, dataTable) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [];
    }
    this.context.sqlData.push({});

    let sqlData = this.context.sqlData.at(-1);

    sqlData["persoon"] = [
        createCollectieDataFromArray("persoon", [
            ['burger_service_nr', burgerservicenummer]
        ])
    ];
    if(gegevensgroep !== 'inschrijving') {
        if(gegevensgroep === 'kiesrecht') {
            sqlData["inschrijving"] = [
                [
                    [ 'geheim_ind', '0' ]
                ].concat(createArrayFrom(dataTable, columnNameMap))
            ];
        }
        else {
            sqlData["inschrijving"] = [[[ 'geheim_ind', '0' ]]];
            sqlData[gegevensgroep] = [
                [
                    [ 'volg_nr', '0']
                ].concat(createArrayFrom(dataTable, columnNameMap))
            ];
        }
    }
    else {
        sqlData[gegevensgroep] = [ createArrayFrom(dataTable, columnNameMap) ];
    }
}

Given(/^de persoon met burgerservicenummer '(\d*)' heeft de volgende '(\w*)' gegevens$/, createPersoonMetGegevensgroep);

Given(/^de persoon met burgerservicenummer '(\d*)' heeft een '(\w*)' verkregen met de volgende gegevens$/, createPersoonMetGegevensgroep);

Given(/^de persoon met burgerservicenummer '(\d*)' heeft een '(\w*)' met de volgende gegevens$/, async function (burgerservicenummer, collectieGegevensgroep, dataTable) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [];
    }
    this.context.sqlData.push({});

    let sqlData = this.context.sqlData.at(-1);

    sqlData["inschrijving"] = [[[ 'geheim_ind', '0' ]]];
    sqlData["persoon"] = [
        createCollectieDataFromArray("persoon", [
            ['burger_service_nr', burgerservicenummer]
        ])
    ];
    sqlData[`${collectieGegevensgroep}-${getNextStapelNr(sqlData, collectieGegevensgroep)}`] = [
        createCollectieDataFromArray(collectieGegevensgroep, createArrayFrom(dataTable, columnNameMap))
    ];
});

Given(/^de persoon heeft ?(?:nog)? een '?(?:ex-)?(\w*)' met ?(?:alleen)? de volgende gegevens$/, async function (relatie, dataTable) {
    let sqlData = this.context.sqlData.at(-1);

    const stapelNr = getNextStapelNr(sqlData, relatie);
    sqlData[`${relatie}-${stapelNr}`] = [
        createCollectieDataFromArray(relatie, createArrayFrom(dataTable, columnNameMap), stapelNr-1)
    ];
});

Given(/^de persoon heeft de volgende '(\w*)' gegevens$/, async function (gegevensgroep, dataTable) {
    let sqlData = this.context.sqlData.at(-1);

    sqlData[gegevensgroep] = [
        gegevensgroep === 'inschrijving'
            ? createArrayFrom(dataTable, columnNameMap)
            : createVoorkomenDataFromArray(createArrayFrom(dataTable, columnNameMap)) 

    ];
});

Given(/^de afnemer met indicatie '(.*)' heeft de volgende '(.*)' gegevens$/, function (afnemerCode, tabelNaam, dataTable) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [];
    }
    this.context.sqlData.push({});

    let sqlData = this.context.sqlData.at(-1);

    sqlData[tabelNaam] = [
        [
            [ 'afnemer_code', afnemerCode ],
            ['geheimhouding_ind', 0],
            ['verstrekkings_beperking', 0]
        ].concat(createArrayFrom(dataTable, columnNameMap))];
});

Given(/^de afnemer met indicatie '(.*)' is geautoriseerd voor '(.*)' gegevens$/, function (afnemerId, scope) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [];
    }
    this.context.sqlData.push({});

    let sqlData = this.context.sqlData.at(-1);

    if(['adressering binnenland'].includes(scope)) {
        sqlData['autorisatie'] = createAdresseringBinnenlandAutorisatieSettingsFor(afnemerId);
        this.context.afnemerId = afnemerId;
    }
    else if(['verblijfplaats binnenland'].includes(scope)) {
        sqlData['autorisatie'] = createVerblijfplaatsBinnenlandAutorisatieSettingsFor(afnemerId);
        this.context.afnemerId = afnemerId;
    }
});

Given(/^de geauthenticeerde consumer heeft de volgende '(.*)' gegevens$/, function (_, dataTable) {
    const afnemerId = dataTable.hashes().find(param => param.naam === 'afnemerID');
    this.context.afnemerId = afnemerId.waarde;

    const gemeenteCode = dataTable.hashes().find(param => param.naam === 'gemeenteCode');
    if(gemeenteCode !== undefined) {
        this.context.gemeenteCode = gemeenteCode.waarde;
    }
});

Given(/^(?:de|het) '?(?:ex-)?(\w*)' heeft ?(?:alleen)? de volgende '(\w*)' gegevens$/, function (relatie, gegevensgroep, dataTable) {
    let sqlData = this.context.sqlData.at(-1);

    sqlData[`${gegevensgroep}`] = [
        createArrayFrom(dataTable, columnNameMap)
    ];
});

Given(/^de persoon is gewijzigd naar de volgende gegevens$/, function (dataTable) {
    let sqlData = this.context.sqlData.at(-1);

    sqlData['persoon'].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });
    sqlData['persoon'].push(createCollectieDataFromArray('persoon', createArrayFrom(dataTable, columnNameMap)));
});

Given(/^de persoon is gecorrigeerd naar de volgende gegevens$/, function (dataTable) {
    let sqlData = this.context.sqlData.at(-1);

    sqlData['persoon'].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        if(volgNr[1] === '0') {
            data.push(['onjuist_ind','O']);
        }
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });
    sqlData['persoon'].push(createCollectieDataFromArray('persoon', createArrayFrom(dataTable, columnNameMap)));
});

function wijzigRelatie(relatie, dataTable) {
    let sqlData = this.context.sqlData.at(-1);

    const foundRelatie = Object.keys(sqlData).findLast(key => key.startsWith(relatie));

    const stapelNr = sqlData[foundRelatie][0].find(el => el[0] === 'stapel_nr');

    sqlData[foundRelatie].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });

    if(stapelNr !== undefined) {
        sqlData[foundRelatie].push(createCollectieDataFromArray(relatie, createArrayFrom(dataTable, columnNameMap), stapelNr[1]));
    }
    else {
        sqlData[foundRelatie].push(createVoorkomenDataFromArray(createArrayFrom(dataTable, columnNameMap)));
    }
}

Given(/^(?:de|het) '(.*)' is gewijzigd naar de volgende gegevens$/, wijzigRelatie);

Given(/^de persoon heeft een '(\w*)' verkregen met de volgende gegevens$/, wijzigRelatie);

Given(/^(?:de|het) '(.*)' is gecorrigeerd naar de volgende gegevens$/, async function (relatie, dataTable) {
    let sqlData = this.context.sqlData.at(-1);

    const foundRelatie = Object.keys(sqlData).findLast(key => key.startsWith(relatie));

    const stapelNr = sqlData[foundRelatie][0].find(el => el[0] === 'stapel_nr');

    sqlData[foundRelatie].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        if(volgNr[1] === '0') {
            data.push(['onjuist_ind','O']);
        }
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });

    if(stapelNr !== undefined){
        sqlData[foundRelatie].push(createCollectieDataFromArray(relatie, createArrayFrom(dataTable, columnNameMap), stapelNr[1]));
    }
    else {
        sqlData[foundRelatie].push(createVoorkomenDataFromArray(createArrayFrom(dataTable, columnNameMap)));
    }
});

async function createPersoonMetOuder(burgerservicenummer, ouderType, dataTable) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [];
    }
    this.context.sqlData.push({});

    let sqlData = this.context.sqlData.at(-1);

    sqlData["inschrijving"] = [[[ 'geheim_ind', '0' ]]];
    sqlData["persoon"] = [
        createCollectieDataFromArray("persoon", [
            ['burger_service_nr', burgerservicenummer]
        ])
    ];
    sqlData[`ouder-${ouderType}`] = [
        createCollectieDataFromArray(ouderType, createArrayFrom(dataTable, columnNameMap))
    ];
}

Given(/^de persoon met burgerservicenummer '(\d*)' heeft een ouder '(\d)' met de volgende gegevens$/, createPersoonMetOuder);

async function createOuder(ouderType, dataTable) {
    let sqlData = this.context.sqlData.at(-1);

    sqlData[`ouder-${ouderType}`] = [
        createCollectieDataFromArray(ouderType, createArrayFrom(dataTable, columnNameMap))
    ];
}

Given(/^de persoon heeft een ouder '(\d)' met de volgende gegevens$/, createOuder);

async function corrigeerOuder(ouderType, dataTable) {
    let sqlData = this.context.sqlData.at(-1);

    sqlData[`ouder-${ouderType}`].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        if(volgNr[1] === '0') {
            data.push(['onjuist_ind','O']);
        }
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });
    sqlData[`ouder-${ouderType}`].push(createCollectieDataFromArray(ouderType, createArrayFrom(dataTable, columnNameMap)));
}

Given(/^de ouder '(\d)' is gecorrigeerd naar de volgende gegevens$/, corrigeerOuder);

function wijzigOuder(ouderType, dataTable) {
    let sqlData = this.context.sqlData.at(-1);

    sqlData[`ouder-${ouderType}`].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });
    sqlData[`ouder-${ouderType}`].push(createCollectieDataFromArray(ouderType, createArrayFrom(dataTable, columnNameMap)));
}

Given(/^de ouder '(\d)' is gewijzigd naar de volgende gegevens$/, wijzigOuder);

Given(/^een adres heeft de volgende gegevens$/, function (dataTable) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [];
    }
    this.context.sqlData.push({});

    let sqlData = this.context.sqlData.at(-1);

    sqlData['adres'] = [
        createArrayFrom(dataTable, columnNameMap)
    ];
});

Given(/^de persoon met burgerservicenummer '(\d*)' is ingeschreven op het adres met de volgende gegevens$/, function (burgerservicenummer, dataTable) {
    this.context.sqlData.push({});

    let sqlData = this.context.sqlData.at(-1);

    sqlData['persoon'] = [
        createCollectieDataFromArray('persoon', [
            ['burger_service_nr', burgerservicenummer]
        ])
    ];

    sqlData['inschrijving'] = [[[ 'geheim_ind', '0' ]]];

    sqlData['verblijfplaats'] = [
        [
            [ 'volg_nr', '0']
        ].concat(createArrayFrom(dataTable, columnNameMap)) ];
});

Given(/^de persoon is ingeschreven op het adres met de volgende gegevens$/, function (dataTable) {
    let sqlData = this.context.sqlData.at(-1);

    sqlData['inschrijving'] = [[[ 'geheim_ind', '0' ]]];

    sqlData['verblijfplaats'] = [
        [
            [ 'volg_nr', '0']
        ].concat(createArrayFrom(dataTable, columnNameMap)) ];
});

Given(/^de persoon heeft (?:GEEN|geen) '(.*)' gegevens$/, function (_) {
    // doe niets
});

Given('de persoon heeft nooit een actueel of ontbonden huwelijk of partnerschap gehad', function () {
    // doe niets
});

Given(/^de persoon heeft geen (?:actuele partner|\(ex\)partner)$/, function () {
    // doe niets
});

async function handleRequest(context, dataTable) {
    if(context.sqlData === undefined) {
        context.sqlData = [{}];
    }

    if(context.gezagDataPath !== undefined && context.gezag !== undefined) {
        fs.writeFileSync(context.gezagDataPath, JSON.stringify(context.gezag, null, '\t'));
    }

    const afnemerId = context.afnemerId ?? context.oAuth.clients[0].afnemerID;
    const gemeenteCode = context.gemeenteCode ?? "800";
    const url = context.proxyAanroep ? context.proxyUrl : context.apiUrl;

    const heeftAutorisatie = context.sqlData.filter(s => s['autorisatie'] !== undefined).length>0;
    if(! heeftAutorisatie){
        let sqlData = context.sqlData.at(-1);
        sqlData['autorisatie'] = createAutorisatieSettingsFor(afnemerId);
    }

    await executeSqlStatements(context.sqlData, pool, tableNameMap, logSqlStatements);

    if(context.oAuth.enable){
        const result = await handleOAuthRequest(accessToken, context.oAuth, afnemerId, url, dataTable);
        context.response = result.response;
        accessToken = result.accessToken;
    }
    else {
        context.response = await postBevragenRequestWithBasicAuth(url, createBasicAuthorizationHeader(afnemerId, gemeenteCode), dataTable);
    }
}

When(/^personen wordt gezocht met de volgende parameters$/, async function (dataTable) {
    this.context.proxyAanroep = true

    await handleRequest(this.context, dataTable)
});

When(/^gba personen wordt gezocht met de volgende parameters$/, async function (dataTable) {
    this.context.proxyAanroep = false;

    await handleRequest(this.context, dataTable)
});

Then(/^heeft de response ?(?:nog)? een persoon met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    const expected = createObjectFrom(dataTable, this.context.proxyAanroep);

    if(this.context.expected === undefined) {
        this.context.expected = [];
    }
    this.context.expected.push(expected);
});

Then(/^heeft de response een persoon met een '(kind|ouder|partner|nationaliteit|rni)' met ?(?:alleen)? de volgende gegevens$/, function(relatie, dataTable) {
    this.context.verifyResponse = true;

    const expected = createObjectFrom(dataTable, this.context.proxyAanroep);

    let relaties = toCollectionName(relatie);

    if(this.context.expected === undefined) {
        this.context.expected = [ {} ];
    }

    const expectedPersoon = this.context.expected[this.context.expected.length-1];
    if(expectedPersoon[relaties] === undefined) {
        expectedPersoon[relaties] = [];
    }
    expectedPersoon[relaties].push(expected);
});

Then(/^heeft de response een persoon met ?(?:alleen)? de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {
    this.context.verifyResponse = true;

    let expected = {};
    expected[gegevensgroep] = createObjectFrom(dataTable, this.context.proxyAanroep);

    if(this.context.expected === undefined) {
        this.context.expected = [];
    }
    this.context.expected.push(expected);
});

Then(/^heeft de response (\d*) (?:persoon|personen)$/, function (aantal) {
    this.context.response.status.should.equal(200, `response body: ${JSON.stringify(this.context.response.data, null, '\t')}`);

    const actual = this.context?.response?.data?.personen;

    should.exist(actual);
    actual.length.should.equal(Number(aantal), `aantal personen in response is ongelijk aan ${aantal}\nPersonen:${JSON.stringify(actual, null, "\t")}`);
});

Then(/^heeft de response een object met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    this.context.expected = createObjectFrom(dataTable, this.context.proxyAanroep);
});

Then(/^heeft het object de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {
    const expected = dataTable.hashes();

    this.context.expected[gegevensgroep] = expected;
});

function createEmptyPersoon() {
    this.context.verifyResponse = true;
    this.context.leaveEmptyObjects = true;

    if(this.context.expected === undefined) {
        this.context.expected = [ {} ];
    }
}

Then(/^heeft de response een leeg persoon object$/, createEmptyPersoon);

Then(/^heeft de response een persoon zonder gegevens$/, createEmptyPersoon);

Then(/^heeft de persoon met burgerservicenummer '(.*)' de volgende '(.*)' gegevens$/, async function (burgerservicenummer, tabelNaam, dataTable) {
    this.context.verifyResponse = false;
    const sqlData = dataTable.hashes()[0];

    const persoonSqlData = this.context.sqlData.find(s => s.persoon[0].find(a => a[0] == 'burger_service_nr' && a[1] == burgerservicenummer));
    should.exist(persoonSqlData);
    const pl_id = persoonSqlData.ids.pl_id;
    should.exist(pl_id);

    if (sqlData !== undefined && pool !== undefined) {
        let res;
        let client;
        try {
            let tableName = tableNameMap.get(tabelNaam);
            if(tableName === undefined) {
                tableName = tabelNaam;
            }
            const sql = `SELECT * FROM public.${tableName} WHERE pl_id=${pl_id} ORDER BY request_datum DESC LIMIT 1`;

            client = await pool.connect();
            res = await client.query(sql);
        }
        catch(ex) {
            console.log(ex);
        }
        finally {
            if(client !== undefined){
                client.release();
            }
        }

        should.exist(res);
        res.rows.length.should.equal(1, `Geen ${tabelNaam} gegevens gevonden voor persoon met burgerservicenummer ${burgerservicenummer}`);

        const actual = res.rows[0];
        Object.keys(sqlData).forEach(function(key) {
            actual[key].split(' ').should.have.members(sqlData[key].split(' '), `${actual[key]} !== ${sqlData[key]}`);
        });
    }
});

Then(/^heeft de persoon ?(?:alleen)? de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {
    const expected = createObjectFrom(dataTable, this.context.proxyAanroep);

    if(Object.keys(expected).length === 0) return;

    const personen = this.context.expected;
    should.exist(personen, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');
    personen.length.should.not.equal(0, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');

    let persoon = personen[personen.length-1];
    should.exist(persoon, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');

    persoon[gegevensgroep] = expected;
});

function toCollectionName(gegevensgroep) {
    switch(gegevensgroep) {
        case 'partner':
            return 'partners';
        case 'ouder':
            return 'ouders';
        case 'kind':
            return 'kinderen';
        case 'nationaliteit':
            return 'nationaliteiten';
        case 'rni':
            return 'rni';
        default:
            return undefined;
    }
}

Then(/^heeft de persoon ?(?:nog)? een '(kind|ouder|partner|nationaliteit|rni)' met ?(?:alleen)? de volgende gegevens$/, function (gegevensgroep, dataTable) {
    const expected = createObjectFrom(dataTable, this.context.proxyAanroep);

    let groep = toCollectionName(gegevensgroep);

    if(this.context.expected === undefined) {
        this.context.expected = [ {} ];
    }

    const expectedPersonen = this.context.expected;
    const expectedPersoon = expectedPersonen[expectedPersonen.length-1];
    if(expectedPersoon[groep] === undefined) {
        expectedPersoon[groep] = [];
    }
    expectedPersoon[groep].push(expected);
});

function createEmptyGegevensgroepOfEmptyGegevensgroepCollectie(relatie) {
    this.context.verifyResponse = true;
    this.context.leaveEmptyObjects = true;

    if(this.context.expected === undefined) {
        this.context.expected = [ {} ];
    }

    const expectedPersonen = this.context.expected;
    const expectedPersoon = expectedPersonen[expectedPersonen.length-1];

    const relaties = toCollectionName(relatie);
    if(relaties === undefined) {
        expectedPersoon[relatie] = {};
    }
    else {
        expectedPersoon[relaties] = [];
    }
}

Then(/^heeft de response een persoon zonder '(\w*)' gegevens$/, createEmptyGegevensgroepOfEmptyGegevensgroepCollectie);

Then(/^heeft de persoon (?:GEEN|geen) '(\w*)' gegevens$/, createEmptyGegevensgroepOfEmptyGegevensgroepCollectie);

Then(/^heeft de persoon een '(\w*)' zonder '(\w*)' gegevens$/, createEmptyGegevensgroepInGegevensgroepCollectie);

function createEmptyGegevensgroepInGegevensgroepCollectie(relatie, gegevensgroep) {
    this.context.verifyResponse = true;
    this.context.leaveEmptyObjects = true;

    let relaties = toCollectionName(relatie);

    if(this.context.expected === undefined) {
        this.context.expected = [ {} ];
    }

    const expectedPersoon = this.context.expected[this.context.expected.length-1];

    if(relaties === undefined) {
        if(expectedPersoon[relatie] === undefined) {
            expectedPersoon[relatie] = {};
        }
        const expectedRelatie = expectedPersoon[relatie];
        expectedRelatie[gegevensgroep] = {};
    }
    else {
        if(expectedPersoon[relaties] === undefined) {
            expectedPersoon[relaties] = [{}];
        }
    
        const expectedRelatie = expectedPersoon[relaties][expectedPersoon[relaties].length-1];
        expectedRelatie[gegevensgroep] = {};
        }
}

Then(/^heeft de response een persoon met een '(\w*)' met een leeg '(\w*)' object$/, createEmptyGegevensgroepInGegevensgroepCollectie);

Then(/^heeft de response een persoon met een '(\w*)' zonder '(\w*)' gegevens$/, createEmptyGegevensgroepInGegevensgroepCollectie);

Then(/^heeft (?:de|het) '(\w*)' geen '(\w*)' gegevens$/, createEmptyGegevensgroepInGegevensgroepCollectie);

function createEmptyObjectInGegevensgroepCollectie(gegevensgroep) {
    this.context.verifyResponse = true;
    this.context.leaveEmptyObjects = true;

    if(this.context.expected === undefined) {
        this.context.expected = [ {} ];
    }

    const expectedPersonen = this.context.expected;
    const expectedPersoon = expectedPersonen[expectedPersonen.length-1];

    const relaties = toCollectionName(gegevensgroep);
    if(relaties === undefined) {
        expectedPersoon[gegevensgroep] = {};
    }
    else {
        if(expectedPersoon[relaties] === undefined) {
            expectedPersoon[relaties] = [];
        }
        expectedPersoon[relaties].push({});
    }
}

Then(/^heeft de response een persoon met ?(?:een)? leeg '(.*)' object$/, createEmptyObjectInGegevensgroepCollectie);

Then(/^heeft de response een persoon met een '(\w*)' zonder gegevens$/, createEmptyObjectInGegevensgroepCollectie);

Then(/^heeft de persoon een '(\w*)' zonder gegevens$/, createEmptyObjectInGegevensgroepCollectie);

Then(/^heeft de persoon een leeg '(.*)' object$/, function(gegevensgroep) {
    this.context.leaveEmptyObjects = true;

    const expected = {};

    const personen = this.context.expected;
    should.exist(personen, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');
    personen.length.should.not.equal(0, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');

    let persoon = personen[personen.length-1];
    should.exist(persoon, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');

    persoon[gegevensgroep] = expected;
});

Then(/^heeft (?:de|het) '(.*)' een leeg '(.*)' object$/, function(relatie, gegevensgroep) {
    this.context.leaveEmptyObjects = true;

    const expected = {};

    if(this.context.expected === undefined) {
        console.log(`creeer eerst een '${relatie}' met "Dan heeft de persoon een '${relatie}' met alleen de volgende gegevens"`);
        return 'pending';
    }

    const expectedPersoon = this.context.expected[this.context.expected.length-1];

    const relaties = toCollectionName(relatie);
    let expectedRelatie = expectedPersoon[relaties][expectedPersoon[relaties].length-1];
    expectedRelatie[gegevensgroep] = expected;
});

function setPersoonProperties(persoon, propertyGroupName, dataTable) {
    if(persoon[propertyGroupName] === undefined) {
        persoon[propertyGroupName] = {};
    }

    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(persoon[propertyGroupName], row);
    });
}

function addRelatieToExpectedPersoon(relatie, gegevensgroep, dataTable) {
    this.context.verifyResponse = true;
    let expected = {};
    setPersoonProperties(expected, gegevensgroep, dataTable);

    let relaties = toCollectionName(relatie);

    if(this.context.expected === undefined) {
        this.context.expected = [ {} ];
    }

    const expectedPersoon = this.context.expected[this.context.expected.length-1];
    if(expectedPersoon[relaties] === undefined) {
        expectedPersoon[relaties] = [];
    }
    expectedPersoon[relaties].push(expected);
}

Then(/^heeft de response een persoon met een '(.*)' met ?(?:alleen)? de volgende '(.*)' gegevens$/, addRelatieToExpectedPersoon);

Then(/^heeft de persoon een '(.*)' met ?(?:alleen)? de volgende '(.*)' gegevens$/, addRelatieToExpectedPersoon);

Then(/^heeft (?:de|het) '(.*)' ?(?:alleen)? de volgende '(.*)' gegevens$/, function (relatie, gegevensgroep, dataTable) {
    const expected = createObjectFrom(dataTable, this.context.proxyAanroep);

    if(this.context.expected === undefined) {
        console.log(`creeer eerst een '${relatie}' met "Dan heeft de persoon een '${relatie}' met alleen de volgende gegevens"`);
        return 'pending';
    }

    const expectedPersoon = this.context.expected[this.context.expected.length-1];

    const relaties = toCollectionName(relatie);
    if(relaties !== undefined) {
        let expectedRelatie = expectedPersoon[relaties][expectedPersoon[relaties].length-1];
        expectedRelatie[gegevensgroep] = expected;
    }
    else {
        let expectedRelatie = expectedPersoon[relatie];
        expectedRelatie[gegevensgroep] = expected;
    }
});

After({tags: 'not @fout-case'}, async function() {
    if (this.context.verifyResponse === undefined ||
        !this.context.verifyResponse) {
        return;
    }

    this.context.response.status.should.equal(200, `response body: ${JSON.stringify(this.context.response.data, null, '\t')}`);

    const actual = this.context?.response?.data.personen !== undefined
        ? stringifyValues(this.context.response.data.personen)
        : [];
    const expected = this.context.expected !== undefined
        ? this.context.expected
        : [];

    actual.should.deep.equalInAnyOrder(expected, `actual: ${JSON.stringify(actual, null, '\t')}\nexpected: ${JSON.stringify(expected, null, '\t')}`);
});

After({tags: '@fout-case'}, async function() {
    this.context.response.status.should.not.equal(200, `response body: ${JSON.stringify(this.context.response.data, null, '\t')}`);

    const headers = this.context?.response?.headers;
    should.exist(headers, 'no response headers found');

    const header = headers["content-type"];
    should.exist(header, `no header found with name 'content-type'. Response headers: ${headers}`);
    header.should.contain('application/problem+json', "no 'content-type' header found with value: 'application/problem+json'");

    const actual = this.context?.response?.data !== undefined
        ? stringifyValues(this.context.response.data)
        : {};
    const expected = this.context.expected;

    actual.should.deep.equalInAnyOrder(expected, `actual: ${JSON.stringify(actual, null, '\t')}\nexpected: ${JSON.stringify(expected, null, '\t')}`);
});

Before(function() {
    if(this.context.sql.useDb && pool === undefined) {
        pool = new Pool(this.context.sql.poolConfig);
        logSqlStatements = this.context.sql.logStatements;
    }
});

After(async function() {
    if (pool === undefined ||
        !this.context.sql.cleanup ||
        noSqlData(this.context.sqlData)) {
        return;
    }

    await rollbackSqlStatements(this.context.sqlData, pool, tableNameMap, logSqlStatements);

    if(this.context.gezagDataPath !== undefined) {
        fs.writeFileSync(this.context.gezagDataPath, JSON.stringify([], null, '\t'));
    }
});

function getNextStapelNr(sqlData, relatie) {
    let stapelNr = 0;

    Object.keys(sqlData).forEach(function(key) {
        if(key.startsWith(relatie)){
            stapelNr = Number(key.replace(`${relatie}-`, ''));
        }
    });

    return stapelNr+1;
}

// dan stap definities scenarios stappen

Given(/^de (\d)e '(.*)' statement heeft als resultaat '(\d*)'$/, function (index, statement, result) {
    if(this.context.sqlDataIds == undefined) {
        this.context.sqlDataIds = [];
    }
    let ids = this.context.sqlDataIds;
    if(ids[index-1] === undefined) {
        ids[index-1] = {};
    }
    let id = ids[index-1];

    if(statement.includes('lo3_pl')) {
        id.pl_id = Number(result);
    }
    if(statement.includes('lo3_adres')) {
        id.adres_id = Number(result);
    }
});

Given(/^de response body is gelijk aan$/, function (docString) {
    this.context.response = {
        data: JSON.parse(docString)
    };
});

Given(/^de response headers is gelijk aan$/, function (dataTable) {
    if(this.context.response.headers === undefined) {
        this.context.response.headers = {};
    }
    let headers = this.context.response.headers;

    dataTable.hashes().forEach(function(row){
        headers[row.naam] = row.waarde;
    });
});

Given('de response status is gelijk aan {int}', function (int) {
    this.context.response.status = int;
});

function compareSqlStatements(expected, sqlData, plId, adresId) {
    for(const key of Object.keys(expected)) {
        const sqlDataItems = sqlData[key];
        should.exist(sqlDataItems, `geen data gevonden voor '${key}' om SQL statements te genereren`);

        expected[key].forEach(function(exp, index) {
            let actual = sqlDataItems[index];

            let statement;
            switch(key) {
                case 'inschrijving':
                    statement = insertIntoPersoonlijstStatement(actual);
                    break;
                case 'adres':
                    statement = insertIntoAdresStatement(actual);
                    break;
                case 'verblijfplaats':
                    statement = insertIntoStatement(key, [
                        ['pl_id', plId+''],
                        ['adres_id', adresId+'']
                    ].concat(actual), tableNameMap);
                    break;
                default:
                    const name = key.replace(/-\d$/, "");
                    statement = insertIntoStatement(name, [
                        ['pl_id', plId+'']
                    ].concat(actual), tableNameMap);
            }

            statement.text.should.equal(exp.text);
            statement.values.should.deep.equalInAnyOrder(exp.values.split(','), `${key}: ${statement.values} != ${exp.values}`);
        });
    }
}

Then(/^zijn de gegenereerde SQL statements$/, function(dataTable) {
    let expected = [{}];
    let lastKey;
    let index = 0;

    dataTable.hashes().forEach(function(hash) {
        if(hash.index !== undefined) {
            if(hash.index !== '') {
                index = Number(hash.index)-1;
                expected[index] = {};
            }
        }

        let exp = expected[index];
        if(hash.key !== '') {
            exp[hash.key] = [ hash ];
            lastKey = hash.key;
        }
        else {
            exp[lastKey].push(hash);
        }
    });

    const sqlData = this.context.sqlData.at(index);
    const plId = this.context.sqlDataIds.at(index).pl_id;
    let adresId = this.context.sqlDataIds.at(index).adres_id;
    if(adresId === undefined) {
        adresId = this.context.sqlDataIds.at(0).adres_id;
    }

    compareSqlStatements(expected[index], sqlData, plId, adresId);
});
