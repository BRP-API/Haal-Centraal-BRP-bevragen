const { Then } = require('@cucumber/cucumber');
const { createCollectieObject,
        createCollectieObjecten,
        createObjectVeldInLastCollectieObject } = require('./dataTable2ObjectFactory');

Then(/^heeft de response verblijfplaatsen met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    createCollectieObjecten(this.context, 'verblijfplaats', dataTable);
});

Then(/^heeft de response een verblijfplaats voorkomen met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    createCollectieObject(this.context, 'verblijfplaats', dataTable);
});

Then(/^heeft het verblijfplaats voorkomen de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {
    createObjectVeldInLastCollectieObject(this.context, 'verblijfplaats', gegevensgroep, dataTable );
});
