const { Given } = require('@cucumber/cucumber');
const { createAutorisatie,
        createGegevensgroepAutorisatie } = require('./autorisatie');

Given(/^de afnemer met indicatie '(.*)' heeft de volgende 'autorisatie' gegevens$/, function (afnemerCode, dataTable) {
    createAutorisatie(this.context, afnemerCode, dataTable);
});

Given(/^de afnemer met indicatie '(.*)' is geautoriseerd voor '(.*)' gegevens$/, function (afnemerCode, gegevensgroep) {
    createGegevensgroepAutorisatie(this.context, afnemerCode, gegevensgroep);
});

Given(/^de geauthenticeerde consumer heeft de volgende 'claim' gegevens$/, function (dataTable) {
    this.context.afnemerID = dataTable.hashes()[0].naam !== undefined
        ? dataTable.hashes().find(param => param.naam === 'afnemerID').waarde
        : dataTable.hashes()[0].afnemerID;

        this.context.gemeenteCode = dataTable.hashes()[0].naam !== undefined
        ? dataTable.hashes().find(param => param.naam === 'gemeenteCode')?.waarde
        : dataTable.hashes()[0].gemeenteCode;
});

function mapFieldsToAdHocRubrieken(fields) {
    switch(fields) {
        case 'gezag':
            return '10120 81180 PAGZ01'; // burgerservicenummer, adresseerbaarObjectIdentificatie, gezag
        default:
            return '';
    }
}

Given('een nieuwe/bestaande afnemer met indicatie {string} is geautoriseerd voor het vragen van {string}', function (afnemerCode, fields) {
    if(!this.context.data) {
        this.context.data = {};
    }
    if(!this.context.data.autorisaties) {
        this.context.data.autorisaties = [];
    }

    const autorisatie = {
        autorisatie: {
            afnemer_code: afnemerCode,
            geheimhouding_ind: 0,
            verstrekkings_beperking: 0,
            afnemer_naam: 'Haal Centraal',
            adres_vraag_bevoegdheid: 1,
            ad_hoc_medium: 'N',
            tabel_regel_start_datum: 20201128,
            ad_hoc_rubrieken: mapFieldsToAdHocRubrieken(fields)
        },
        id: `autorisatie-${afnemerCode}`
    }

    this.context.data.autorisaties.push(autorisatie);
});
