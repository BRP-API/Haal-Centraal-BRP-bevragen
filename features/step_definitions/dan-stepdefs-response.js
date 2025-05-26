const { Then } = require('@cucumber/cucumber');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();

Then(/^heeft de response de volgende headers$/, function (dataTable) {
    const headers = this.context.response.headers;

    dataTable.hashes().forEach(function(row) {
        headers[row.naam].should.equal(row.waarde);
    });
});

Then('bevat de request naar de gezag API de header {string} met waarde {string}', function (headerNaam, headerWaarde) {
    const headers = this.context.response.headers;

    const header = headers[headerNaam];
    should.exist(header);
});

Then('bevat de request naar de gezag API geen {string} header', function (headerNaam) {
    const headers = this.context.response.headers;

    const header = headers[headerNaam];
    should.not.exist(header);
});
