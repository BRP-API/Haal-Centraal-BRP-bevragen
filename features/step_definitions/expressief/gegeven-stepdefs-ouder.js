const { Given } = require('@cucumber/cucumber');
const { createOuder, createKind } = require('../persoon-2');
const { getPersoon,
        getPersoonMetAanduiding,
        getBsn,
        getGeslachtsnaam,
        getGeboortedatum,
        getAkteNr,
        getBeschrijvingDocument,
        persoonPropertiesToArrayofArrays,
        getAanduidingDefaultPersoon } = require('../contextHelpers');
const { arrayOfArraysToDataTable } = require('../dataTableFactory');

Given(/^heeft de volgende persoon zonder burgerservicenummer als ouder ([1-2])$/, function (ouderType, dataTable) {
    global.logger.error(`DEPRECATED. gegeven heeft de volgende persoon zonder burgerservicenummer als ouder ${ouderType}`, dataTable);
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

Given(/^heeft '(.*)' als ouder ([1-2])$/, function (aanduiding, ouderType) {
    global.logger.error(`DEPRECATED. gegeven heeft '${aanduiding}' als ouder ${ouderType}`);
    const ouderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', 'gisteren - 17 jaar']
    ]);

    gegevenHeeftPersoonAlsOuder(this.context, aanduiding, ouderType, ouderData);
});

function gegevenHeeftOuderMetAanduiding(aanduiding) {
    gegevenDePersoonHeeftAlsOuders(this.context, getAanduidingDefaultPersoon(this.context), aanduiding, undefined);
}

function gegevenHeeftOudersMetAanduiding(aanduiding1, aanduiding2) {
    gegevenDePersoonHeeftAlsOuders(this.context, getAanduidingDefaultPersoon(this.context), aanduiding1, aanduiding2);
}

Given('heeft {string} als ouder', gegevenHeeftOuderMetAanduiding);
Given('heeft {string} als ouder vanaf de geboortedatum', gegevenHeeftOuderMetAanduiding);

Given('heeft {string} en {string} als ouders', gegevenHeeftOudersMetAanduiding);
Given('heeft {string} en {string} als ouders vanaf de geboortedatum', gegevenHeeftOudersMetAanduiding);

Given(/^heeft '(.*)' als ouder ([1-2]) met de volgende gegevens$/, function (aanduiding, ouderType, dataTable) {
    global.logger.error(`DEPRECATED. gegeven heeft '${aanduiding}' als ouder ${ouderType} met de volgende gegevens`, dataTable);
    gegevenHeeftPersoonAlsOuder(this.context, aanduiding, ouderType, dataTable);
});

function createKindData(kind) {
    let retval = [];

    const aktenr = getAkteNr(kind);
    if(aktenr) {
        retval.push(['aktenummer (81.20)', aktenr]);
    }

    const docBeschrijving = getBeschrijvingDocument(kind);
    if(docBeschrijving) {
        retval.push(['beschrijving document (82.30)', docBeschrijving]);
    }

    return retval;
}

function createOuderData(kind, ouder) {
    let retval = createKindData(kind);

    const geboorteDatum = getGeboortedatum(kind);
    if(geboorteDatum) {
        retval.push([
            ouder
                ? 'datum ingang familierechtelijke betrekking (62.10)'
                : 'datum ingang geldigheid (85.10)',
            geboorteDatum]);
    }

    return retval;
}

function createKindEnOuder(kind, ouder, ouderType) {
    const ouderData = persoonPropertiesToArrayofArrays(ouder).concat(createOuderData(kind, ouder));
    createOuder(kind, ouderType, arrayOfArraysToDataTable(ouderData));

    if(ouder) {
        const kindData = persoonPropertiesToArrayofArrays(kind).concat(createKindData(kind));
        createKind(ouder, arrayOfArraysToDataTable(kindData));
    }
}

function gegevenDePersoonHeeftAlsOuders(context, persoonAanduiding, ouderAanduiding1, ouderAanduiding2) {
    const kind = getPersoonMetAanduiding(context, persoonAanduiding);
    if (!kind) {
        return;
    }

    const ouder1 = getPersoonMetAanduiding(context, ouderAanduiding1);
    if (!ouder1) {
        return;
    }

    const ouder2 = ouderAanduiding2 ? getPersoonMetAanduiding(context, ouderAanduiding2) : undefined;
    if (ouderAanduiding2 && !ouder2) {
        return;
    }

    createKindEnOuder(kind, ouder1, '1');
    createKindEnOuder(kind, ouder2, '2');
}

module.exports = {
    gegevenDePersoonHeeftAlsOuders
};