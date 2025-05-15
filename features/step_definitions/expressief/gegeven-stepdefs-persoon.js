const { Given } = require('@cucumber/cucumber');
const { arrayOfArraysToDataTable } = require('../dataTableFactory');
const { createPersoon, aanvullenPersoon } = require('../persoon-2');
const { getPersoon } = require('../contextHelpers');
const { selectFirstOrDefault } = require('../postgresqlHelpers-2');
const { genereerAktenummer, AkteTypes, genereerBurgerservicenummer } = require('../generators');

function dataTableHasColumn(dataTable, columnName) {
    return dataTable?.raw()[0].includes(columnName);
}

function gegevenDePersoonMetBsn(context, aanduiding, burgerservicenummer, dataTable) {
    const persoon = aanduiding
        ? getPersoon(context, aanduiding)
        : undefined;

    if (persoon) {
        aanvullenPersoon(
            persoon,
            dataTable
        );
        global.logger.info(`persoon met '${aanduiding}'. Updaten met DataTable waarden`, dataTable);
    }
    else {
        const data = [];

        if (burgerservicenummer) {
            data.push(['burgerservicenummer (01.20)', burgerservicenummer]);
        }
        if (aanduiding && !dataTableHasColumn(dataTable, 'geslachtsnaam (02.40)')) {
            data.push(['geslachtsnaam (02.40)', aanduiding]);
        }
        if (aanduiding && burgerservicenummer && !dataTableHasColumn(dataTable, 'geboorteland (03.30)')) {
            const geboorteLandCode = '6030'; // Nederland
            data.push(['geboorteland (03.30)', geboorteLandCode]);
        }
        if (aanduiding && burgerservicenummer && !dataTableHasColumn(dataTable, 'aktenummer (81.20)')) {
            const akteNummer = '1AA0100'; // Geboorteakte
            data.push(['aktenummer (81.20)', akteNummer]);
        }

        createPersoon(
            context,
            aanduiding,
            arrayOfArraysToDataTable(data, dataTable)
        );
    }
}

Given(/^(?:de )?persoon '([a-zA-Z0-9]*)'(?: zonder burgerservicenummer)? heeft de volgende gegevens$/, function (aanduiding, dataTable) {
    gegevenDePersoonMetBsn(this.context, aanduiding, undefined, dataTable);
});

Given(/^(?:de persoon(?: '(.*)')? )?met burgerservicenummer '(\d*)'$/, function (aanduiding, burgerservicenummer) {
    gegevenDePersoonMetBsn(this.context, aanduiding, burgerservicenummer, undefined);
});

Given(/^(?:de persoon(?: '(.*)')? )?zonder burgerservicenummer$/, function (aanduiding) {
    gegevenDePersoonMetBsn(this.context, aanduiding, undefined, undefined);
});

function gegevenDePersoon(context, persoonAanduiding, burgerservicenummer, geboortedatum, geboortelandCode, geslachtsaanduiding, dataTable) {
    const data = [
        ['geslachtsnaam (02.40)', persoonAanduiding]
    ];
    if(burgerservicenummer) {
        data.push(['burgerservicenummer (01.20)', burgerservicenummer]);
    }
    if(geboortedatum) {
        data.push(['geboortedatum (03.10)', geboortedatum]);
    }
    if(geslachtsaanduiding) {
        data.push(['geslachtsaanduiding (04.10)', geslachtsaanduiding]);
    }
    if(geboortelandCode) {
        data.push(['geboorteland (03.30)', geboortelandCode]);

        if(geboortelandCode == '6030') {
            data.push(['aktenummer (81.20)', genereerAktenummer(AkteTypes.Geboorte)]);
        }
        else {
            data.push(['beschrijving document (82.30)', 'buitenlandse geboorteakte']);
        }
    }

    createPersoon(context, persoonAanduiding, arrayOfArraysToDataTable(data, dataTable));
}

async function gegevenDeOpDatumInLandGeborenPersoon(geboortedatum, omschrijvingLand, geslachtsaanduiding, persoonAanduiding, burgerservicenummer) {
    const geboortelandCode = omschrijvingLand ? await selectFirstOrDefault('lo3_land', ['land_code'], 'land_naam', omschrijvingLand, undefined) : undefined;

    gegevenDePersoon(this.context, persoonAanduiding, burgerservicenummer, geboortedatum, geboortelandCode, geslachtsaanduiding, undefined);
}

async function gegevenDeMeerderjarigePersoonZonderBsn(geslachtsAanduiding, persoonAanduiding) {
    gegevenDePersoon(this.context, persoonAanduiding, undefined, 'gisteren - 45 jaar', undefined, geslachtsAanduiding, undefined);
}

Given('de {vandaag, gisteren of morgen x jaar geleden} in (de )(het ){string} geboren {geslachtsaanduiding}( ){string} met burgerservicenummer {string}', gegevenDeOpDatumInLandGeborenPersoon);
Given('de {dd maand yyyy datum} in (de )(het ){string} geboren {geslachtsaanduiding}( ){string} met burgerservicenummer {string}', gegevenDeOpDatumInLandGeborenPersoon);
Given('de {onbekende datum} in (de )(het ){string} geboren {geslachtsaanduiding}( ){string} met burgerservicenummer {string}', gegevenDeOpDatumInLandGeborenPersoon);
Given('de {dd-mm-yyyy datum} in (de )(het ){string} geboren {geslachtsaanduiding}( ){string} met burgerservicenummer {string}', gegevenDeOpDatumInLandGeborenPersoon);

Given('de meerderjarige {geslachtsaanduiding}( ){string} zonder burgerservicenummer', gegevenDeMeerderjarigePersoonZonderBsn);

function gegevenDeOpDatumInNederlandGeborenPersoonMetGegenereerdeBsn(geboortedatum, geslachtsaanduiding, persoonAanduiding) {
    gegevenDePersoon(this.context, persoonAanduiding, genereerBurgerservicenummer(this.context), geboortedatum, '6030', geslachtsaanduiding, undefined);
}

Given('de {vandaag, gisteren of morgen x jaar geleden} geboren {geslachtsaanduiding}( ){string}', gegevenDeOpDatumInNederlandGeborenPersoonMetGegenereerdeBsn);
Given('de {dd maand yyyy datum} geboren {geslachtsaanduiding}( ){string}', gegevenDeOpDatumInNederlandGeborenPersoonMetGegenereerdeBsn);
Given('de {onbekende datum} geboren {geslachtsaanduiding}( ){string}', gegevenDeOpDatumInNederlandGeborenPersoonMetGegenereerdeBsn);
Given('de {dd-mm-yyyy datum} geboren {geslachtsaanduiding}( ){string}', gegevenDeOpDatumInNederlandGeborenPersoonMetGegenereerdeBsn);

Given('de persoon {aanduiding}', function (aanduiding) {
    gegevenDePersoon(this.context, aanduiding, genereerBurgerservicenummer(this.context), undefined, undefined, undefined, undefined);
});

module.exports = {
    gegevenDePersoon
};
