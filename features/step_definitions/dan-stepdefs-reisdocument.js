const { Then } = require('@cucumber/cucumber');
const { createCollectieObject,
        createCollectieObjectMetObjectVeld,
        createObjectVeldInLastCollectieObject } = require('./dataTable2ObjectFactory')

Then(/^heeft de response een reisdocument met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    createCollectieObject(this.context, 'reisdocument', dataTable);
});

Then(/^heeft de response een reisdocument zonder gegevens$/, function () {
    this.context.verifyResponse = true;

    createCollectieObject(this.context, 'reisdocument');
});

Then(/^heeft de response een reisdocument met de volgende '(\w*)' gegevens$/, function (naamObjectProperty, dataTable) {
    this.context.verifyResponse = true;

    createCollectieObjectMetObjectVeld(this.context, 'reisdocument', naamObjectProperty, dataTable);
});

Then(/^heeft het reisdocument de volgende '(\w*)' gegevens$/, function (naamObjectProperty, dataTable) {
    createObjectVeldInLastCollectieObject(this.context, 'reisdocument', naamObjectProperty, dataTable);
});
