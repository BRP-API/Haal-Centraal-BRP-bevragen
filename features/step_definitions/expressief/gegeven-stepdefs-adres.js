const { Given } = require('@cucumber/cucumber');
const { createAdres } = require('../adres-2');
const { getAdres } = require('../contextHelpers');

Given(/^adres '([a-zA-Z0-9]*)'$/, function (aanduiding, dataTable) {
    createAdres(this.context, aanduiding, dataTable);

    global.logger.info(`gegeven adres '${aanduiding}'`, getAdres(this.context, aanduiding));
});