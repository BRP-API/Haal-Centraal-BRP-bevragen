const { Given } = require('@cucumber/cucumber');
const { createAutorisatie,
        createGegevensgroepAutorisatie } = require('./autorisatie');

Given(/^de afnemer met indicatie '(.*)' heeft de volgende 'autorisatie' gegevens$/, function (afnemerCode, dataTable) {
    createAutorisatie(this.context, afnemerCode, dataTable);
});

Given(/^de afnemer met indicatie '(.*)' is geautoriseerd voor '(.*)' gegevens$/, function (afnemerCode, gegevensgroep) {
    createGegevensgroepAutorisatie(this.context, afnemerCode, gegevensgroep);
});

Given(/^de geauthenticeerde consumer heeft de volgende 'claim' gegevens$/, function (dataTable) {
    this.context.afnemerID = dataTable.hashes()[0].naam !== undefined
        ? dataTable.hashes().find(param => param.naam === 'afnemerID').waarde
        : dataTable.hashes()[0].afnemerID;

        this.context.gemeenteCode = dataTable.hashes()[0].naam !== undefined
        ? dataTable.hashes().find(param => param.naam === 'gemeenteCode')?.waarde
        : dataTable.hashes()[0].gemeenteCode;
});
