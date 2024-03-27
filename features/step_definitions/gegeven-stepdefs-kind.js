const { Given } = require('@cucumber/cucumber');
const { createPersoonMetGegevensgroepCollectie,
        createGegevensgroepCollectie,
        wijzigGegevensgroep } = require('./persoon');

Given(/^de persoon met burgerservicenummer '(\d*)' heeft een 'kind' met de volgende gegevens$/, function (burgerservicenummer, dataTable) {
    createPersoonMetGegevensgroepCollectie(this.context, burgerservicenummer, 'kind', dataTable);
});

Given(/^de persoon heeft ?(?:nog)? een 'kind' met ?(?:alleen)? de volgende gegevens$/, async function (dataTable) {
    createGegevensgroepCollectie(this.context, 'kind', dataTable);
});

Given(/^het 'kind' is gewijzigd naar de volgende gegevens$/, async function (dataTable) {
    wijzigGegevensgroep(this.context, 'kind', dataTable);
});

Given(/^het 'kind' is gecorrigeerd naar de volgende gegevens$/, async function (dataTable) {
    wijzigGegevensgroep(this.context, 'kind', dataTable, true);
});
