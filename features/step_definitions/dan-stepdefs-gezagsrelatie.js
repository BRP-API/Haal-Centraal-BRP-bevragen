const { Then } = require('@cucumber/cucumber');
const { createCollectieObjectMetSubCollectieObject,
        createCollectieObjectMetSubCollectieObjecten,
        createSubCollectieObjectInLastCollectieObject,
        createSubSubCollectieObjectInLastSubCollectieObjectInLastCollectieObject,
        createSubSubCollectieObjectenInLastSubCollectieObjectInLastCollectieObject } = require('./dataTable2ObjectFactory');

Then(/^heeft de response een persoon met een 'gezag' met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObject(this.context, 'persoon', 'gezag', dataTable);
    this.context.expected = this.context.expected.personen;
});

Then(/^heeft de persoon ?(?:nog)? een 'gezag' met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    let expected = this.context.expected;
    this.context.expected = { personen: expected };
    createSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'gezag', dataTable);
    this.context.expected = this.context.expected.personen;
});

Then(/^heeft ?(?:het)? 'gezag' ?(?:nog)? een '(\w*)' met de volgende gegevens$/, function (relatie, dataTable) {
    let expected = this.context.expected;
    this.context.expected = { personen: expected };
    createSubSubCollectieObjectInLastSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'gezag', relatie, dataTable);
    this.context.expected = this.context.expected.personen;
});

Then(/^heeft de response een persoon zonder gezag$/, function () {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObjecten(this.context, 'persoon', 'gezag');
    this.context.expected = this.context.expected.personen;
});

Then(/^heeft ?(?:het)? 'gezag' geen derden$/, function () {
    let expected = this.context.expected;
    this.context.expected = { personen: expected };
    createSubSubCollectieObjectenInLastSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'gezag', 'derde');
    this.context.expected = this.context.expected.personen;
});
