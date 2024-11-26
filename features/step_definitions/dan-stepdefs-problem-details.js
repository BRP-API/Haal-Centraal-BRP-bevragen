const { Then } = require('@cucumber/cucumber');
const { createCollectieObjecten } = require('./dataTable2ObjectFactory')

Then(/^heeft de response invalidParams met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    createCollectieObjecten(this.context, 'invalidParams', dataTable);
});
