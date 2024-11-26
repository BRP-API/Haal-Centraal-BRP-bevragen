const { Then } = require('@cucumber/cucumber');
const { createCollectieObjectMetSubCollectieObject,
        createCollectieObjectMetSubCollectieObjecten,
        createSubCollectieObjectInLastCollectieObject,
        createSubCollectieObjectenInLastCollectieObject } = require('./dataTable2ObjectFactory');

Then(/^heeft de response een persoon met een 'nationaliteit' met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObject(this.context, 'persoon', 'nationaliteit', dataTable);
});

Then(/^heeft de persoon ?(?:nog)? een 'nationaliteit' met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    createSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'nationaliteit', dataTable);
});

Then(/^heeft de response een persoon zonder nationaliteiten$/, function () {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObjecten(this.context, 'persoon', 'nationaliteit');
});

Then(/^heeft de persoon geen nationaliteiten$/, function () {
    createSubCollectieObjectenInLastCollectieObject(this.context, 'persoon', 'nationaliteit');
});
