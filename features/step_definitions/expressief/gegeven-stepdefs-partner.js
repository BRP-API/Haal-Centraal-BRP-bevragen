const { Given } = require('@cucumber/cucumber');
const { createPartner, wijzigPartner } = require('../persoon-2');
const { getPersoon, getBsn } = require('../contextHelpers');
const { objectToDataTable, arrayOfArraysToDataTable } = require('../dataTableFactory');
const { toBRPDate } = require('../brpDatum');

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

const VerbintenisSoort = {
    Huwelijk: 'H',
    GeregistreerdPartnerschap: 'P'
}

function persoonPropertiesToArrayofArrays(persoon) {
    const retval = [];

    Object.keys(persoon.persoon.at(-1)).forEach(key => {
        if(!['pl_id', 'stapel_nr', 'volg_nr', 'persoon_type'].includes(key)) {
            retval.push([key, persoon.persoon.at(-1)[key]]);
        }
    });

    return retval;
}

function gegevenDePersonenZijnGehuwd(context, aanduiding1, aanduiding2, dataTable) {
    const persoon1 = getPersoon(context, aanduiding1);
    const persoon2 = getPersoon(context, aanduiding2);

    createPartner(
        getPersoon(context, aanduiding1),
        arrayOfArraysToDataTable(persoonPropertiesToArrayofArrays(persoon2), dataTable)
    );

    createPartner(
        getPersoon(context, aanduiding2),
        arrayOfArraysToDataTable(persoonPropertiesToArrayofArrays(persoon1), dataTable)
    );
}

function gegevenDePersonenZijnGehuwdGecorrigeerd(context, aanduiding1, aanduiding2, dataTable) {
    wijzigPartner(
        getPersoon(context, aanduiding1),
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(getPersoon(context, aanduiding2))],
            ['geslachtsnaam (02.40)', aanduiding2]
        ], dataTable),
        true,
        true,
        true,
        getBsn(getPersoon(context, aanduiding2))
    );

    wijzigPartner(
        getPersoon(context, aanduiding2),
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(getPersoon(context, aanduiding1))],
            ['geslachtsnaam (02.40)', aanduiding1]
        ], dataTable),
        true,
        true,
        true,
        getBsn(getPersoon(context, aanduiding1))
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
        ['soort verbintenis (15.10)', VerbintenisSoort.Huwelijk]
    ]);

    gegevenDePersonenZijnGehuwd(this.context, aanduiding1, aanduiding2, huwelijkData);
});

Given(/^'(.*)' en '(.*)' zijn een geregistreerd partnerschap aangegaan op (\d*)-(\d*)-(\d*)$/, function (aanduiding1, aanduiding2, dag, maand, jaar) {
    const datumHuwelijk = toBRPDate(dag, maand, jaar);
    const plaatsHuwelijk = '0518';
    const landHuwelijk = '6030';

    const huwelijkData = arrayOfArraysToDataTable([
        ['datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)', datumHuwelijk],
        ['plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)', plaatsHuwelijk],
        ['land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)', landHuwelijk],
        ['soort verbintenis (15.10)', VerbintenisSoort.GeregistreerdPartnerschap]
    ]);

    gegevenDePersonenZijnGehuwd(this.context, aanduiding1, aanduiding2, huwelijkData);
});

Given(/^'(.*)' en '(.*)' zijn (?!met elkaar)(.*) een geregistreerd partnerschap aangegaan$/, function (aanduiding1, aanduiding2, relatieveDatum) {
    const plaatsHuwelijk = '0518';
    const landHuwelijk = '6030';

    const huwelijkData = arrayOfArraysToDataTable([
        ['datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)', relatieveDatum],
        ['plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)', plaatsHuwelijk],
        ['land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)', landHuwelijk],
        ['soort verbintenis (15.10)', VerbintenisSoort.GeregistreerdPartnerschap]
    ]);

    gegevenDePersonenZijnGehuwd(this.context, aanduiding1, aanduiding2, huwelijkData);
});

