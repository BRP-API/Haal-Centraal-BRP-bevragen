const { Given } = require('@cucumber/cucumber');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();
const { createPersoonMetWoonadres,
        createPersoonMetBriefadres,
        createPersoonMetVerblijfplaats,
        createPersoonMetVerblijfplaatsBuitenland,
        createWoonadres,
        createBriefadres,
        createVerblijfplaatsBuitenland,
        createVerblijfplaats,
        corrigeerVerblijfplaats } = require('./verblijfplaats');

Given(/^de persoon met burgerservicenummer '(\d*)' is ingeschreven op adres '(\w*)' met de volgende gegevens$/, function (burgerservicenummer, adresId, dataTable) {
    createPersoonMetWoonadres(this.context, burgerservicenummer, adresId, dataTable);
});

Given(/^de persoon met burgerservicenummer '(\d*)' heeft adres '(\w*)' als briefadres opgegeven met de volgende gegevens$/, function (burgerservicenummer, adresId, dataTable) {
    createPersoonMetBriefadres(this.context, burgerservicenummer, adresId, dataTable);
});

Given(/^de persoon met burgerservicenummer '(\d*)' is ingeschreven op een buitenlands adres met de volgende gegevens$/, function (burgerservicenummer, dataTable) {
    createPersoonMetVerblijfplaatsBuitenland(this.context, burgerservicenummer, dataTable);
});

Given(/^de persoon met burgerservicenummer '(\d*)' heeft de volgende 'verblijfplaats' gegevens$/, function (burgerservicenummer, dataTable) {
    createPersoonMetVerblijfplaats(this.context, burgerservicenummer, dataTable);
});

Given(/^de persoon heeft de volgende 'verblijfplaats' gegevens$/, function (dataTable) {  
    createVerblijfplaats(this.context, dataTable);
});

Given(/^de persoon is ?(?:vervolgens)? ingeschreven op adres '(\w*)' met de volgende gegevens$/, function (adresId, dataTable) {
    createWoonadres(this.context, adresId, dataTable);
});

Given(/^de persoon heeft ?(?:vervolgens)? adres '(\w*)' als briefadres opgegeven met de volgende gegevens$/, function (adresId, dataTable) {
    createBriefadres(this.context, adresId, dataTable);
});

Given(/^de persoon is ?(?:vervolgens)? ingeschreven op een buitenlands adres met de volgende gegevens$/, function (dataTable) {
    createVerblijfplaatsBuitenland(this.context, dataTable);
});

Given(/^de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens$/, function (dataTable) {
    corrigeerVerblijfplaats(this.context, undefined, dataTable, undefined);
});

Given(/^de inschrijving is vervolgens gecorrigeerd als een inschrijving op adres '(.*)' met de volgende gegevens$/, function (adresId, dataTable) {
    corrigeerVerblijfplaats(this.context, adresId, dataTable, true);
});

Given(/^er zijn (\d*) personen ingeschreven op adres '(.*)' met de volgende gegevens$/, function (aantal, adresId, dataTable) {
    const adressenData = this.context.sqlData.find(e => Object.keys(e).includes('adres'));
    should.exist(adressenData, 'geen adressen gevonden');
    const adresIndex = adressenData.adres[adresId]?.index;
    should.exist(adresIndex, `geen adres gevonden met id '${adresId}'`);

    let i = 0;
    while(i < Number(aantal)) {
        i++;

        const burgerservicenummer = (i + '').padStart(9, '0');

        createPersoonMetWoonadres(this.context, burgerservicenummer, adresId, dataTable);
    }
});
