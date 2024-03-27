const { Given } = require('@cucumber/cucumber');
const { createPersoon,
        createPersoonMetGegevensgroep,
        createInschrijving,
        updatePersoon,
        wijzigPersoon } = require('./persoon');

Given(/^de persoon met burgerservicenummer '(\d*)' heeft de volgende gegevens$/, function (burgerservicenummer, dataTable) {
    createPersoon(this.context, burgerservicenummer, dataTable);
});

Given(/^de persoon met burgerservicenummer '(\d*)' heeft de volgende 'inschrijving' gegevens$/, function (burgerservicenummer, dataTable) {
    createPersoonMetGegevensgroep(this.context, burgerservicenummer, 'inschrijving', dataTable);
});

Given(/^de persoon met burgerservicenummer '(\d*)' heeft de volgende 'kiesrecht' gegevens$/, function (burgerservicenummer, dataTable) {
    createPersoonMetGegevensgroep(this.context, burgerservicenummer, 'kiesrecht', dataTable);
});

Given(/^de persoon heeft de volgende 'inschrijving' gegevens$/, function (dataTable) {
    createInschrijving(this.context, dataTable);
});

Given(/^de persoon heeft de volgende gegevens$/, function (dataTable) {
    updatePersoon(this.context, dataTable);
});

Given(/^de persoon is gewijzigd naar de volgende gegevens$/, function (dataTable) {
    wijzigPersoon(this.context, dataTable);
});

Given(/^de persoon is gecorrigeerd naar de volgende gegevens$/, function (dataTable) {
    wijzigPersoon(this.context, dataTable, true);
});

Given(/^de persoon heeft (?:GEEN|geen) '(.*)' gegevens$/, function (_) {
    // doe niets
});
