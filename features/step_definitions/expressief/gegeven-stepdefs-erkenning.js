const { Given } = require('@cucumber/cucumber');
const { createOuder, createKind, wijzigPersoon, wijzigOuder } = require('../persoon-2');
const { getPersoon,
        getBsn,
        getGeslachtsnaam,
        getGeboortedatum,
        persoonPropertiesToArrayofArrays } = require('../contextHelpers');
const { arrayOfArraysToDataTable, objectToDataTable } = require('../dataTableFactory');
const { toBRPDate } = require('../brpDatum');
const { toDbColumnName } = require('../brp');
const { genereerAktenummer } = require('../generators');

const ErkenningsType = {
    Geboorte: 'A',
    ErkenningBijGeboorteaangifte: 'B',
    ErkenningNaGeboorteaangifte: 'C',
    ErkenningBijNotarieleAkte: 'J',
    GerechtelijkeVaststellingOuderschap: 'V'
}

Given('{string} is erkend door {string} {erkenningstype}( )op {int}-{int}-{int}', function (aanduiding, aanduidingOuder, erkenningstype, dag, maand, jaar) {
    gegevenDePersoonIsErkend(this.context, aanduiding, aanduidingOuder, erkenningstype, toBRPDate(dag, maand, jaar));
});

Given('{string} is {vandaag, gisteren of morgen x jaar geleden} erkend door {string}', function (aanduiding, datumErkenning, aanduidingOuder) {
    gegevenDePersoonIsErkend(this.context, aanduiding, aanduidingOuder, ErkenningsType.ErkenningNaGeboorteaangifte, datumErkenning);
});

Given(/^is erkend door '(.*)' als ouder ([1-2]) met erkenning bij geboorteaangifte$/, function (aanduidingOuder, ouderType) {
    const kind = getPersoon(this.context, null);
    const kindData = { ...kind.persoon.at(-1) };

    const ouderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', kindData.geboorte_datum]
    ]);

    gegevenIsErkendDoorPersoonAlsOuder(this.context, aanduidingOuder, ErkenningsType.ErkenningBijGeboorteaangifte, ouderType, ouderData);
});

Given(/^is erkend door '(.*)' als ouder ([1-2]) met erkenning na geboorteaangifte op (\d*)-(\d*)-(\d*)$/, function (aanduidingOuder, ouderType, dag, maand, jaar) {
    const ouderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', toBRPDate(dag, maand, jaar)]
    ]);

    gegevenIsErkendDoorPersoonAlsOuder(this.context, aanduidingOuder, ErkenningsType.ErkenningNaGeboorteaangifte, ouderType, ouderData);
});

Given(/^is erkend door '(.*)' als ouder ([1-2]) met erkenning bij notariële akte op (\d*)-(\d*)-(\d*)$/, function (aanduidingOuder, ouderType, dag, maand, jaar) {
    const ouderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', toBRPDate(dag, maand, jaar)]
    ]);

    gegevenIsErkendDoorPersoonAlsOuder(this.context, aanduidingOuder, ErkenningsType.ErkenningBijNotarieleAkte, ouderType, ouderData);
});

Given(/^is erkend door '(.*)' als ouder ([1-2]) met gerechtelijke vaststelling ouderschap op (\d*)-(\d*)-(\d*)$/, function (aanduidingOuder, ouderType, dag, maand, jaar) {
    const ouderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', toBRPDate(dag, maand, jaar)]
    ]);

    gegevenIsErkendDoorPersoonAlsOuder(this.context, aanduidingOuder, ErkenningsType.GerechtelijkeVaststellingOuderschap, ouderType, ouderData);
});

Given('{string} is erkend door {string} als ongeboren vrucht op {dd-mm-yyyy datum}', function (aanduidingPersoon, aanduidingOuder, datumErkenning) {
    gegevenDePersoonIsErkend(this.context, aanduidingPersoon, aanduidingOuder, ErkenningsType.Geboorte, datumErkenning);
});
Given('{string} is erkend door {string} bij geboorteaangifte', function (aanduidingPersoon, aanduidingOuder) {
    gegevenDePersoonIsErkend(this.context, aanduidingPersoon, aanduidingOuder, ErkenningsType.ErkenningBijGeboorteaangifte, undefined);
});

