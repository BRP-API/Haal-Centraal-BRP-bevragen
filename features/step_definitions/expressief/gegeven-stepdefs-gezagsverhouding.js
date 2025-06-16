const { Given } = require('@cucumber/cucumber');
const { getPersoon } = require('../contextHelpers');
const { createGezagsverhouding, aanvullenGezagsverhouding, wijzigGezagsverhouding } = require('../persoon-2');
const { arrayOfArraysToDataTable } = require('../dataTableFactory');

Given(/^voor '(.*)' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens$/, function (aanduiding, dataTable) {
    createGezagsverhouding(
        getPersoon(this.context, aanduiding),
        dataTable
    );
});

function setPersoonOnderCuratele(persoonAanduiding) {
    const curateleRegisterIndicatie = '1';

    aanvullenGezagsverhouding(
        getPersoon(this.context, persoonAanduiding),
        arrayOfArraysToDataTable([
            ['indicatie curateleregister (33.10)', curateleRegisterIndicatie]
        ])
    );
}

Given('{string} staat onder curatele', setPersoonOnderCuratele);
Given('staat onder curatele', function() {
    setPersoonOnderCuratele.call(this, undefined);
});

const IndicatieGezag = {
    Ouder1: '1',
    Ouder2: '2',
    BeideOuders: '12',
    VoogdijInstelling: 'D',
    Derde: 'D',
    Ouder1Derde: '1D',
    Ouder2Derde: '2D'
}

function createGerechtelijkeUitspraak(context, datum, indicatieGezag) {
    if(!datum) {
        datum = 'gisteren - 1 jaar';
    }

    createGezagsverhouding(
        getPersoon(context, undefined),
        arrayOfArraysToDataTable([
            ['indicatie gezag minderjarige (32.10)', indicatieGezag],
            ['datum ingang geldigheid (85.10)', datum]
        ])
    );
}

Given('in een gerechtelijke uitspraak is het gezag toegewezen aan {string}', function (persoonAanduiding) {
    createGerechtelijkeUitspraak(this.context, undefined, getIndicatieGezagVoorPersoonEnDerde(this.context, persoonAanduiding, false));
});

function uitspraakGezagEenOuderOpDatum(relatieveDatum, persoonAanduiding) {
    createGerechtelijkeUitspraak(this.context, relatieveDatum, getIndicatieGezagVoorPersoonEnDerde(this.context, persoonAanduiding, false));
}

Given('{dd-mm-yyyy datum} is in een gerechtelijke uitspraak het gezag toegewezen aan {string}', uitspraakGezagEenOuderOpDatum);
Given('{vandaag, gisteren of morgen x jaar geleden} is in een gerechtelijke uitspraak het gezag toegewezen aan {string}', uitspraakGezagEenOuderOpDatum);
Given('{relatieve datum} is in een gerechtelijke uitspraak het gezag toegewezen aan {string}', uitspraakGezagEenOuderOpDatum);

Given('in een gerechtelijke uitspraak is het gezag toegewezen aan {string} en een derde', function (persoonAanduiding) {
    createGerechtelijkeUitspraak(this.context, undefined, getIndicatieGezagVoorPersoonEnDerde(this.context, persoonAanduiding, true));
});

function uitspraakGezagOuderEnDerdeOpDatum(relatieveDatum, persoonAanduiding) {
    createGerechtelijkeUitspraak(this.context, relatieveDatum, getIndicatieGezagVoorPersoonEnDerde(this.context, persoonAanduiding, true));
}

Given('{dd-mm-yyyy datum} is in een gerechtelijke uitspraak het gezag toegewezen aan {string} en een derde', uitspraakGezagOuderEnDerdeOpDatum);
Given('{vandaag, gisteren of morgen x jaar geleden} is in een gerechtelijke uitspraak het gezag toegewezen aan {string} en een derde', uitspraakGezagOuderEnDerdeOpDatum);
Given('{dd-mm-yyyy datum} is in een gerechtelijke uitspraak het gezag toegewezen aan ouder {string} en een derde', uitspraakGezagOuderEnDerdeOpDatum);
Given('{vandaag, gisteren of morgen x jaar geleden} is in een gerechtelijke uitspraak het gezag toegewezen aan ouder {string} en een derde', uitspraakGezagOuderEnDerdeOpDatum);

