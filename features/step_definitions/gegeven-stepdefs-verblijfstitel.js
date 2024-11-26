const { Given } = require('@cucumber/cucumber');
const { createPersoonMetGegevensgroep,
        createGegevensgroep,
        wijzigGegevensgroep } = require('./persoon')

Given(/^de persoon met burgerservicenummer '(\d*)' heeft een 'verblijfstitel' verkregen met de volgende gegevens$/, function(burgerservicenummer, dataTable) {
    createPersoonMetGegevensgroep(this.context, burgerservicenummer, 'verblijfstitel', dataTable);
});

Given(/^de persoon heeft een 'verblijfstitel' verkregen met de volgende gegevens$/, function(dataTable) {
    createGegevensgroep(this.context, 'verblijfstitel', dataTable);
});

Given(/^(?:de|het) 'verblijfstitel' is gewijzigd naar de volgende gegevens$/, function (dataTable) {
    wijzigGegevensgroep(this.context, 'verblijfstitel', dataTable);
});

Given(/^het 'verblijfstitel' is gecorrigeerd naar de volgende gegevens$/, function (dataTable) {
    wijzigGegevensgroep(this.context, 'verblijfstitel', dataTable, true);
});
