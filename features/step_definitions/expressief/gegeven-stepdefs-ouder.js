const { Given } = require('@cucumber/cucumber');
const { createOuder, createKind } = require('../persoon-2');
const { getPersoon, getBsn, getGeslachtsnaam, getGeboortedatum, getGeslachtsaanduiding } = require('../contextHelpers');
const { arrayOfArraysToDataTable } = require('../dataTableFactory');

Given(/^heeft de volgende persoon zonder burgerservicenummer als ouder ([1-2])$/, function (ouderType, dataTable) {
    createOuder(
        getPersoon(this.context, undefined),
        ouderType,
        dataTable
    );

    global.logger.info(`heeft de volgende persoon zonder burgerservicenummer als ouder ${ouderType}`, getPersoon(this.context, undefined));
});

function gegevenHeeftPersoonAlsOuder(context, aanduiding, ouderType, dataTable) {
    const kind = getPersoon(context, undefined);
    const ouder = getPersoon(context, aanduiding);

    createOuder(
        kind,
        ouderType,
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(ouder)],
            ['geslachtsnaam (02.40)', getGeslachtsnaam(ouder)]
        ], dataTable)
    );

    createKind(
        ouder,
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(kind)],
            ['geslachtsnaam (02.40)', getGeslachtsnaam(kind)],
            ['geboortedatum (03.10)', getGeboortedatum(kind)],
            ['aktenummer (81.20)', '1AA0100'],
        ])
    )
}

function gegevenHeeftNietIngeschrevenPersoonAlsOuder(context, aanduiding, ouderType, dataTable) {
    const kind = getPersoon(context, undefined);

    createOuder(
        kind,
        ouderType,
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', ''],
            ['geslachtsnaam (02.40)', aanduiding]
        ], dataTable)
    );
}

Given(/^heeft '(.*)' als ouder ([1-2])$/, function (aanduiding, ouderType) {
    const ouderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', 'gisteren - 17 jaar']
    ]);

    gegevenHeeftPersoonAlsOuder(this.context, aanduiding, ouderType, ouderData);
});

function getOuderData(context, aanduiding) {
    const ouderData = [
        ['datum ingang familierechtelijke betrekking (62.10)', getGeboortedatum(getPersoon(context, undefined)) ?? 'gisteren - 17 jaar'],
        ['aktenummer (81.20)', '1AA0100'],
        ['geboortedatum (03.10)', getGeboortedatum(getPersoon(context, aanduiding)) ?? 'gisteren - 45 jaar']
    ];

    const geslachtsAanduiding = getGeslachtsaanduiding(getPersoon(context, aanduiding));
    if (geslachtsAanduiding) {
        ouderData.push(['geslachtsaanduiding (04.10)', geslachtsAanduiding]);
    }

    return ouderData;
}

function gegevenHeeftOuderMetAanduiding(aanduiding) {
    const huidigePersoon = getPersoon(this.context, undefined);
    const ouderType = huidigePersoon['ouder-1'] ? '2' : '1';

    gegevenHeeftPersoonAlsOuder(this.context, aanduiding, ouderType, arrayOfArraysToDataTable(getOuderData(this.context, aanduiding)));
}

function gegevenHeeftOudersMetAanduiding(aanduiding1, aanduiding2) {
    gegevenHeeftOuderMetAanduiding.call(this, aanduiding1);
    gegevenHeeftOuderMetAanduiding.call(this, aanduiding2);
}

Given('heeft {string} als ouder', gegevenHeeftOuderMetAanduiding);
Given('heeft {string} als ouder vanaf de geboortedatum', gegevenHeeftOuderMetAanduiding);

Given('heeft {string} en {string} als ouders', gegevenHeeftOudersMetAanduiding);
Given('heeft {string} en {string} als ouders vanaf de geboortedatum', gegevenHeeftOudersMetAanduiding);

Given(/^heeft '(.*)' als ouder die niet met burgerservicenummer is ingeschreven in de BRP$/, function (aanduiding) {
    const ouderData = arrayOfArraysToDataTable([
        ['geslachtsnaam (02.40)', aanduiding],
        ['datum ingang familierechtelijke betrekking (62.10)', 'gisteren - 17 jaar'],
        ['geboortedatum (03.10)', 'gisteren - 45 jaar'],
        ['aktenummer (81.20)', '1AA0100']
    ]);

    const huidigePersoon = getPersoon(this.context, undefined);
    const ouderType = huidigePersoon['ouder-1'] ? '2' : '1';

    gegevenHeeftNietIngeschrevenPersoonAlsOuder(this.context, aanduiding, ouderType, ouderData);
});

Given(/^heeft '(.*)' als ouder ([1-2]) met de volgende gegevens$/, function (aanduiding, ouderType, dataTable) {
    gegevenHeeftPersoonAlsOuder(this.context, aanduiding, ouderType, dataTable);
});