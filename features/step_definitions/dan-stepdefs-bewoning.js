const { Then } = require('@cucumber/cucumber');
const { createCollectieObject,
        createSubCollectieObjectenInLastCollectieObject,
        createSubCollectieObjectInLastCollectieObject,
        createObjectVeldInLastSubCollectieObjectInLastCollectieObject } = require('./dataTable2ObjectFactory')

Then(/^heeft de response een bewoning met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    createCollectieObject(this.context, 'bewoning', dataTable);
    createSubCollectieObjectenInLastCollectieObject(this.context, 'bewoning', 'bewoner');
    createSubCollectieObjectenInLastCollectieObject(this.context, 'bewoning', 'mogelijkeBewoner');
});

Then(/^heeft de bewoning ?(?:nog)? een bewoner met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    createSubCollectieObjectInLastCollectieObject(this.context, 'bewoning', 'bewoner', dataTable);
});

Then(/^heeft de bewoning bewoners met de volgende gegevens$/, function(dataTable) {
    createSubCollectieObjectenInLastCollectieObject(this.context, 'bewoning', 'bewoner', dataTable);
});

Then(/^heeft de bewoning ?(?:nog)? een mogelijke bewoner met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    createSubCollectieObjectInLastCollectieObject(this.context, 'bewoning', 'mogelijkeBewoner', dataTable);
});

Then(/^heeft de bewoning mogelijke bewoners met de volgende gegevens$/, function(dataTable) {
    createSubCollectieObjectenInLastCollectieObject(this.context,
                                                    'bewoning',
                                                    'mogelijkeBewoner',
                                                    dataTable);
});

Then(/^heeft de bewoner de volgende '(\w*)' gegevens$/, function (gegevensgroep, dataTable) {
    createObjectVeldInLastSubCollectieObjectInLastCollectieObject(this.context,
                                                                  'bewoning',
                                                                  'bewoner',
                                                                  gegevensgroep,
                                                                  dataTable);
});
