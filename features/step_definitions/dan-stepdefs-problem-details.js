const { Then } = require('@cucumber/cucumber');
const { createVelden,
        createCollectieObjecten } = require('./dataTable2ObjectFactory')

Then(/^heeft de response invalidParams met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    createCollectieObjecten(this.context, 'invalidParams', dataTable);
});

Then(/^heeft de response geen foutmelding$/, function () {});

Then(/^heeft de response een foutmelding$/, function (dataTable) {
    this.context.verifyResponse = true;

    createVelden(this.context, dataTable);
});

Then(/^parameter foutmeldingen$/, function (dataTable) {
    createCollectieObjecten(this.context, 'invalidParams', dataTable);
});
