const { Given } = require('@cucumber/cucumber');
const { createPersoonMetStapel,
        createStapel } = require('./persoon');

Given(/^de persoon met burgerservicenummer '(\d*)' heeft een 'reisdocument' met de volgende gegevens$/, function (burgerservicenummer, dataTable) {
    createPersoonMetStapel(this.context, burgerservicenummer, 'reisdocument', dataTable);
});

Given(/^de persoon heeft een 'reisdocument' met de volgende gegevens$/, function(dataTable) {
    createStapel(this.context, 'reisdocument', dataTable);
});
