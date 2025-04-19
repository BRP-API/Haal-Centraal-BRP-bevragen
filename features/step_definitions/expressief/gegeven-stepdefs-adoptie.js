const { Given } = require('@cucumber/cucumber');
const { objectToDataTable, arrayOfArraysToDataTable } = require('../dataTableFactory');
const { createOuder, createKind, wijzigPersoon, wijzigGeadopteerdPersoon, wijzigOuder, aanvullenPersoon } = require('../persoon-2');
const { getPersoon, getBsn, getGeslachtsnaam, getGeboortedatum, getGeslachtsaanduiding } = require('../contextHelpers');
const { toBRPDate } = require('../brpDatum');
const { toDbColumnName } = require('../brp');

function gegevenIsGeadopteerdDoorPersoonAlsOuder(context, aanduidingKind, aanduidingOuder, ouderType, dataTable) {
    const kind = getPersoon(context, aanduidingKind);

    gegevenKindIsGeadopteerdDoorPersoonAlsOuder(context, kind, aanduidingOuder, ouderType, dataTable);
}

function gegevenKindIsGeadopteerdDoorPersoonAlsOuder(context, kind, aanduidingOuder, ouderType, dataTable) {
    const ouder = getPersoon(context, aanduidingOuder);

    const kindData = { ...kind.persoon.at(-1) };

    kindData[toDbColumnName('aktenummer (81.20)')] = '1AQ0100'

    wijzigPersoon(
        kind,
        objectToDataTable(kindData)
    );

    // Bij adoptie van een vondeling wordt de puntouder gewijzigd naar de adoptieouder
    const ouderData = kind[`ouder-${ouderType}`];

    if (ouderType === '1' && ouderData && ouderData[0]?.geslachts_naam === '.') {
        wijzigOuder(
            kind,
            ouderType,
            arrayOfArraysToDataTable([
                ['burgerservicenummer (01.20)', getBsn(ouder)],
                ['geslachtsnaam (02.40)', getGeslachtsnaam(ouder)],
                ['geboortedatum (03.10)', getGeboortedatum(ouder)],
                ['geslachtsaanduiding (04.10)', getGeslachtsaanduiding(ouder)],
            ], dataTable),
            false
        );
    } else {
        createOuder(
            kind,
            ouderType,
            arrayOfArraysToDataTable([
                ['burgerservicenummer (01.20)', getBsn(ouder)],
                ['geslachtsnaam (02.40)', getGeslachtsnaam(ouder)],
                ['geboortedatum (03.10)', getGeboortedatum(ouder)],
                ['geslachtsaanduiding (04.10)', getGeslachtsaanduiding(ouder)]
            ], dataTable)
        );
    }

    createKind(
        ouder,
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(kind)],
            ['geslachtsnaam (02.40)', getGeslachtsnaam(kind)],
            ['geboortedatum (03.10)', getGeboortedatum(kind)],
            ['aktenummer (81.20)', '1AQ0100'],
        ])
    )
}

function gegevenIsGeadopteerdOpDatum(aanduidingKind, datum, aanduidingOuder) {
    gegevenIsGeadopteerdDoorPersoon(this.context, aanduidingKind, aanduidingOuder, datum);
}

function gegevenIsGeadopteerd(aanduidingKind, aanduidingOuder) {
    gegevenIsGeadopteerdDoorPersoon(this.context, aanduidingKind, aanduidingOuder);
}

function gegevenIsGeadopteerdDoorPersoon(context, aanduidingKind, aanduidingOuder, datum) {
    const kind = getPersoon(context, aanduidingKind);

    if (datum === undefined) {
        datum = '10 jaar geleden';
    }

    const adoptieOuderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', datum],
        ['aktenummer (81.20)', '1AQ0100']
    ]);

    let ouderType = '1';

    const ouder = kind['ouder-1'];

    if (ouder) {
        if (ouder[0].geslachts_naam !== '.') {
            ouderType = '2';
        }
    }

    gegevenKindIsGeadopteerdDoorPersoonAlsOuder(context, kind, aanduidingOuder, ouderType, adoptieOuderData);

    global.logger.info(`persoon '${aanduidingKind}' is '${datum}' geadopteerd door '${aanduidingOuder}'`, getPersoon(context, aanduidingKind));
}

