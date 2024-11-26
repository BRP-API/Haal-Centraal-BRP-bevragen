const { Given } = require('@cucumber/cucumber');
const { createPersoonMetGegevensgroep,
        createGegevensgroep,
        wijzigGegevensgroep } = require('./persoon')

Given(/^de persoon met burgerservicenummer '(\d*)' heeft de volgende 'overlijden' gegevens$/, function(burgerservicenummer, dataTable) {
    createPersoonMetGegevensgroep(this.context, burgerservicenummer, 'overlijden', dataTable);
});

Given(/^de persoon heeft de volgende 'overlijden' gegevens$/, function(dataTable) {
    createGegevensgroep(this.context, 'overlijden', dataTable);
});

Given(/^het 'overlijden' is gecorrigeerd naar de volgende gegevens$/, function (dataTable) {
    wijzigGegevensgroep(this.context, 'overlijden', dataTable, true);
});
