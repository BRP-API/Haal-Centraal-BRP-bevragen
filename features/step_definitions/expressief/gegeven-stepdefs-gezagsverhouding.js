const { Given } = require('@cucumber/cucumber');
const { getPersoon } = require('../contextHelpers');
const { createGezagsverhouding, aanvullenGezagsverhouding } = require('../persoon-2');
const { arrayOfArraysToDataTable } = require('../dataTableFactory');

Given(/^voor '(.*)' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens$/, function (aanduiding, dataTable) {
    createGezagsverhouding(
        getPersoon(this.context, aanduiding),
        dataTable
    );
});

Given(/^'(.*)' staat onder curatele$/, function (aanduiding) {
    const curateleRegisterIndicatie = '1';

    aanvullenGezagsverhouding(
        getPersoon(this.context, aanduiding),
        arrayOfArraysToDataTable([
            ['indicatie curateleregister (33.10)', curateleRegisterIndicatie]
        ])
    );
});

Given(/^staat onder curatele/, function () {
    const curateleRegisterIndicatie = '1';

    aanvullenGezagsverhouding(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['indicatie curateleregister (33.10)', curateleRegisterIndicatie]
        ])
    );
});

const IndicatieGezag = {
    Ouder1: '1',
    Ouder2: '2',
    BeideOuders: '12',
    VoogdijInstelling: 'D',
    Derde: 'D',
    Ouder1Derde: '1D',
    Ouder2Derde: '2D'
}

Given(/^in een gerechtelijke uitspraak is het gezag toegewezen aan '(.*)'$/, function (aanduiding) {
    let indicatieGezag = getIndicatieGezag(this.context, aanduiding);
    let relatieveDatum = 'gisteren - 1 jaar';

    createGezagsverhouding(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['indicatie gezag minderjarige (32.10)', indicatieGezag],
            ['datum ingang geldigheid (85.10)', relatieveDatum],
        ])
    )
});

Given(/^(.*) is in een gerechtelijke uitspraak het gezag toegewezen aan '(.*)'$/, function (relatieveDatum, aanduiding) {
    let indicatieGezag = getIndicatieGezag(this.context, aanduiding);

    createGezagsverhouding(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['indicatie gezag minderjarige (32.10)', indicatieGezag],
            ['datum ingang geldigheid (85.10)', relatieveDatum],
        ])
    )
});

Given(/^in een gerechtelijke uitspraak is het gezag toegewezen aan '(.*)' en een derde$/, function (aanduiding) {
    let indicatieGezag = (getIndicatieGezag(this.context, aanduiding) == IndicatieGezag.Ouder1)
        ? IndicatieGezag.Ouder1Derde
        : IndicatieGezag.Ouder2Derde;

    createGezagsverhouding(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['indicatie gezag minderjarige (32.10)', indicatieGezag],
            ['datum ingang geldigheid (85.10)', 'gisteren - 1 jaar'],
        ])
    )
});

Given(/^(.*) is in een gerechtelijke uitspraak het gezag toegewezen aan '(.*)' en een derde$/, function (relatieveDatum, aanduiding) {
    let indicatieGezag = (getIndicatieGezag(this.context, aanduiding) == IndicatieGezag.Ouder1)
        ? IndicatieGezag.Ouder1Derde
        : IndicatieGezag.Ouder2Derde;

    createGezagsverhouding(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['indicatie gezag minderjarige (32.10)', indicatieGezag],
            ['datum ingang geldigheid (85.10)', relatieveDatum],
        ])
    )
});

Given(/^in een gerechtelijke uitspraak is het gezag toegewezen aan beide ouders$/, function () {
    let indicatieGezag = IndicatieGezag.BeideOuders;

    createGezagsverhouding(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['indicatie gezag minderjarige (32.10)', indicatieGezag],
            ['datum ingang geldigheid (85.10)', 'gisteren - 1 jaar'],
        ])
    )
});

Given(/^(.*) is in een gerechtelijke uitspraak het gezag toegewezen aan beide ouders$/, function (relatieveDatum) {
    let indicatieGezag = IndicatieGezag.BeideOuders;

    createGezagsverhouding(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['indicatie gezag minderjarige (32.10)', indicatieGezag],
            ['datum ingang geldigheid (85.10)', relatieveDatum],
        ])
    )
});

Given(/^in een gerechtelijke uitspraak is een (voogdijinstelling|derde) tot voogd benoemd$/, function (gezaghebbende) {
    let indicatieGezag = (gezaghebbende == 'voogdijinstelling') ? IndicatieGezag.VoogdijInstelling : IndicatieGezag.Derde;

    createGezagsverhouding(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['indicatie gezag minderjarige (32.10)', indicatieGezag],
            ['datum ingang geldigheid (85.10)', 'gisteren - 1 jaar'],
        ])
    )
});

Given(/^(.*) is in een gerechtelijke uitspraak het gezag toegewezen aan een (voogdijinstelling|derde)$/, function (relatieveDatum, gezaghebbende) {
    let indicatieGezag = (gezaghebbende == 'voogdijinstelling') ? IndicatieGezag.VoogdijInstelling : IndicatieGezag.Derde;

    createGezagsverhouding(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['indicatie gezag minderjarige (32.10)', indicatieGezag],
            ['datum ingang geldigheid (85.10)', relatieveDatum],
        ])
    )
});

function getIndicatieGezag(context, aanduiding) {
    let plKind = getPersoon(context, undefined);
    let plKindOuder1 = plKind['ouder-1'];
    let plKindOuder2 = plKind['ouder-2'];

    if (plKindOuder1) {
        plKindOuder1 = plKindOuder1[0];
        if (plKindOuder1.geslachts_naam == aanduiding) {
            return IndicatieGezag.Ouder1;
        }
    }

    if (plKindOuder2) {
        plKindOuder2 = plKindOuder2[0];
        if (plKindOuder2.geslachts_naam == aanduiding) {
            return IndicatieGezag.Ouder2;
        }
    }
}