function gegevenIsGeadopteerdMetBeideOuders(aanduidingKind, aanduidingOuder1, aanduidingOuder2) {
    gegevenIsGeadopteerd.call(this, aanduidingKind, aanduidingOuder1);
    gegevenIsGeadopteerd.call(this, aanduidingKind, aanduidingOuder2);

    global.logger.info(`persoon '${aanduidingKind}' is geadopteerd door '${aanduidingOuder1}' en '${aanduidingOuder2}'`, getPersoon(this.context, aanduidingKind));
}

function gegevenIsGeadopteerdOpDatumMetBeideOuders(aanduidingKind, datum, aanduidingOuder1, aanduidingOuder2) {
    gegevenIsGeadopteerdOpDatum.call(this, aanduidingKind, datum, aanduidingOuder1);
    gegevenIsGeadopteerdOpDatum.call(this, aanduidingKind, datum, aanduidingOuder2);

    global.logger.info(`persoon '${aanduidingKind}' is geadopteerd door '${aanduidingOuder1}' en '${aanduidingOuder2}'`, getPersoon(this.context, aanduidingKind));
}

function gegevenIsGeadopteerdOpDatumMetBeideOudersInBuitenland(aanduidingKind, aanduidingOuder1, aanduidingOuder2, datum, documentBeschrijving) {
    // bij adoptie in het buitenland wordt in plaats van het akte-nr, beschrijving document gebruikt
    const kind = getPersoon(this.context, aanduidingKind);
    const ouder1 = getPersoon(this.context, aanduidingOuder1);
    const ouder2 = getPersoon(this.context, aanduidingOuder2);

    const adoptieData = arrayOfArraysToDataTable([
        ['beschrijving document (82.30)', documentBeschrijving]
    ]);

    aanvullenPersoon(kind, adoptieData);

    createOuder(
        kind,
        '1',
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(ouder1)],
            ['geslachtsnaam (02.40)', getGeslachtsnaam(ouder1)],
            ['geboortedatum (03.10)', getGeboortedatum(ouder1)],
            ['geslachtsaanduiding (04.10)', getGeslachtsaanduiding(ouder1)],
            ['datum ingang familierechtelijke betrekking (62.10)', datum],
            ['beschrijving document (82.30)', documentBeschrijving]
        ])
    );

    createOuder(
        kind,
        '2',
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(ouder2)],
            ['geslachtsnaam (02.40)', getGeslachtsnaam(ouder2)],
            ['geboortedatum (03.10)', getGeboortedatum(ouder2)],
            ['geslachtsaanduiding (04.10)', getGeslachtsaanduiding(ouder2)],
            ['datum ingang familierechtelijke betrekking (62.10)', datum],
            ['beschrijving document (82.30)', documentBeschrijving]
        ])
    );

    createKind(getPersoon(this.context, aanduidingOuder1),
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(kind)],
            ['geslachtsnaam (02.40)', getGeslachtsnaam(kind)],
            ['geboortedatum (03.10)', getGeboortedatum(kind)],
            ['beschrijving document (82.30)', documentBeschrijving]
        ])
    );

    createKind(getPersoon(this.context, aanduidingOuder2),
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(kind)],
            ['geslachtsnaam (02.40)', getGeslachtsnaam(kind)],
            ['geboortedatum (03.10)', getGeboortedatum(kind)],
            ['beschrijving document (82.30)', documentBeschrijving]
        ])
    );
}

Given('{string} is geadopteerd door {string}', gegevenIsGeadopteerd);
Given('{string} is geadopteerd door {string} en {string}', gegevenIsGeadopteerdMetBeideOuders);

Given('{string} is {vandaag, gisteren of morgen x jaar geleden} geadopteerd door {string}', gegevenIsGeadopteerdOpDatum);
Given('{string} is {vandaag, gisteren of morgen x jaar geleden} geadopteerd door {string} en {string}', gegevenIsGeadopteerdOpDatumMetBeideOuders);

