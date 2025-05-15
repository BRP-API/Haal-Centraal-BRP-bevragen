const { Given } = require('@cucumber/cucumber');
const { createAdres } = require('../adres-2');
const { selectFirstOrDefault } = require('../postgresqlHelpers-2');
const { arrayOfArraysToDataTable } = require('../dataTableFactory');

Given('adres {aanduiding}', function (aanduiding, dataTable) {
    createAdres(this.context, aanduiding, dataTable);
});

function gegevenEenAdresInGemeente(context, aanduiding, gemeenteCode, dataTable) {
    const gemCode =  gemeenteCode.padStart(4, '0');
    const adresseerbaarObjectId = `${gemCode}010051001502`;
    const nummeraanduidingId = `${gemCode}200000617227`;

    createAdres(context, aanduiding, arrayOfArraysToDataTable([
        ['gemeentecode (92.10)', gemeenteCode],
        ['identificatiecode verblijfplaats (11.80)', adresseerbaarObjectId],
        ['identificatiecode nummeraanduiding (11.90)', nummeraanduidingId],
    ], dataTable));
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