Given(/^'(.*)' en '(.*)' zijn (?!met elkaar)(.*) gehuwd$/, function (aanduiding1, aanduiding2, relatieveDatum) {
    const plaatsHuwelijk = '0518';
    const landHuwelijk = '6030';

    const huwelijkData = arrayOfArraysToDataTable([
        ['datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)', relatieveDatum],
        ['plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)', plaatsHuwelijk],
        ['land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)', landHuwelijk],
        ['soort verbintenis (15.10)', VerbintenisSoort.Huwelijk]
    ]);

    gegevenDePersonenZijnGehuwd(this.context, aanduiding1, aanduiding2, huwelijkData);
});

Given(/^'(.*)' en '(.*)' zijn met elkaar gehuwd met de volgende gegevens$/, function (aanduiding1, aanduiding2, dataTable) {
    gegevenDePersonenZijnGehuwd(this.context, aanduiding1, aanduiding2, dataTable);
});

Given(/^beide ouders zijn nooit met elkaar getrouwd geweest en hebben nooit een geregistreerd partnerschap gehad$/, function () {
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
        ['soort verbintenis (15.10)', VerbintenisSoort.Huwelijk]
    ])

    gegevenDePersonenZijnGescheiden(this.context, aanduiding1, aanduiding2, scheidingData);
});

Given(/^'(.*)' en '(.*)' zijn (.*) gescheiden$/, function (aanduiding1, aanduiding2, relatieveDatum) {
    const plaatsScheiding = '0518';
    const landScheiding = '6030';

    const scheidingData = arrayOfArraysToDataTable([
        ['datum ontbinding huwelijk/geregistreerd partnerschap (07.10)', relatieveDatum],
        ['plaats ontbinding huwelijk/geregistreerd partnerschap (07.20)', plaatsScheiding],
        ['land ontbinding huwelijk/geregistreerd partnerschap (07.30)', landScheiding],
        ['soort verbintenis (15.10)', VerbintenisSoort.Huwelijk]
    ])

    gegevenDePersonenZijnGescheiden(this.context, aanduiding1, aanduiding2, scheidingData);
});

Given(/^'(.*)' en '(.*)' zijn gescheiden met de volgende gegevens$/, function (aanduiding1, aanduiding2, dataTable) {
    gegevenDePersonenZijnGescheiden(this.context, aanduiding1, aanduiding2, dataTable);
});

Given(/^is het huwelijk van '(.*)' en '(.*)' gecorrigeerd met de volgende gegevens$/, function (aanduiding1, aanduiding2, dataTable) {
    gegevenDePersonenZijnGehuwdGecorrigeerd(this.context, aanduiding1, aanduiding2, dataTable);
});

Given('het geregistreerd partnerschap van {string} en {string} is {dd-mm-yyyy datum} ontbonden', gegevenGeregistreerdPartnerschapIsOntbonden);
Given('het geregistreerd partnerschap van {string} en {string} is {dd maand yyyy datum} ontbonden', gegevenGeregistreerdPartnerschapIsOntbonden);
Given('het geregistreerd partnerschap van {string} en {string} is {vandaag, gisteren of morgen x jaar geleden} ontbonden', gegevenGeregistreerdPartnerschapIsOntbonden);
Given('het geregistreerd partnerschap van {string} en {string} is {vandaag, gisteren of morgen - x jaar} ontbonden', gegevenGeregistreerdPartnerschapIsOntbonden);
Given('het geregistreerd partnerschap van {string} en {string} is {deze-, vorige- of volgende maand - x jaar} ontbonden', gegevenGeregistreerdPartnerschapIsOntbonden);
Given('het geregistreerd partnerschap van {string} en {string} is {dit-, vorig- of volgend jaar - x jaar} ontbonden', gegevenGeregistreerdPartnerschapIsOntbonden);

function gegevenGeregistreerdPartnerschapIsOntbonden(aanduidingPartner1, aanduidingPartner2, datum) {
    const plaatsScheiding = '0518';
    const landScheiding = '6030';

    const scheidingData = arrayOfArraysToDataTable([
        ['datum ontbinding huwelijk/geregistreerd partnerschap (07.10)', datum],
        ['plaats ontbinding huwelijk/geregistreerd partnerschap (07.20)', plaatsScheiding],
        ['land ontbinding huwelijk/geregistreerd partnerschap (07.30)', landScheiding],
        ['soort verbintenis (15.10)', VerbintenisSoort.GeregistreerdPartnerschap]
    ]);

    gegevenDePersonenZijnGescheiden(this.context, aanduidingPartner1, aanduidingPartner2, scheidingData);
}