Given('{string} is {vandaag, gisteren of morgen - x jaar} geadopteerd door {string}', gegevenIsGeadopteerdOpDatum);
Given('{string} is {vandaag, gisteren of morgen - x jaar} geadopteerd door {string} en {string}', gegevenIsGeadopteerdOpDatumMetBeideOuders);

Given('{string} is in het buitenland geadopteerd door {string} en {string} op {dd-mm-yyyy datum} met document {string}', gegevenIsGeadopteerdOpDatumMetBeideOudersInBuitenland);

Given(/^is geadopteerd door '(.*)' als ouder ([1-2])$/, function (aanduidingOuder, ouderType) {
    const kind = getPersoon(this.context, undefined);
    const adoptieOuderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', '10 jaar geleden'],
        ['aktenummer (81.20)', '1AQ0100']
    ]);

    gegevenKindIsGeadopteerdDoorPersoonAlsOuder(this.context, kind, aanduidingOuder, ouderType, adoptieOuderData);
});

Given(/^'(.*)' is geadopteerd door '(.*)' als ouder ([1-2])$/, function (aanduidingKind, aanduidingOuder, ouderType) {
    const kind = getPersoon(this.context, aanduidingKind);
    const adoptieOuderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', '10 jaar geleden'],
        ['aktenummer (81.20)', '1AQ0100']
    ]);

    gegevenKindIsGeadopteerdDoorPersoonAlsOuder(this.context, kind, aanduidingOuder, ouderType, adoptieOuderData);
});

Given(/^'(.*)' is op (\d*)-(\d*)-(\d*) geadopteerd door '(.*)' en '(.*)'$/, function (aanduidingKind, dag, maand, jaar, aanduidingOuder1, aanduidingOuder2) {
    const kind = getPersoon(this.context, aanduidingKind);
    const adoptieDatum = toBRPDate(dag, maand, jaar);
    const adoptieOuderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', adoptieDatum],
        ['aktenummer (81.20)', '1AQ0100']
    ]);

    gegevenKindIsGeadopteerdDoorPersoonAlsOuder(this.context, kind, aanduidingOuder1, '1', adoptieOuderData);
    gegevenKindIsGeadopteerdDoorPersoonAlsOuder(this.context, kind, aanduidingOuder2, '2', adoptieOuderData);
});

Given(/^'(.*)' is geadopteerd door '(.*)' als ouder ([1-2]) met de volgende gegevens$/, function (aanduidingKind, aanduidingOuder, ouderType, dataTable) {
    gegevenIsGeadopteerdDoorPersoonAlsOuder(this.context, aanduidingKind, aanduidingOuder, ouderType, dataTable);
});

function gegevenAdoptieVanKindIsHerroepenVoorOuder(context, kind, aanduidingOuder, ouderType, dataTable) {
    const ouder = getPersoon(context, aanduidingOuder);

    const kindData = { ...kind.persoon.at(-1) };
    kindData[toDbColumnName('aktenummer (81.20)')] = '1AR0200'

    wijzigGeadopteerdPersoon(
        kind,
        objectToDataTable(kindData),
        true
    );

    wijzigOuder(
        kind,
        ouderType,
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(ouder)],
            ['geslachtsnaam (02.40)', getGeslachtsnaam(ouder)]
        ], dataTable),
        true
    );
}

Given(/^de adoptie van '(.*)' is herroepen voor '(.*)' als ouder ([1-2])$/, function (aanduidingKind, aanduidingOuder, ouderType) {
    const kind = getPersoon(this.context, aanduidingKind);
    const adoptieOuderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', 'morgen - 2 jaar']
    ]);

    gegevenAdoptieVanKindIsHerroepenVoorOuder(this.context, kind, aanduidingOuder, ouderType, adoptieOuderData);
});

Given(/^is niet in Nederland geadopteerd$/, function () {
    // doe niets
});

Given(/^'(.*)' is in het buitenland geadopteerd door '(.*)' en '(.*)' op (\d*)-(\d*)-(\d*)$/, function (aanduidingKind, aanduidingOuder1, aanduidingOuder2, dag, maand, jaar) {
    return 'pending'
});