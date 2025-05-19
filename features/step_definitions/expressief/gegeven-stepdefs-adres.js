const { Given } = require('@cucumber/cucumber');
const { createAdres } = require('../adres-2');
const { selectFirstOrDefault } = require('../postgresqlHelpers-2');
const { arrayOfArraysToDataTable } = require('../dataTableFactory');

function dataTableHasColumn(dataTable, columnName) {
    return dataTable?.raw()[0].includes(columnName);
}

Given('adres {aanduiding}', function (aanduiding, dataTable) {
    gegevenEenAdres(this.context, aanduiding, dataTable);
});

function gegevenEenAdres(context, aanduiding, dataTable) {
    gegevenEenAdresInGemeente(context, aanduiding, '0518', dataTable);
}

function gegevenEenAdresInGemeente(context, aanduiding, gemeenteCode, dataTable) {
    const adresData = [];

    const gemCode =  gemeenteCode.padStart(4, '0');
    if(!dataTableHasColumn(dataTable, 'gemeentecode (92.10)')) {
        adresData.push(['gemeentecode (92.10)', gemeenteCode]);
    }
    if(!dataTableHasColumn(dataTable, 'identificatiecode verblijfplaats (11.80)')) {
        adresData.push(['identificatiecode verblijfplaats (11.80)', `${gemCode}010051001502`]);
    }
    if(!dataTableHasColumn(dataTable, 'identificatiecode nummeraanduiding (11.90)')) {
        adresData.push(['identificatiecode nummeraanduiding (11.90)', `${gemCode}200000617227`]);
    }
    if(!dataTableHasColumn(dataTable, 'postcode (11.60)')) {
        adresData.push(['postcode (11.60)', '1234AB']);
    }
    if(!dataTableHasColumn(dataTable, 'huisnummer (11.20)')) {
        adresData.push(['huisnummer (11.20)', '321']);
    }
    if(!dataTableHasColumn(dataTable, 'straatnaam (11.10)')) {
        adresData.push(['straatnaam (11.10)', 'Hoofdstraat']);
    }

    createAdres(context, aanduiding, arrayOfArraysToDataTable(adresData, dataTable));
}

async function getGemeentecode(gemeentenaam) {
    const gemeentecode = gemeentenaam
        ? await selectFirstOrDefault('lo3_gemeente', ['gemeente_code'], 'gemeente_naam', gemeentenaam, undefined)
        : undefined;

    if (!gemeentecode) {
        global.logger.error(`Geen gemeente gevonden met naam ${gemeentenaam}`);
    }

    return gemeentecode;
}

Given('adres {aanduiding} in gemeente {string}', async function (aanduiding, gemeentenaam) {
    const gemeentecode = await getGemeentecode(gemeentenaam);
    if(gemeentecode) {
        gegevenEenAdresInGemeente(this.context, aanduiding, gemeentecode, undefined);
    }
});

Given('adres {aanduiding} in gemeente {string} heeft de volgende gegevens', async function (aanduiding, gemeentenaam, dataTable) {
    const gemeentecode = await getGemeentecode(gemeentenaam);
    if(gemeentecode) {
        gegevenEenAdresInGemeente(this.context, aanduiding, gemeentecode, dataTable);
    }
});
