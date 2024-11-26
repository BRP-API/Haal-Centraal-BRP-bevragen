const { Given } = require('@cucumber/cucumber');
const { createPersoonMetGegevensgroepCollectie,
        createGegevensgroepCollectie,
        wijzigGegevensgroep } = require('./persoon');

Given(/^de persoon met burgerservicenummer '(\d*)' heeft een ouder '(\d)' met de volgende gegevens$/, function (burgerservicenummer, ouderType, dataTable) {
    createPersoonMetGegevensgroepCollectie(this.context, burgerservicenummer, `ouder-${ouderType}`, dataTable);
});

Given(/^de persoon heeft een ouder '(\d)' met de volgende gegevens$/, function (ouderType, dataTable) {
    createGegevensgroepCollectie(this.context, `ouder-${ouderType}`, dataTable);
});

Given(/^de ouder '(\d)' is gecorrigeerd naar de volgende gegevens$/, function (ouderType, dataTable) {
    wijzigGegevensgroep(this.context, `ouder-${ouderType}`, dataTable, true);
});

Given(/^de ouder '(\d)' is gewijzigd naar de volgende gegevens$/, function (ouderType, dataTable) {
    wijzigGegevensgroep(this.context, `ouder-${ouderType}`, dataTable);
});
