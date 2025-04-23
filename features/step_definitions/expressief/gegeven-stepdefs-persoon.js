const { Given } = require('@cucumber/cucumber');
const { arrayOfArraysToDataTable } = require('../dataTableFactory');
const { createPersoon, aanvullenPersoon } = require('../persoon-2');
const { getPersoon } = require('../contextHelpers');

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