function gegevenIsErkendDoorPersoonAlsOuder(context, aanduidingOuder, erkenningsType, ouderType, dataTable) {
    if (!erkenningsType) {
        erkenningsType = ErkenningsType.ErkenningBijGeboorteaangifte;
    }

    const kind = getPersoon(context, null);
    const ouder = getPersoon(context, aanduidingOuder);

    const kindData = { ...kind.persoon.at(-1) };
    kindData[toDbColumnName('aktenummer (81.20)')] = `1A${erkenningsType}0100`

    wijzigPersoon(
        kind,
        objectToDataTable(kindData)
    );

    if(kind[`ouder-${ouderType}`]) {
        wijzigOuder(
            kind,
            ouderType,
            arrayOfArraysToDataTable([
                ['burgerservicenummer (01.20)', getBsn(ouder)],
                ['geslachtsnaam (02.40)', getGeslachtsnaam(ouder)],
                ['aktenummer (81.20)', `1A${erkenningsType}0100`]
            ], dataTable)
        );
    }
    else {
        createOuder(
            kind,
            ouderType,
            arrayOfArraysToDataTable([
                ['burgerservicenummer (01.20)', getBsn(ouder)],
                ['geslachtsnaam (02.40)', getGeslachtsnaam(ouder)],
                ['aktenummer (81.20)', `1A${erkenningsType}0100`]
            ], dataTable)
        );
    }

    const data = [
        ['burgerservicenummer (01.20)', getBsn(kind)],
        ['geslachtsnaam (02.40)', getGeslachtsnaam(kind)],
        ['aktenummer (81.20)', `1A${erkenningsType}0100`]
    ];

    if (kindData.geboorte_datum) {
        data.push(['geboortedatum (03.10)', kindData.geboorte_datum]);
    }

    createKind(
        ouder,
        arrayOfArraysToDataTable(data)
    )
}

function createKindData(kind, aktenr) {
    let retval = [];

    retval.push(['aktenummer (81.20)', aktenr]);

    return retval;
}

function createOuderData(kind, ouder, aktenummer, datumErkenning) {
    let retval = createKindData(kind, aktenummer);

    retval.push(['datum ingang familierechtelijke betrekking (62.10)', datumErkenning]);
 
    return retval;
}

function createKindEnWijzigOuder(kind, ouder, ouderType, aktenummer, datumErkenning) {
    const ouderData = persoonPropertiesToArrayofArrays(ouder).concat(createOuderData(kind, ouder, aktenummer, datumErkenning));
    if(kind[`ouder-${ouderType}`]) {
        wijzigOuder(kind, ouderType, arrayOfArraysToDataTable(ouderData));
    }
    else {
        createOuder(kind, ouderType, arrayOfArraysToDataTable(ouderData));
    }

    if(ouder) {
        const kindData = persoonPropertiesToArrayofArrays(kind).concat(createKindData(kind, aktenummer));
        createKind(ouder, arrayOfArraysToDataTable(kindData));
    }
}

function gegevenDePersoonIsBijGeboorteaangifteErkendDoor(context, aanduiding, aanduidingOuder) {
    gegevenDePersoonIsErkend(context, aanduiding, aanduidingOuder, ErkenningsType.ErkenningBijGeboorteaangifte, undefined);
}

function kindHeeftGeenOuders(kind) {
    return !kind['ouder-1'] && !kind['ouder-2'];
}

function gegevenDePersoonIsErkend(context, persoonAanduiding, ouderAanduiding, erkenningsType, datumErkenning) {
    const kind = getPersoon(context, persoonAanduiding);
    if (!kind) {
        global.logger.error(`persoon ${persoonAanduiding} niet gevonden`);
        return;
    }

    const ouder = getPersoon(context, ouderAanduiding);
    if (!ouder) {
        global.logger.error(`ouder ${ouderAanduiding} niet gevonden`);
        return;
    }

    const datum = erkenningsType == ErkenningsType.ErkenningBijGeboorteaangifte ? getGeboortedatum(kind) : datumErkenning;
    const ouderType = kindHeeftGeenOuders(kind) ? '1' : '2';
    const aktenummer = genereerAktenummer(erkenningsType);

    const kindData = persoonPropertiesToArrayofArrays(kind, [ 'akte_nr', 'doc_beschrijving' ]);
    kindData.push(['aktenummer (81.20)', aktenummer]);

    createKindEnWijzigOuder(kind, ouder, ouderType, aktenummer, datum);

    wijzigPersoon(
        kind,
        arrayOfArraysToDataTable(kindData)
    );
}

module.exports = {
    gegevenDePersoonIsBijGeboorteaangifteErkendDoor
};