const { Then } = require('@cucumber/cucumber');
const { createCollectieObjectMetSubCollectieObject,
        createCollectieObjectMetSubCollectieObjecten,
        createCollectieObjectMetSubCollectieObjectMetObjectVeld,
        createSubCollectieObjectInLastCollectieObject,
        createSubCollectieObjectMetObjectVeldInLastCollectieObject,
        createObjectVeldInLastSubCollectieObjectInLastCollectieObject } = require('./dataTable2ObjectFactory');

Then(/^heeft de response een persoon met een 'ouder' met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObject(this.context, 'persoon', 'ouder', dataTable);
});

Then(/^heeft de response een persoon met een 'ouder' met ?(?:alleen)? de volgende '(\w*)' gegevens$/, function (naamObjectProperty, dataTable) {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObjectMetObjectVeld(this.context, 'persoon', 'ouder', naamObjectProperty, dataTable);
});

Then(/^heeft de response een persoon met een 'ouder' zonder '(\w*)' gegevens$/, function (naamObjectProperty) {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObjectMetObjectVeld(this.context, 'persoon', 'ouder', naamObjectProperty);
});

Then(/^heeft de response een persoon zonder ouders$/, function () {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObjecten(this.context, 'persoon', 'ouder');
});

Then(/^heeft de persoon ?(?:nog)? een 'ouder' met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    createSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'ouder', dataTable);
});

Then(/^heeft de persoon een 'ouder' met ?(?:alleen)? de volgende '(\w*)' gegevens$/, function (naamObjectProperty, dataTable) {
    createSubCollectieObjectMetObjectVeldInLastCollectieObject(this.context, 'persoon', 'ouder', naamObjectProperty, dataTable);
});

Then(/^heeft de persoon een 'ouder' zonder gegevens$/, function () {
    createSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'ouder');
});

Then(/^heeft de persoon een 'ouder' zonder '(\w*)' gegevens$/, function (naamObjectProperty) {
    createSubCollectieObjectMetObjectVeldInLastCollectieObject(this.context, 'persoon', 'ouder', naamObjectProperty);
});

Then(/^heeft de 'ouder' ?(?:alleen)? de volgende '(\w*)' gegevens$/, function (naamObjectProperty, dataTable) {
    createObjectVeldInLastSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'ouder', naamObjectProperty, dataTable);
});

Then(/^heeft de 'ouder' geen '(\w*)' gegevens$/, function (naamObjectProperty) {
    createObjectVeldInLastSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'ouder', naamObjectProperty);
});
