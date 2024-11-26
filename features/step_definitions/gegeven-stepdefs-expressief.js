const { Given, DataTable } = require('@cucumber/cucumber');
const { objectToDataTable, arrayOfArraysToDataTable } = require('./dataTableFactory');
const { createPersoon,
        aanvullenPersoon,
        wijzigPersoon,
        createKind,
        createOuder,
        wijzigOuder,
        createPartner,
        wijzigPartner,
        createGezagsverhouding,
        aanvullenGezagsverhouding,
        createVerblijfplaats,
        aanvullenInschrijving,
        createOverlijden
} = require('./persoon-2');
const { toDbColumnName } = require('./brp');

const { toDateOrString } = require('./brpDatum');

function getPersoon(context, aanduiding) {
    return !aanduiding
        ? context.data.personen.at(-1)
        : context.data.personen.find(p => p.id === `persoon-${aanduiding}`);
}

function getBsn(persoon) {
    return persoon.persoon.at(-1).burger_service_nr;
}

function getGeslachtsnaam(persoon) {
    return persoon.persoon.at(-1).geslachts_naam;
}

function deleteHuwelijkProperties(entiteit) {
    delete entiteit.relatie_start_datum;
    delete entiteit.relatie_start_plaats;
    delete entiteit.relatie_start_land_code;
}

function getPartnerActueleGegevens(persoon, bsnPartner) {
    let partner;

    Object.keys(persoon).forEach(property => {
        if (property.includes('partner') &&
            persoon[property].at(-1).burger_service_nr === bsnPartner) {
            partner = persoon[property].at(-1);
        }
    });

    return partner;
}

/**
 * Expressieve Gegeven-stappen voor Persoon
 */

function gegevenDePersoonMetBsn(context, aanduiding, burgerservicenummer, dataTable) {
    const data = [
        ['burgerservicenummer (01.20)', burgerservicenummer],
    ];
    if (aanduiding) {
        data.push(['geslachtsnaam (02.40)', aanduiding]);
    }

    createPersoon(
        context,
        aanduiding,
        arrayOfArraysToDataTable(data, dataTable)
    );
}

Given(/^(?:de persoon(?: '(.*)')? )?met burgerservicenummer '(\d*)'$/, function (aanduiding, burgerservicenummer) {
    gegevenDePersoonMetBsn(this.context, aanduiding, burgerservicenummer, undefined);
});

Given(/^is minderjarig/, function () {
    const datumGeboorte = 'gisteren - 17 jaar';

    aanvullenPersoon(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['geboortedatum (03.10)', datumGeboorte]
        ])
    );
});

Given(/^is meerderjarig(?:, niet overleden en staat niet onder curatele)?$/, function () {
    const datumGeboorte = 'gisteren - 45 jaar';

    aanvullenPersoon(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['geboortedatum (03.10)', datumGeboorte]
        ])
    );
});

Given(/^is in Nederland geboren/, function () {
    const landGeboorte = '6030';
    const nummerAkte = '1AA0100';

    aanvullenPersoon(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['geboorteland (03.30)', landGeboorte],
            ['aktenummer (81.20)', nummerAkte]
        ])
    );
});

Given(/^heeft gezag uitspraak$/, function (dataTable) {
    createGezagsverhouding(
        getPersoon(this.context, undefined),
        dataTable
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

Given(/^is overleden/, function () {
    const datumOpschortingBijhouden = 'gisteren - 2 jaar';
    const indicatieGeheim = 'O';
    const datumOverlijden = 'gisteren - 2 jaar';

    aanvullenInschrijving(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['datum opschorting bijhouding (67.10)', datumOpschortingBijhouden],
            ['reden opschorting bijhouding (67.20)', indicatieGeheim]
        ])
    );

    createOverlijden(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['datum overlijden (08.10)', datumOverlijden]
        ])
    );
});

