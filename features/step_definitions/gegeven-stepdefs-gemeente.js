const { Given } = require('@cucumber/cucumber');
const { createGemeente,
        samenvoegenGemeente } = require('./gemeente');

Given(/^gemeente '(.*)' heeft de volgende gegevens$/, function (gemeenteId, dataTable) {
    createGemeente(this.context, gemeenteId, dataTable);
});

Given(/^gemeente '(.*)' is samengevoegd met de volgende gegevens$/, function (gemeenteId, dataTable) {
    samenvoegenGemeente(this.context, gemeenteId, dataTable);
});
