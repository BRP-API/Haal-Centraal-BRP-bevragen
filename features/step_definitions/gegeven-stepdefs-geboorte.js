const { Given } = require('@cucumber/cucumber');
const { arrayOfArraysToDataTable } = require('./dataTableFactory');
const { aanvullenPersoon } = require('./persoon-2');
const { getPersoon } = require('./contextHelpers');

function createVondelingOuders(persoon, datum) {
    const { createOuder } = require('./persoon-2');

    createOuder(
        persoon,
        '1',
        arrayOfArraysToDataTable([
            ['geslachtsaanduiding (04.10)', 'V'],
            ['geslachtsnaam (02.40)', '.'],
            ['datum ingang familierechtelijke betrekking (62.10)', datum],
            ['aktenummer (81.20)', '1AA0100']
        ])
    );
    createOuder(
        persoon,
        '2',
        arrayOfArraysToDataTable([ ['aktenummer (81.20)', '1AA0100'] ])
    );
}

function gegevenVondelingIsOpDatumGeboren(datum) {
    gegevenPersoonIsOpDatumGeboren.call(this, datum);
    
    createVondelingOuders(getPersoon(this.context, undefined), datum);

    global.logger.info(`is ${datum} als vondeling geboren`, getPersoon(this.context, undefined));
}

function gegevenPersoonIsOpDatumGeboren(datum) {
    aanvullenPersoon(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['geboortedatum (03.10)', datum]
        ])
    );

    global.logger.info(`is ${datum} geboren`, getPersoon(this.context, undefined));
}

function gegevenPersoonMetAanduidingIsOpDatumGeboren(aanduiding,datum) {
    aanvullenPersoon(
        getPersoon(this.context, aanduiding),
        arrayOfArraysToDataTable([
            ['geboortedatum (03.10)', datum]
        ])
    );

    global.logger.info(`${aanduiding} is ${datum} geboren`, getPersoon(this.context, aanduiding));
}

Given('{string} is {relatieve datum} geboren', gegevenPersoonMetAanduidingIsOpDatumGeboren);
Given('{string} is {dd-mm-yyyy datum} geboren', gegevenPersoonMetAanduidingIsOpDatumGeboren);
Given('{string} is {onbekende datum} geboren', gegevenPersoonMetAanduidingIsOpDatumGeboren);
Given('{string} is {vandaag, gisteren of morgen x jaar geleden} geboren', gegevenPersoonMetAanduidingIsOpDatumGeboren);
Given('{string} is {vandaag, gisteren of morgen - x jaar} geboren', gegevenPersoonMetAanduidingIsOpDatumGeboren);
Given('{string} is {deze-, vorige- of volgende maand - x jaar} geboren', gegevenPersoonMetAanduidingIsOpDatumGeboren);
Given('{string} is {dit-, vorig- of volgend jaar - x jaar} geboren', gegevenPersoonMetAanduidingIsOpDatumGeboren);
Given('{string} is {dd maand yyyy datum} geboren', gegevenPersoonMetAanduidingIsOpDatumGeboren);

Given('is {dd-mm-yyyy datum} geboren', gegevenPersoonIsOpDatumGeboren);
Given('is {onbekende datum} geboren', gegevenPersoonIsOpDatumGeboren);
Given('is {vandaag, gisteren of morgen x jaar geleden} geboren', gegevenPersoonIsOpDatumGeboren);
Given('is {vandaag, gisteren of morgen - x jaar} geboren', gegevenPersoonIsOpDatumGeboren);
Given('is {deze-, vorige- of volgende maand - x jaar} geboren', gegevenPersoonIsOpDatumGeboren);
Given('is {dit-, vorig- of volgend jaar - x jaar} geboren', gegevenPersoonIsOpDatumGeboren);
Given('is {dd maand yyyy datum} geboren', gegevenPersoonIsOpDatumGeboren);

Given('is {dd-mm-yyyy datum} als vondeling geboren', gegevenVondelingIsOpDatumGeboren);
Given('is {onbekende datum} als vondeling geboren', gegevenVondelingIsOpDatumGeboren);
Given('is {vandaag, gisteren of morgen x jaar geleden} als vondeling geboren', gegevenVondelingIsOpDatumGeboren);
Given('is {vandaag, gisteren of morgen - x jaar} als vondeling geboren', gegevenVondelingIsOpDatumGeboren);
Given('is {deze-, vorige- of volgende maand - x jaar} als vondeling geboren', gegevenVondelingIsOpDatumGeboren);
Given('is {dit-, vorig- of volgend jaar - x jaar} als vondeling geboren', gegevenVondelingIsOpDatumGeboren);
Given('is {dd maand yyyy datum} als vondeling geboren', gegevenVondelingIsOpDatumGeboren);