Given(/^zijn de volgende gegevens gewijzigd$/, function (dataTable) {
    const persoon = getPersoon(this.context, undefined);

    const persoonData = { ...persoon[`persoon`].at(-1) };

    wijzigPersoon(
        persoon,
        objectToDataTable(persoonData, dataTable)
    );
});

Given(/^zijn de volgende gegevens gecorrigeerd$/, function (dataTable) {
    const persoon = getPersoon(this.context, undefined);

    const persoonData = { ...persoon[`persoon`].at(-1) };

    wijzigPersoon(
        persoon,
        objectToDataTable(persoonData, dataTable),
        true
    );
});

/**
 * Expressieve Gegeven-stappen voor Partner
 */

function gegevenDePersonenZijnGehuwd(context, aanduiding1, aanduiding2, dataTable) {
    createPartner(
        getPersoon(context, aanduiding1),
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(getPersoon(context, aanduiding2))],
            ['geslachtsnaam (02.40)', aanduiding2]
        ], dataTable)
    );

    createPartner(
        getPersoon(context, aanduiding2),
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(getPersoon(context, aanduiding1))],
            ['geslachtsnaam (02.40)', aanduiding1]
        ], dataTable)
    );
}

Given(/^'(.*)' en '(.*)' zijn met elkaar gehuwd$/, function (aanduiding1, aanduiding2) {
    const datumHuwelijk = 'gisteren - 20 jaar';
    const plaatsHuwelijk = '0518';
    const landHuwelijk = '6030';

    const huwelijkData = arrayOfArraysToDataTable([
        ['datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)', datumHuwelijk],
        ['plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)', plaatsHuwelijk],
        ['land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)', landHuwelijk],
    ]);

    gegevenDePersonenZijnGehuwd(this.context, aanduiding1, aanduiding2, huwelijkData);
});

Given(/^'(.*)' en '(.*)' zijn met elkaar gehuwd met de volgende gegevens$/, function (aanduiding1, aanduiding2, dataTable) {
    gegevenDePersonenZijnGehuwd(this.context, aanduiding1, aanduiding2, dataTable);
});

Given('beide ouders zijn nooit met elkaar getrouwd geweest en hebben nooit een geregistreerd partnerschap gehad', function () {
    // doe niets
});

function gegevenDePersonenZijnGescheiden(context, aanduiding1, aanduiding2, dataTable) {
    const persoon1 = getPersoon(context, aanduiding1);
    const persoon2 = getPersoon(context, aanduiding2);

    const partner1 = { ...getPartnerActueleGegevens(persoon1, getBsn(persoon2)) };
    deleteHuwelijkProperties(partner1);

    wijzigPartner(
        persoon1,
        objectToDataTable(partner1, dataTable)
    );

    const partner2 = { ...getPartnerActueleGegevens(persoon2, getBsn(persoon1)) };
    deleteHuwelijkProperties(partner2);

    wijzigPartner(
        persoon2,
        objectToDataTable(partner2, dataTable)
    );
}

Given(/^'(.*)' en '(.*)' zijn gescheiden$/, function (aanduiding1, aanduiding2) {
    const datumScheiding = 'gisteren - 1 jaar';
    const plaatsScheiding = '0518';
    const landScheiding = '6030';

    const scheidingData = arrayOfArraysToDataTable([
        ['datum ontbinding huwelijk/geregistreerd partnerschap (07.10)', datumScheiding],
        ['plaats ontbinding huwelijk/geregistreerd partnerschap (07.20)', plaatsScheiding],
        ['land ontbinding huwelijk/geregistreerd partnerschap (07.30)', landScheiding],
    ])

    gegevenDePersonenZijnGescheiden(this.context, aanduiding1, aanduiding2, scheidingData);
});

Given(/^'(.*)' en '(.*)' zijn gescheiden met de volgende gegevens$/, function (aanduiding1, aanduiding2, dataTable) {
    gegevenDePersonenZijnGescheiden(this.context, aanduiding1, aanduiding2, dataTable);
});

Given(/^is het huwelijk van '(.*)' en '(.*)' gecorrigeerd/, function (aanduiding1, aanduiding2, dataTable) {
    return 'pending';
});

