const { Given } = require('@cucumber/cucumber');
const { createPersoonMetGegevensgroepCollectie,
        createGegevensgroepCollectie,
        wijzigGegevensgroep } = require('./persoon');

Given(/^de persoon met burgerservicenummer '(\d*)' heeft een 'nationaliteit' met de volgende gegevens$/, function (burgerservicenummer, dataTable) {
    createPersoonMetGegevensgroepCollectie(this.context, burgerservicenummer, 'nationaliteit', dataTable);
});

Given(/^de persoon heeft ?(?:nog)? een 'nationaliteit' met ?(?:alleen)? de volgende gegevens$/, async function (dataTable) {
    createGegevensgroepCollectie(this.context, 'nationaliteit', dataTable);
});

Given(/^de 'nationaliteit' is gewijzigd naar de volgende gegevens$/, async function (dataTable) {
    wijzigGegevensgroep(this.context, 'nationaliteit', dataTable);
});

Given(/^de 'nationaliteit' is gecorrigeerd naar de volgende gegevens$/, async function (dataTable) {
    wijzigGegevensgroep(this.context, 'nationaliteit', dataTable, true);
});
