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

const elementNrBurgerservicenummer = '10120';
const elementNrFunctieAdres = '81010';
const elementNrGemeenteVanInschrijving = '80910';
const elementNrDatumAanvangAdreshouding = '81030';
const elementNrKorteStraatnaam = '81110';
const elementNrOfficieleStraatnaam = '81115';
const elementNrHuisnummer = '81120';
const elementNrHuisletter = '81130';
const elementNrHuisnummertoevoeging = '81140';
const elementNrAanduidingBijHuisnummer = '81150';
const elementNrPostcode = '81160';
const elementNrWoonplaats = '81170';
const elementNrAdresseerbaarObjectIdentificatie = '81180';
const elementNrNummeraanduidingIdentificatie = '81190';
const elementNrLocatiebeschrijving = '81210';
const elementNrDatumAanvangAdresBuitenland = '81320';
const elementNrDatumIngangGeldigheidVerblijfplaats = '88510';
const elementNrGezag = 'PAGZ01';

const verblijfadresBinnenlandElementen = `${elementNrKorteStraatnaam} ${elementNrOfficieleStraatnaam} ${elementNrHuisnummer} ${elementNrHuisletter} ${elementNrHuisnummertoevoeging} ${elementNrAanduidingBijHuisnummer} ${elementNrPostcode} ${elementNrWoonplaats} ${elementNrLocatiebeschrijving}`;
const verblijfplaatsBinnenlandElementen = `${elementNrFunctieAdres} ${elementNrDatumAanvangAdreshouding} ${verblijfadresBinnenlandElementen} ${elementNrAdresseerbaarObjectIdentificatie} ${elementNrNummeraanduidingIdentificatie} ${elementNrDatumIngangGeldigheidVerblijfplaats}`;

function mapFieldsToAdHocRubrieken(fields) {
    switch(fields) {
        case 'gezag':
            return `${elementNrBurgerservicenummer} ${elementNrAdresseerbaarObjectIdentificatie} ${elementNrGezag}`;
        case 'verblijfplaats.adresseerbaarObjectIdentificatie':
            return `${elementNrBurgerservicenummer} ${elementNrAdresseerbaarObjectIdentificatie}`;
        case 'verblijfplaats.datumVan':
            return `${elementNrBurgerservicenummer} ${elementNrDatumAanvangAdreshouding} ${elementNrDatumAanvangAdresBuitenland}`;
        case 'verblijfplaats.verblijfadres.korteStraatnaam':
            return `${elementNrBurgerservicenummer} ${elementNrKorteStraatnaam} ${elementNrAdresseerbaarObjectIdentificatie}`;
        case 'verblijfplaats.verblijfadres.officieleStraatnaam':
            return `${elementNrBurgerservicenummer} ${elementNrOfficieleStraatnaam} ${elementNrAdresseerbaarObjectIdentificatie}`;
        case 'verblijfplaatsBinnenland':
            return `${elementNrBurgerservicenummer} ${verblijfplaatsBinnenlandElementen}`;
        case 'verblijfplaatsBinnenland.datumVan':
            return `${elementNrBurgerservicenummer} ${elementNrDatumAanvangAdreshouding}`;
        default:
            return '';
    }
}

function createAfnemerAutorisatie(context, afnemerCode, gemeenteCode, fields) {
    context.afnemerID = afnemerCode;
    if(gemeenteCode) {
        context.gemeenteCode = gemeenteCode;
    }

    if(!context.data) {
        context.data = {};
    }
    if(!context.data.autorisaties) {
        context.data.autorisaties = [];
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

    context.data.autorisaties.push(autorisatie);
}

Given('een nieuwe/bestaande afnemer met indicatie {string} is geautoriseerd voor het vragen van {string}', function (afnemerCode, fields) {
    createAfnemerAutorisatie(this.context, afnemerCode, undefined, fields);
});

Given('een nieuwe/bestaande afnemer met indicatie {string} en gemeente code {string} is geautoriseerd voor het vragen van {string}', function (afnemerCode, gemeenteCode, fields) {
    createAfnemerAutorisatie(this.context, afnemerCode, gemeenteCode, fields);
});

Given('een nieuwe/bestaande afnemer met indicatie {string} is geautoriseerd voor het vragen van alle \'verblijfplaats binnenland\' velden', function (afnemerCode) {
    createAfnemerAutorisatie(this.context, afnemerCode, undefined, 'verblijfplaatsBinnenland');
});
