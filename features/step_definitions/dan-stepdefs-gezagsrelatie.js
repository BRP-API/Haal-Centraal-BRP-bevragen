const { Then } = require('@cucumber/cucumber');
const { createCollectieObjectMetSubCollectieObject,
        createCollectieObjectMetSubCollectieObjecten,
        createSubCollectieObjectInLastCollectieObject,
        createSubCollectieObjectenInLastCollectieObject,
        createSubSubCollectieObjectInLastSubCollectieObjectInLastCollectieObject,
        createSubSubCollectieObjectenInLastSubCollectieObjectInLastCollectieObject } = require('./dataTable2ObjectFactory');

Then(/^heeft de response een persoon met een 'gezag' met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObject(this.context, 'persoon', 'gezag', dataTable);
});

Then(/^heeft de persoon ?(?:nog)? een 'gezag' met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    createSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'gezag', dataTable);
});

Then(/^heeft ?(?:het)? 'gezag' ?(?:nog)? een '(\w*)' met de volgende gegevens$/, function (relatie, dataTable) {
    createSubSubCollectieObjectInLastSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'gezag', relatie, dataTable);
});

Then(/^heeft de response een persoon zonder gezag$/, function () {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObjecten(this.context, 'persoon', 'gezag');
});

Then(/^heeft de persoon geen gezag$/, function () {
    createSubCollectieObjectenInLastCollectieObject(this.context, 'persoon', 'gezag');
});

Then(/^heeft ?(?:het)? 'gezag' geen derden$/, function () {
    createSubSubCollectieObjectenInLastSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'gezag', 'derde');
});
