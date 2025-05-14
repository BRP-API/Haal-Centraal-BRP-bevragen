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

Given('adres {aanduiding} in gemeente {string}', async function (aanduiding, omschrijvingGemeente) {
    let gemeenteCode = omschrijvingGemeente
        ? await selectFirstOrDefault('lo3_gemeente', ['gemeente_code'], 'gemeente_naam', omschrijvingGemeente, undefined)
        : undefined;
    if (!gemeenteCode) {
        global.logger.error(`Geen gemeente gevonden met naam ${omschrijvingGemeente}`);
        return;
    }
    gegevenEenAdresInGemeente(this.context, aanduiding, gemeenteCode, undefined);
});

Given('adres {aanduiding} in gemeente {string} heeft de volgende gegevens', async function (aanduiding, omschrijvingGemeente, dataTable) {
    let gemeenteCode = omschrijvingGemeente
        ? await selectFirstOrDefault('lo3_gemeente', ['gemeente_code'], 'gemeente_naam', omschrijvingGemeente, undefined)
        : undefined;
    if (!gemeenteCode) {
        global.logger.error(`Geen gemeente gevonden met naam ${omschrijvingGemeente}`);
        return;
    }
    gegevenEenAdresInGemeente(this.context, aanduiding, gemeenteCode, dataTable);
});
