const { Given } = require('@cucumber/cucumber');
const { getPersoon } = require('../contextHelpers');

function wijzigPersoonContext(context, aanduiding) {
    const persoonId = `persoon-${aanduiding}`;
    const index = context.data.personen.findIndex(element => element.id === persoonId);

    if (index !== -1) {
        const [element] = context.data.personen.splice(index, 1);
        context.data.personen.push(element);
    }
}

Given(/^persoon '([a-zA-Z0-9]*)'$/, function (aanduiding) {
    wijzigPersoonContext(this.context, aanduiding);

    global.logger.info(`gegeven persoon '${aanduiding}'`, getPersoon(this.context, aanduiding));
});