const { Given } = require('@cucumber/cucumber');
const { objectToDataTable, arrayOfArraysToDataTable } = require('../dataTableFactory');
const { createOuder, createKind, wijzigPersoon, wijzigGeadopteerdPersoon, wijzigOuder, aanvullenPersoon } = require('../persoon-2');
const { getPersoon,
        getPersoonMetAanduiding,
        getBsn,
        getGeslachtsnaam,
        getGeboortedatum,
        getGeslachtsaanduiding,
        getAkteNr,
        getBeschrijvingDocument,
        persoonPropertiesToArrayofArrays } = require('../contextHelpers');
const { toBRPDate } = require('../brpDatum');
const { toDbColumnName } = require('../brp');
const { genereerAktenummer, AkteTypes } = require('../generators');

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
        if(kind[`ouder-${ouderType}`]) {
            wijzigOuder(
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
        else{
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
    gegevenDePersoonIsGeadopteerdOpDatum(this.context, aanduidingKind, aanduidingOuder, undefined, datum);
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
    const datum = '10 jaar geleden';
    gegevenDePersoonIsGeadopteerdOpDatum(this.context, aanduidingKind, aanduidingOuder1, aanduidingOuder2, datum);
}

function gegevenIsGeadopteerdOpDatumMetBeideOuders(aanduidingKind, datum, aanduidingOuder1, aanduidingOuder2) {
    gegevenDePersoonIsGeadopteerdOpDatum(this.context, aanduidingKind, aanduidingOuder1, aanduidingOuder2, datum);
}

function gegevenIsGeadopteerdOpDatumMetBeideOudersInBuitenland(aanduidingKind, aanduidingOuder1, aanduidingOuder2, datum, documentBeschrijving) {
    gegevenDePersoonIsGeadopteerdOpDatum(this.context, aanduidingKind, aanduidingOuder1, aanduidingOuder2, datum, documentBeschrijving);
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
    const adoptieDatum = toBRPDate(dag, maand, jaar);

    gegevenDePersoonIsGeadopteerdOpDatum(this.context, aanduidingKind, aanduidingOuder1, aanduidingOuder2, adoptieDatum);
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

function createAdoptieData(aktenummer, isAdoptieInBuitenland) {
    return [isAdoptieInBuitenland ? 'beschrijving document (82.30)' : 'aktenummer (81.20)', aktenummer];
}

function createKindData(kind, aktenr, isAdoptieInBuitenland) {
    let retval = [];

    retval.push(createAdoptieData(aktenr, isAdoptieInBuitenland));

    return retval;
}

function createOuderData(kind, ouder, datumAdoptie, aktenummer, isAdoptieInBuitenland) {
    let retval = createKindData(kind, aktenummer, isAdoptieInBuitenland);

    retval.push([
        ouder
            ? 'datum ingang familierechtelijke betrekking (62.10)'
            : 'datum ingang geldigheid (85.10)',
        datumAdoptie]);

    return retval;
}

function createLegeOuderData(kind) {
    let retval = [];

    const aktenr = getAkteNr(kind);
    if(aktenr) {
        retval.push(['aktenummer (81.20)', aktenr]);
    }

    const docBeschrijving = getBeschrijvingDocument(kind);
    if(docBeschrijving) {
        retval.push(['beschrijving document (82.30)', docBeschrijving]);
    }

    const geboorteDatum = getGeboortedatum(kind);
    if(geboorteDatum) {
        retval.push([ 'datum ingang geldigheid (85.10)', geboorteDatum]);
    }

    return retval;
}

function createKindEnOuder(kind, ouder, ouderType, datumAdoptie, aktenummer, isAdoptieInBuitenland) {
    const ouderData = ouder
     ? persoonPropertiesToArrayofArrays(ouder).concat(createOuderData(kind, ouder, datumAdoptie, aktenummer, isAdoptieInBuitenland))
     : createLegeOuderData(kind);
    if(kind[`ouder-${ouderType}`]) {
        wijzigOuder(kind, ouderType, arrayOfArraysToDataTable(ouderData));
    }
    else {
        createOuder(kind, ouderType, arrayOfArraysToDataTable(ouderData));
    }

    if(ouder) {
        const kindData = persoonPropertiesToArrayofArrays(kind).concat(createKindData(kind, aktenummer, isAdoptieInBuitenland));
        createKind(ouder, arrayOfArraysToDataTable(kindData));
    }
}

function kindHeeftGeenOuders(kind) {
    return !kind['ouder-1'] && !kind['ouder-2'];
}

function kindHeeftEenOuder(kind) {
    return kind['ouder-1'] && kind['ouder-1'][0]['geslachts_naam'] !== '.';
}

function gegevenDePersoonIsGeadopteerdOpDatum(context, persoonAanduiding, ouderAanduiding1, ouderAanduiding2, datumAdoptie, buitenlandseAdoptieDocumentBeschrijving) {
    const kind = getPersoonMetAanduiding(context, persoonAanduiding);
    if (!kind) {
        return;
    }

    const ouder1 = getPersoonMetAanduiding(context, ouderAanduiding1);
    if (!ouder1) {
        return;
    }

    let ouder2 = ouderAanduiding2 ? getPersoon(context, ouderAanduiding2) : undefined;
    if (ouderAanduiding2 && !ouder2) {
        return;
    }

    const isAdoptieInBuitenland = buitenlandseAdoptieDocumentBeschrijving !== undefined;
    const aktenummer = isAdoptieInBuitenland ? buitenlandseAdoptieDocumentBeschrijving : genereerAktenummer(AkteTypes.Adoptie);

    if (kindHeeftGeenOuders(kind) ||
        (kindHeeftEenOuder(kind) && ouder1 && ouder2)) {
        createKindEnOuder(kind, ouder1, '1', datumAdoptie, aktenummer, isAdoptieInBuitenland);
        createKindEnOuder(kind, ouder2, '2', datumAdoptie, aktenummer, isAdoptieInBuitenland);
    }
    else if (kindHeeftEenOuder(kind) && !ouder2) {
        createKindEnOuder(kind, ouder1, '2', datumAdoptie, aktenummer, isAdoptieInBuitenland);
    }
    else {
        createKindEnOuder(kind, ouder1, '1', datumAdoptie, aktenummer, isAdoptieInBuitenland);
    }

    const kindData = persoonPropertiesToArrayofArrays(kind, [ 'akte_nr', 'doc_beschrijving' ]);
    kindData.push(createAdoptieData(aktenummer, isAdoptieInBuitenland));
    wijzigPersoon(
        kind,
        arrayOfArraysToDataTable(kindData)
    );
}

module.exports = {
    gegevenDePersoonIsGeadopteerdOpDatum
};
