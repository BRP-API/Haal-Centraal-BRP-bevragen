const { Given } = require('@cucumber/cucumber');
const { getPersoon } = require('../contextHelpers');
const { aanvullenPersoon } = require('../persoon-2');
const { arrayOfArraysToDataTable } = require('../dataTableFactory');
const { selectFirstOrDefault } = require('../postgresqlHelpers-2');

Given(/^is in Nederland geboren$/, function () {
    const landGeboorte = '6030';
    const nummerAkte = '1AA0100';

    aanvullenPersoon(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['geboorteland (03.30)', landGeboorte],
            ['aktenummer (81.20)', nummerAkte]
        ])
    );

    global.logger.info(`gegeven persoon is in Nederland geboren`, getPersoon(this.context, undefined));
});

Given(/^is in België geboren$/, function () {
    const landGeboorte = '5010'; // Nederland
    const nummerAkte = '1AA0100';

    aanvullenPersoon(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['geboorteland (03.30)', landGeboorte],
            ['aktenummer (81.20)', nummerAkte]
        ])
    );

    global.logger.info(`gegeven persoon is in België geboren`, getPersoon(this.context, undefined));
});

Given(/^is in het buitenland geboren$/, function () {
    const landGeboorte = '9999'; // any code except 6030
    const nummerAkte = '1AA0100';

    aanvullenPersoon(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['geboorteland (03.30)', landGeboorte],
            ['aktenummer (81.20)', nummerAkte]
        ])
    );

    global.logger.info(`gegeven persoon is in het buitenland geboren`, getPersoon(this.context, undefined));
});

Given(/^is geboren in (.*)/, async function (landNaam) {
    const codeVanLand = await selectFirstOrDefault('lo3_land', ['land_code'], 'land_naam', landNaam, '6030');

    aanvullenPersoon(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['geboorteland (03.30)', codeVanLand]
        ])
    );

    global.logger.info(`gegeven persoon is geboren in ${landNaam}`, getPersoon(this.context, undefined));
});