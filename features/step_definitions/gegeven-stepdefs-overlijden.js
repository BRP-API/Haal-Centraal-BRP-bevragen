const { Given } = require('@cucumber/cucumber');
const { createPersoonMetGegevensgroep,
        createGegevensgroep,
        wijzigGegevensgroep } = require('./persoon')
const { arrayOfArraysToDataTable } = require('./dataTableFactory');
const { aanvullenInschrijving,
        createOverlijden } = require('./persoon-2');
const { getPersoon } = require('./contextHelpers');

Given(/^de persoon met burgerservicenummer '(\d*)' heeft de volgende 'overlijden' gegevens$/, function(burgerservicenummer, dataTable) {
    createPersoonMetGegevensgroep(this.context, burgerservicenummer, 'overlijden', dataTable);
});

Given(/^de persoon heeft de volgende 'overlijden' gegevens$/, function(dataTable) {
    createGegevensgroep(this.context, 'overlijden', dataTable);
});

Given(/^het 'overlijden' is gecorrigeerd naar de volgende gegevens$/, function (dataTable) {
    wijzigGegevensgroep(this.context, 'overlijden', dataTable, true);
});

Given('{aanduidingen} is {dd-mm-yyyy datum} overleden', function (aanduidingen, datum) {
    const redenOpschortingBijhouding = 'O';

    aanvullenInschrijving(
        getPersoon(this.context, aanduidingen),
        arrayOfArraysToDataTable([
            ['datum opschorting bijhouding (67.10)', datum],
            ['reden opschorting bijhouding (67.20)', redenOpschortingBijhouding]
        ])
    );

    createOverlijden(
        getPersoon(this.context, aanduidingen),
        arrayOfArraysToDataTable([
            ['datum overlijden (08.10)', datum]
        ])
    );
});
