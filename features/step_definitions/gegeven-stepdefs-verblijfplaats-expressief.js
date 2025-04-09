const { Given } = require('@cucumber/cucumber');
const { getAdres,
        getAdresIndex,
        getPersoon } = require('./contextHelpers');
const { arrayOfArraysToDataTable } = require('./dataTableFactory');
const { createVerblijfplaats } = require('./persoon-2');

function gegevenPersonenZijnIngeschrevenOpAdres(context, aanduidingAdres, aanduidingPersoon, datumAanvangAdreshouding) {
    const data = [
        ['adres_id', getAdresIndex(context, aanduidingAdres) + ''],
        ['gemeente van inschrijving (09.10)', getAdres(context, aanduidingAdres).adres.gemeente_code],
        ['functie adres (10.10)', 'W'],
        ['datum aanvang adreshouding (10.30)', datumAanvangAdreshouding]
    ];

    createVerblijfplaats(getPersoon(context, aanduidingPersoon),
                         arrayOfArraysToDataTable(data));
}

function gegevenPersonenZijnOpDatumIngeschrevenOpAdres(persoonAanduidingen, datum, adresAanduiding) {
    for(const persoonAanduiding of persoonAanduidingen) {
        gegevenPersonenZijnIngeschrevenOpAdres(this.context, adresAanduiding, persoonAanduiding, datum);
    }
    global.logger.info(`gegeven persoon|personen '${persoonAanduidingen}' is|zijn op '${datum}' ingeschreven op adres '${adresAanduiding}'`, getPersoon(this.context, persoonAanduidingen[0]));
}

Given('persoon/personen {aanduidingen} is/zijn op/in {dd maand yyyy datum} ingeschreven op adres {string}', gegevenPersonenZijnOpDatumIngeschrevenOpAdres);
Given('{aanduidingen} is/zijn op/in {dd maand yyyy datum} ingeschreven op adres {string}', gegevenPersonenZijnOpDatumIngeschrevenOpAdres);
Given('persoon/personen {aanduidingen} is/zijn op {onbekende datum} ingeschreven op adres {string}', gegevenPersonenZijnOpDatumIngeschrevenOpAdres);
Given('{aanduidingen} is/zijn op {onbekende datum} ingeschreven op adres {string}', gegevenPersonenZijnOpDatumIngeschrevenOpAdres);
Given('persoon/personen {aanduidingen} is/zijn op {dd-mm-yyyy datum} ingeschreven op adres {string}', gegevenPersonenZijnOpDatumIngeschrevenOpAdres);
Given('{aanduidingen} is/zijn op {dd-mm-yyyy datum} ingeschreven op adres {string}', gegevenPersonenZijnOpDatumIngeschrevenOpAdres);
Given('persoon/personen {aanduidingen} is/zijn {vandaag, gisteren of morgen x jaar geleden} ingeschreven op adres {string}', gegevenPersonenZijnOpDatumIngeschrevenOpAdres);
Given('{aanduidingen} is/zijn {vandaag, gisteren of morgen x jaar geleden} ingeschreven op adres {string}', gegevenPersonenZijnOpDatumIngeschrevenOpAdres);
