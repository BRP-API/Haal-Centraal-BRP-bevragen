const { Given } = require('@cucumber/cucumber');
const { createPersoonMetGegevensgroep,
        createGegevensgroep,
        wijzigGegevensgroep } = require('./persoon');

Given(/^de persoon met burgerservicenummer '(\d*)' heeft de volgende 'gezagsverhouding' gegevens$/, function (burgerservicenummer, dataTable) {
    createPersoonMetGegevensgroep(this.context, burgerservicenummer, 'gezagsverhouding', dataTable);
});

Given(/^de persoon heeft de volgende 'gezagsverhouding' gegevens$/, function (dataTable) {
    createGegevensgroep(this.context, 'gezagsverhouding', dataTable);
});

Given(/^de 'gezagsverhouding' is gewijzigd naar de volgende gegevens$/, function (dataTable) {
    wijzigGegevensgroep(this.context, 'gezagsverhouding', dataTable);
});

Given(/^de 'gezagsverhouding' is gecorrigeerd naar de volgende gegevens$/, function (dataTable) {
    wijzigGegevensgroep(this.context, 'gezagsverhouding', dataTable, true);
});
