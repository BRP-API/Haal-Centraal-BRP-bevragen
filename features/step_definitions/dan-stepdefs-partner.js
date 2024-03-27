const { Then } = require('@cucumber/cucumber');
const { createCollectieObjectMetSubCollectieObject,
        createCollectieObjectMetSubCollectieObjecten,
        createCollectieObjectMetSubCollectieObjectMetObjectVeld,
        createSubCollectieObjectInLastCollectieObject,
        createSubCollectieObjectenInLastCollectieObject,
        createSubCollectieObjectMetObjectVeldInLastCollectieObject,
        createObjectVeldInLastSubCollectieObjectInLastCollectieObject } = require('./dataTable2ObjectFactory');

Then(/^heeft de response een persoon met een 'partner' met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObject(this.context, 'persoon', 'partner', dataTable);
});

Then(/^heeft de response een persoon met een 'partner' met ?(?:alleen)? de volgende '(\w*)' gegevens$/, function (naamObjectProperty, dataTable) {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObjectMetObjectVeld(this.context, 'persoon', 'partner', naamObjectProperty, dataTable);
});

Then(/^heeft de response een persoon met een 'partner' zonder gegevens$/, function () {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObject(this.context, 'persoon', 'partner');
});

Then(/^heeft de response een persoon met een 'partner' zonder '(\w*)' gegevens$/, function (naamObjectProperty) {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObjectMetObjectVeld(this.context, 'persoon', 'partner', naamObjectProperty);
});

Then(/^heeft de response een persoon zonder partners$/, function () {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObjecten(this.context, 'persoon', 'partner');
});

Then(/^heeft de persoon ?(?:nog)? een 'partner' met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    createSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'partner', dataTable);
});

Then(/^heeft de persoon een 'partner' met ?(?:alleen)? de volgende '(\w*)' gegevens$/, function (naamObjectProperty, dataTable) {
    createSubCollectieObjectMetObjectVeldInLastCollectieObject(this.context, 'persoon', 'partner', naamObjectProperty, dataTable);
});

Then(/^heeft de persoon geen partners$/, function () {
    createSubCollectieObjectenInLastCollectieObject(this.context, 'persoon', 'partner');
});

Then(/^heeft de 'partner' ?(?:alleen)? de volgende '(\w*)' gegevens$/, function (naamObjectProperty, dataTable) {
    createObjectVeldInLastSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'partner', naamObjectProperty, dataTable);
});

Then(/^heeft de 'partner' geen '(\w*)' gegevens$/, function (naamObjectProperty) {
    createObjectVeldInLastSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'partner', naamObjectProperty);
});