/**
 * Expressieve Gegeven-stappen voor Ouder
 */

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
        ])
    )
}

Given(/^heeft '(.*)' als ouder ([1-2])$/, function (aanduiding, ouderType) {
    const ouderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', 'gisteren - 17 jaar']
    ]);

    gegevenHeeftPersoonAlsOuder(this.context, aanduiding, ouderType, ouderData);
});

Given(/^heeft '(.*)' als ouder ([1-2]) met de volgende gegevens$/, function (aanduiding, ouderType, dataTable) {
    gegevenHeeftPersoonAlsOuder(this.context, aanduiding, ouderType, dataTable);
});

function gegevenIsGeadopteerdDoorPersoonAlsOuder(context, aanduiding, ouderType, dataTable) {
    const kind = getPersoon(context, undefined);
    const ouder = getPersoon(context, aanduiding);

    const kindData = { ...kind.persoon.at(-1) };
    kindData[toDbColumnName('aktenummer (81.20)')] = '1AQ0100'

    wijzigPersoon(
        kind,
        objectToDataTable(kindData)
    );

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
        ])
    )
}

Given(/^is geadopteerd door '(.*)' als ouder ([1-2])$/, function (aanduiding, ouderType) {
    const adoptieOuderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', 'morgen - 4 jaar']
    ]);

    gegevenIsGeadopteerdDoorPersoonAlsOuder(this.context, aanduiding, ouderType, adoptieOuderData);
});

Given(/^is geadopteerd door '(.*)' als ouder ([1-2]) met de volgende gegevens$/, function (aanduiding, ouderType, dataTable) {
    gegevenIsGeadopteerdDoorPersoonAlsOuder(this.context, aanduiding, ouderType, dataTable);
});

Given(/^zijn van ouder ([1-2]) de volgende gegevens gewijzigd$/, function (ouderType, dataTable) {
    const persoon = getPersoon(this.context, undefined);

    const ouderData = { ...persoon[`ouder-${ouderType}`].at(-1) };

    wijzigOuder(
        persoon,
        ouderType,
        objectToDataTable(ouderData, dataTable),
        false
    );
});

Given(/^zijn van ouder ([1-2]) de volgende gegevens gecorrigeerd$/, function (ouderType, dataTable) {
    const persoon = getPersoon(this.context, undefined);

    const ouderData = { ...persoon[`ouder-${ouderType}`].at(-1) };

    wijzigOuder(
        persoon,
        ouderType,
        objectToDataTable(ouderData, dataTable),
        true
    );
});

Given(/^beide ouders zijn meerderjarig, niet overleden en staan niet onder curatele/, function () {
    // doe niets
});

/**
 * Expressieve Gegeven-stappen voor Verblijfplaats
 */


Given(/^(?:de persoon(?: '(.*)')? )?is ingeschreven in de BRP?$/, function (_) {
    const gemeenteVanInschrijving = '0518';

    createVerblijfplaats(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['gemeente van inschrijving (09.10)', gemeenteVanInschrijving]
        ])
    );
});

Given(/^(?:de persoon(?: '(.*)')? )?is ingeschreven in de RNI/, function (_) {
    const gemeenteVanInschrijving = '1999';

    createVerblijfplaats(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['gemeente van inschrijving (09.10)', gemeenteVanInschrijving]
        ])
    );
});

Given(/^(?:de persoon(?: '(.*)')? )?is niet geëmigreerd geweest/, function (_) {
    // doe niets
});

Given(/^(?:de persoon(?: '(.*)')? )?is geëmigreerd geweest met de volgende gegevens?$/, function (_, dataTable) {
    createVerblijfplaats(this.context, dataTable);
});

Given(/^(?:de persoon(?: '(.*)')? )?is geëmigreerd geweest?$/, function (_) {
    const datumVestiging = 'vandaag - 1 jaar';

    createVerblijfplaats(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['datum vestiging in Nederland (14.20)', datumVestiging]
        ]));
});