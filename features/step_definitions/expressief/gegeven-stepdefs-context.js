const { Given } = require('@cucumber/cucumber');
const { getPersoon,
        wijzigPersoonContext } = require('../contextHelpers');

Given(/^persoon '([a-zA-Z0-9]*)'$/, function (aanduiding) {
    wijzigPersoonContext(this.context, aanduiding);
});