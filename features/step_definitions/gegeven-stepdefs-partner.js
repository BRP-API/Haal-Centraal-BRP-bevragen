const { Given } = require('@cucumber/cucumber');
const { createPersoonMetGegevensgroepCollectie,
        createGegevensgroepCollectie,
        wijzigGegevensgroep } = require('./persoon');

Given(/^de persoon met burgerservicenummer '(\d*)' heeft een 'partner' met de volgende gegevens$/, function (burgerservicenummer, dataTable) {
    createPersoonMetGegevensgroepCollectie(this.context, burgerservicenummer, 'partner', dataTable);
});

Given(/^de persoon heeft ?(?:nog)? een '?(?:ex-)?partner' met ?(?:alleen)? de volgende gegevens$/, async function (dataTable) {
    createGegevensgroepCollectie(this.context, 'partner', dataTable);
});

Given(/^de persoon heeft geen (?:actuele partner|\(ex\)partner)$/, function () {
    // doe niks
});

Given(/^de persoon heeft nooit een actueel of ontbonden huwelijk of partnerschap gehad$/, function () {
    // doe niets
});

Given(/^de 'partner' is gewijzigd naar de volgende gegevens$/, async function (dataTable) {
    wijzigGegevensgroep(this.context, 'partner', dataTable);
});

Given(/^de 'partner' is gecorrigeerd naar de volgende gegevens$/, async function (dataTable) {
    wijzigGegevensgroep(this.context, 'partner', dataTable, true);
});
