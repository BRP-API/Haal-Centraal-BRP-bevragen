const { Given, When, Then } = require('@cucumber/cucumber');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();
const { insertIntoAdresStatement,
        insertIntoAutorisatieStatement,
        insertIntoGemeenteStatement,
        insertIntoPersoonlijstStatement,
        insertIntoStatement } = require('./parameterizedSqlStatementFactory');
const { stringifyValues } = require('./stringify');
const { queryRowCount, queryLastRow, executeSqlStatements } = require('./postgresqlHelpers');

Given(/^de (\d)e '(.*)' statement heeft als resultaat '(\d*)'$/, function (index, statement, result) {
    if(this.context.sqlDataIds == undefined) {
        this.context.sqlDataIds = {
            adresIds: [],
            plIds:[]
        };
    }

    let ids = this.context.sqlDataIds;

    if(statement.includes('lo3_pl')) {
        ids.plIds[index-1] = Number(result);
    }
    if(statement.includes('lo3_adres')) {
        ids.adresIds[index-1] = Number(result);
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

Given(/^de response status is gelijk aan (\d{3})$/, function (statusCode) {
    this.context.response.status = statusCode;
});

function groepeerQueriesPerStap(dataTable) {
    let retval = [];

    let currentCategorie;
    let index = 0;

    dataTable.hashes().forEach(function(hash) {
        if(hash.stap !== '') {
            // nieuwe stap
            index = Number(hash.stap) - 1;
            retval[index] = {};
        }

        let obj = retval[index];
        if(hash.categorie !== '') {
            currentCategorie = hash.categorie;
            obj[currentCategorie] = [];
        }

        obj[currentCategorie].push(hash);
    });

    return retval;
}

function vergelijkActualMetExpectedStatements(categorie, expected, actual, sqlDataIds) {
    let statement;
    const cat = categorie.replace(/-.*$/, '');
    switch(cat) {
        case 'adres':
            statement = insertIntoAdresStatement(actual);
            break;
        case 'autorisatie':
            statement = insertIntoAutorisatieStatement(actual);
            break;
        case 'gemeente':
            statement = insertIntoGemeenteStatement(actual);
            break;
        case 'inschrijving':
            statement = insertIntoPersoonlijstStatement(actual);
            sqlDataIds.currentPlIndex = sqlDataIds.currentPlIndex === undefined
                ? 0
                : sqlDataIds.currentPlIndex + 1;
            break;
        case 'verblijfplaats': {
                let adresIdElem = actual.find(ee => ee[0] === 'adres_id');
                if(adresIdElem !== undefined) {
                    adresIdElem[1] = sqlDataIds.adresIds[Number(adresIdElem[1])]+'';
                }
                const plId = sqlDataIds.plIds[sqlDataIds.currentPlIndex];
                statement = insertIntoStatement(cat,
                                                [['pl_id', plId+'']].concat(actual));
            }
            break;
        default: {
                const plId = sqlDataIds.plIds[sqlDataIds.currentPlIndex];
                statement = insertIntoStatement(cat,
                                                [['pl_id', plId+'']].concat(actual));
            }
            break;
    }

    statement.text.should.equal(expected.text, `${expected.categorie}:\n${statement.text}\n!=\n${expected.text}`);
    stringifyValues(statement.values).should.deep.equalInAnyOrder(expected.values.split(','),
                                                 `${expected.categorie}: ${statement.values} != ${expected.values}`);
}

Then(/^zijn de gegenereerde SQL statements$/, function(dataTable) {
    this.context.verifyResponse = false;
    
    const { sqlData, sqlDataIds } = this.context;
    const expected = groepeerQueriesPerStap(dataTable);

    for(const queries of expected) {

        let currentStap;
        for(const categorie of Object.keys(queries)) {
            queries[categorie].forEach(function(query, index) {
                if(query.stap !== '') {
                    currentStap = Number(query.stap) - 1;
                }

                const re = /(?<type>.*)-(?<typeid>\w?\d{1,2})$/;
                const found = re.exec(categorie);

                const actual = found && !['kind', 'nationaliteit', 'ouder-1', 'ouder-2', 'partner','reisdocument'].find((i) => i === found.groups.type)
                    ? sqlData[currentStap][found.groups.type][found.groups.typeid]?.data
                    : sqlData[currentStap][categorie][index];
                should.exist(actual, `categorie: ${categorie}`);

                vergelijkActualMetExpectedStatements(categorie,
                                                     query,
                                                     actual,
                                                     sqlDataIds);
            });
        }
    }
});

Then(/^heeft de scenario context een property '(\w*)' met waarde '(.*)'$/, function (propertyNaam, propertyWaarde) {
    this.context[propertyNaam].should.equal(propertyWaarde, this.context);
});

Then(/^bevat tabel '(\w*)' (\d*) (?:rij|rijen) met de volgende gegevens$/, async function (tabelNaam, expectedAantalRijen, dataTable) {
    const actualAantalRijen = await queryRowCount(global.pool, tabelNaam);
    actualAantalRijen.should.equal(expectedAantalRijen);

    for(const hash of dataTable.hashes()) {
        const actualAantalRijen = await queryRowCount(global.pool, tabelNaam, hash);
        Number(actualAantalRijen).should.equal(1);
    }
});

Then(/^heeft de response gezagsrelaties met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    this.context.expected = dataTable.hashes();
});

When(/^de gegenereerde sql statements zijn uitgevoerd$/, async function () {
    await executeSqlStatements(this.context.sql,
                               this.context.sqlData,
                               global.pool);
});
