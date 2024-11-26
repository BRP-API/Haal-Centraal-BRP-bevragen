const { Given } = require('@cucumber/cucumber');

Given(/^de response van de downstream api heeft de volgende headers$/, function (dataTable) {
    this.context.downstreamApiResponseHeaders = dataTable.hashes();
});

Given(/^de response van de downstream api heeft de volgende body$/, function (docString) {
    this.context.downstreamApiResponseBody = docString;
});
