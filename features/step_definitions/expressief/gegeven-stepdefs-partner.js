const { Given } = require('@cucumber/cucumber');
const { createPartner, wijzigPartner } = require('../persoon-2');
const { getPersoon, getBsn, persoonPropertiesToArrayofArrays } = require('../contextHelpers');
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

function gegevenDePersonenZijnGehuwdOfGeregistreerdPartnerschap(context, aanduiding1, aanduiding2, datumVerbintenis, plaatsVerbintenis, landVerbintenis, soortVerbintenis, dataTable) {
    const verbintenisData = arrayOfArraysToDataTable([
        ['datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)', datumVerbintenis],
        ['plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)', plaatsVerbintenis],
        ['land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)', landVerbintenis],
        ['soort verbintenis (15.10)', soortVerbintenis]
    ], dataTable);

    gegevenDePersonenZijnGehuwd(context, aanduiding1, aanduiding2, verbintenisData);
}

Given('{aanduiding} en {aanduiding} zijn (met elkaar ){soort verbintenis}', function (aanduiding1, aanduiding2, soortVerbintenis) {
    gegevenDePersonenZijnGehuwdOfGeregistreerdPartnerschap(this.context, aanduiding1, aanduiding2,
         'gisteren - 20 jaar', '0518', '6030', soortVerbintenis);
});

function gegevenDePersonenZijnOpDatumGehuwdOfGeregistreerdPartnerschap(aanduiding1, aanduiding2, datumVerbintenis, soortVerbintenis) {
    gegevenDePersonenZijnGehuwdOfGeregistreerdPartnerschap(this.context, aanduiding1, aanduiding2,
         datumVerbintenis, '0518', '6030', soortVerbintenis);
}

Given('{aanduiding} en {aanduiding} zijn (met elkaar ){vandaag, gisteren of morgen x jaar geleden} (opnieuw ){soort verbintenis}', gegevenDePersonenZijnOpDatumGehuwdOfGeregistreerdPartnerschap);
Given('{aanduiding} en {aanduiding} zijn (met elkaar ){vandaag, gisteren of morgen - x jaar} (opnieuw ){soort verbintenis}', gegevenDePersonenZijnOpDatumGehuwdOfGeregistreerdPartnerschap);
Given('{aanduiding} en {aanduiding} zijn (met elkaar ){relatieve datum} (opnieuw ){soort verbintenis}', gegevenDePersonenZijnOpDatumGehuwdOfGeregistreerdPartnerschap);
Given('{aanduiding} en {aanduiding} zijn (opnieuw ){soort verbintenis} {dd-mm-yyyy datum}', function(aanduiding1, aanduiding2, soortVerbintenis, datum) {
    gegevenDePersonenZijnGehuwdOfGeregistreerdPartnerschap(this.context, aanduiding1, aanduiding2,
         datum, '0518', '6030', soortVerbintenis);
});

Given('{aanduiding} en {aanduiding} zijn (met elkaar ){soort verbintenis} met de volgende gegevens', function (aanduiding1, aanduiding2, soortVerbintenis, dataTable) {
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

Given('{aanduiding} en {aanduiding} zijn gescheiden', function (aanduiding1, aanduiding2) {
    gegevenGescheidenOpDatum.call(this, aanduiding1, aanduiding2, 'gisteren - 1 jaar')
});

Given('{aanduiding} en {aanduiding} zijn (op ){dd-mm-yyyy datum} gescheiden', gegevenGescheidenOpDatum);
Given('{aanduiding} en {aanduiding} zijn (op ){dd maand yyyy datum} gescheiden', gegevenGescheidenOpDatum);
Given('{aanduiding} en {aanduiding} zijn {vandaag, gisteren of morgen x jaar geleden} gescheiden', gegevenGescheidenOpDatum);
Given('{aanduiding} en {aanduiding} zijn {vandaag, gisteren of morgen - x jaar} gescheiden', gegevenGescheidenOpDatum);

function gegevenGescheidenOpDatum(aanduidingPartner1, aanduidingPartner2, datum) {
    const plaatsScheiding = '0518';
    const landScheiding = '6030';
    const redenScheiding = 'S';

    const scheidingData = arrayOfArraysToDataTable([
        ['datum ontbinding huwelijk/geregistreerd partnerschap (07.10)', datum],
        ['plaats ontbinding huwelijk/geregistreerd partnerschap (07.20)', plaatsScheiding],
        ['land ontbinding huwelijk/geregistreerd partnerschap (07.30)', landScheiding],
        ['reden ontbinding huwelijk/geregistreerd partnerschap (07.40)', redenScheiding],
        ['soort verbintenis (15.10)', VerbintenisSoort.Huwelijk]
    ]);

    gegevenDePersonenZijnGescheiden(this.context, aanduidingPartner1, aanduidingPartner2, scheidingData);
}

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

// bij nietig verklaring wordt datum ontbinding gelijk aan datum huwelijkssluiting en wordt datum ingang geldigheid de datum van nietigverklaring
Given(/^het huwelijk van '(.*)' en '(.*)' is (.*) nietig verklaard$/, function (aanduiding1, aanduiding2, relatieveDatum) {
    const persoon1 = getPersoon(this.context, aanduiding1);
    const persoon2 = getPersoon(this.context, aanduiding2);
    const partner1 = { ...getPartnerActueleGegevens(persoon1, getBsn(persoon2)) };

    const scheidingData = arrayOfArraysToDataTable([
        ['datum ontbinding huwelijk/geregistreerd partnerschap (07.10)', partner1.relatie_start_datum],
        ['plaats ontbinding huwelijk/geregistreerd partnerschap (07.20)', partner1.relatie_start_plaats],
        ['land ontbinding huwelijk/geregistreerd partnerschap (07.30)', partner1.relatie_start_land_code],
        ['reden ontbinding huwelijk/geregistreerd partnerschap (07.40)', 'N'],
        ['soort verbintenis (15.10)', VerbintenisSoort.Huwelijk],
        ['datum ingang geldigheid (85.10)', relatieveDatum]
    ])

    gegevenDePersonenZijnGescheiden(this.context, aanduiding1, aanduiding2, scheidingData);
});

module.exports = {
    gegevenDePersonenZijnGehuwd
};
