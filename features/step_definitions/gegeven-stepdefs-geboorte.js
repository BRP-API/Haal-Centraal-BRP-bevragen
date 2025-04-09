const { Given } = require('@cucumber/cucumber');
const { arrayOfArraysToDataTable } = require('./dataTableFactory');
const { aanvullenPersoon } = require('./persoon-2');
const { getPersoon } = require('./contextHelpers');

function gegevenPersoonIsOpDatumGeboren(datum) {
    aanvullenPersoon(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['geboortedatum (03.10)', datum]
        ])
    );

    global.logger.info(`is ${datum} geboren`, getPersoon(this.context, undefined));
}

Given('is {dd-mm-yyyy datum} geboren', gegevenPersoonIsOpDatumGeboren);
Given('is {onbekende datum} geboren', gegevenPersoonIsOpDatumGeboren);
Given('is {vandaag, gisteren of morgen x jaar geleden} geboren', gegevenPersoonIsOpDatumGeboren);
Given('is {vandaag, gisteren of morgen - x jaar} geboren', gegevenPersoonIsOpDatumGeboren);
Given('is {deze-, vorige- of volgende maand - x jaar} geboren', gegevenPersoonIsOpDatumGeboren);
Given('is {dit-, vorig- of volgend jaar - x jaar} geboren', gegevenPersoonIsOpDatumGeboren);
Given('is {dd maand yyyy datum} geboren', gegevenPersoonIsOpDatumGeboren);
