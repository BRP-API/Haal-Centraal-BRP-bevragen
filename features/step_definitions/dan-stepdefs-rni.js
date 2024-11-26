const { Then } = require('@cucumber/cucumber');
const { createCollectieObjectMetSubCollectieObject,
        createSubCollectieObjectInLastCollectieObject } = require('./dataTable2ObjectFactory');

Then(/^heeft de response een persoon met een 'rni' met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObject(this.context, 'persoon', 'rni', dataTable);
});
        
Then(/^heeft de persoon ?(?:nog)? een 'rni' met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    createSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'rni', dataTable);
});
        