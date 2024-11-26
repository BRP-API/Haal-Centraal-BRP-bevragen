const { Then } = require('@cucumber/cucumber');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();

Then(/^heeft de response de volgende headers$/, function (dataTable) {
    const headers = this.context.response.headers;

    dataTable.hashes().forEach(function(row) {
        headers[row.naam].should.equal(row.waarde);
    });
});
