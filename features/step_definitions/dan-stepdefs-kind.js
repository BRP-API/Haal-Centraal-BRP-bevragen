const { Then } = require('@cucumber/cucumber');
const { createCollectieObjectMetSubCollectieObject,
        createCollectieObjectMetSubCollectieObjecten,
        createCollectieObjectMetSubCollectieObjectMetObjectVeld,
        createSubCollectieObjectenInLastCollectieObject,
        createSubCollectieObjectInLastCollectieObject,
        createSubCollectieObjectMetObjectVeldInLastCollectieObject,
        createObjectVeldInLastSubCollectieObjectInLastCollectieObject } = require('./dataTable2ObjectFactory');

Then(/^heeft de response een persoon met een 'kind' met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObject(this.context, 'persoon', 'kind', dataTable);
});

Then(/^heeft de response een persoon met een 'kind' met ?(?:alleen)? de volgende '(\w*)' gegevens$/, function (naamObjectProperty, dataTable) {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObjectMetObjectVeld(this.context, 'persoon', 'kind', naamObjectProperty, dataTable);
});

Then(/^heeft de response een persoon zonder kinderen$/, function () {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObjecten(this.context, 'persoon', 'kind');
});

Then(/^heeft de response een persoon met een 'kind' zonder gegevens$/, function () {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObject(this.context, 'persoon', 'kind');
});

Then(/^heeft de response een persoon met een 'kind' zonder '(\w*)' gegevens$/, function (naamObjectProperty) {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObjectMetObjectVeld(this.context, 'persoon', 'kind', naamObjectProperty);
});

Then(/^heeft de persoon ?(?:nog)? een 'kind' met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    createSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'kind', dataTable);
});

Then(/^heeft de persoon een 'kind' met ?(?:alleen)? de volgende '(\w*)' gegevens$/, function (naamObjectProperty, dataTable) {
    createSubCollectieObjectMetObjectVeldInLastCollectieObject(this.context, 'persoon', 'kind', naamObjectProperty, dataTable);
});

Then(/^heeft de persoon geen kinderen$/, function () {
    createSubCollectieObjectenInLastCollectieObject(this.context, 'persoon', 'kind');
});

Then(/^heeft het 'kind' geen '(\w*)' gegevens$/, function (naamObjectProperty) {
    createObjectVeldInLastSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'kind', naamObjectProperty);
});