Given('in een gerechtelijke uitspraak is het gezag toegewezen aan beide ouders', function () {
    createGerechtelijkeUitspraak(this.context, undefined, IndicatieGezag.BeideOuders);
});

function uitspraakGezagBeideOudersOpDatum(relatieveDatum) {
    createGerechtelijkeUitspraak(this.context, relatieveDatum, IndicatieGezag.BeideOuders);
};

Given('{dd-mm-yyyy datum} is in een gerechtelijke uitspraak het gezag toegewezen aan beide ouders', uitspraakGezagBeideOudersOpDatum);
Given('{vandaag, gisteren of morgen x jaar geleden} is in een gerechtelijke uitspraak het gezag toegewezen aan beide ouders', uitspraakGezagBeideOudersOpDatum);

Given('{vandaag, gisteren of morgen x jaar geleden} is in een nieuwe gerechtelijke uitspraak het gezag toegewezen aan beide ouders', function (relatieveDatum) {
    let indicatieGezag = IndicatieGezag.BeideOuders;

    wijzigGezagsverhouding(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['indicatie gezag minderjarige (32.10)', indicatieGezag],
            ['datum ingang geldigheid (85.10)', relatieveDatum],
        ])
    )
});

Given('in een gerechtelijke uitspraak is een {word} tot voogd benoemd', function (gezaghebbende) {
    createGerechtelijkeUitspraak(this.context, undefined, getIndicatieGezagVoorInstellingOfDerde(gezaghebbende));
});

function uitspraakGezagDerdeOpDatum(relatieveDatum, gezaghebbende) {
    createGerechtelijkeUitspraak(this.context, relatieveDatum, getIndicatieGezagVoorInstellingOfDerde(gezaghebbende));
}

Given('{dd-mm-yyyy datum} is in een gerechtelijke uitspraak het gezag toegewezen aan een {word}', uitspraakGezagDerdeOpDatum);
Given('{vandaag, gisteren of morgen x jaar geleden} is in een gerechtelijke uitspraak het gezag toegewezen aan een {word}', uitspraakGezagDerdeOpDatum);
Given('{vandaag, gisteren of morgen - x jaar} is in een gerechtelijke uitspraak het gezag toegewezen aan een {word}', uitspraakGezagDerdeOpDatum);

function getIndicatieGezagVoorPersoonEnDerde(context, aanduiding, toewijzingDerde = false) {
    let plKind = getPersoon(context, undefined);
    let plKindOuder1 = plKind['ouder-1'].filter((voorkomen) => voorkomen.volg_nr == 0);
    let plKindOuder2 = plKind['ouder-2'].filter((voorkomen) => voorkomen.volg_nr == 0);

    if (plKindOuder1) {
        plKindOuder1 = plKindOuder1[0];
        if (plKindOuder1.geslachts_naam == aanduiding) {
            return toewijzingDerde
                ? IndicatieGezag.Ouder1Derde
                : IndicatieGezag.Ouder1;
        }
    }

    if (plKindOuder2) {
        plKindOuder2 = plKindOuder2[0];
        if (plKindOuder2.geslachts_naam == aanduiding) {
            return toewijzingDerde
                ? IndicatieGezag.Ouder2Derde
                : IndicatieGezag.Ouder2;
        }
    }
}

function getIndicatieGezagVoorInstellingOfDerde(gezaghebbende) {
    return (gezaghebbende == 'voogdijinstelling')
        ? IndicatieGezag.VoogdijInstelling
        : IndicatieGezag.Derde;
}