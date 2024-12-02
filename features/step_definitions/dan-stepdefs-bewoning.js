const { Then } = require('@cucumber/cucumber');
const { createCollectieObject,
        createSubCollectieObjectenInLastCollectieObject,
        createSubCollectieObjectInLastCollectieObject,
        createObjectVeldInLastSubCollectieObjectInLastCollectieObject } = require('./dataTable2ObjectFactory')
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();

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

Then(/^heeft de mogelijke bewoner de volgende '(\w*)' gegevens$/, function (gegevensgroep, dataTable) {
    createObjectVeldInLastSubCollectieObjectInLastCollectieObject(this.context,
                                                                  'bewoning',
                                                                  'mogelijkeBewoner',
                                                                  gegevensgroep,
                                                                  dataTable);
});

Then(/^heeft de response een bewoning met (\d*) bewoners en (\d*) mogelijke bewoners$/, function (aantalBewoners, aantalMogelijkeBewoners) {
    this.context?.response?.status?.should.equal(200, `response body: ${JSON.stringify(this.context.response.data, null, '\t')}`);

    const actual = this.context?.response?.data?.bewoningen;
    should.exist(actual);

    const actualBewoning = actual.at(-1);
    should.exist(actualBewoning.bewoners, `geen bewoners array om bewoners te kunnen tellen. response:\n${JSON.stringify(actual, null, '\t')}`);
    actualBewoning.bewoners.length.should.equal(Number(aantalBewoners), `aantal bewoners in response is ongelijk aan ${aantalBewoners}\nBewoning: ${JSON.stringify(actualBewoning, null, '\t')}`);
    should.exist(actualBewoning.mogelijkeBewoners, `geen mogelijkeBewoners array om mogelijke bewoners te kunnen tellen. response:\n${JSON.stringify(actual, null, '\t')}`);
    actualBewoning.mogelijkeBewoners.length.should.equal(Number(aantalMogelijkeBewoners), `aantal mogelijke bewoners in response is ongelijk aan ${aantalMogelijkeBewoners}\nBewoning: ${JSON.stringify(actualBewoning, null, '\t')}`);
});

Then(/^heeft de bewoning geen bewoners en geen mogelijke bewoners$/, function () {
    this.context.verifyResponse = true;

    let expectedBewoning = this.context.response?.data?.bewoningen.at(-1);
    should.exist(expectedBewoning, `geen bewoning om de bewoners toe te voegen. Gebruik de stap 'Dan heeft de response een bewoning met de volgende gegevens' om een verwachte bewoning te definieren`);
});
