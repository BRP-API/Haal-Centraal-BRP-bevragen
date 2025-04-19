const { Given } = require('@cucumber/cucumber');
const { objectToDataTable, arrayOfArraysToDataTable } = require('./dataTableFactory');
const { aanvullenPersoon,
    wijzigPersoon,
    wijzigKind,
    wijzigOuder,
    wijzigPartner,
    aanvullenInschrijving,
    createOverlijden
} = require('./persoon-2');
const { getBsn, getGeboortedatum, getPersoon } = require('./contextHelpers');
const { toBRPDate, toDateOrString } = require('./brpDatum');

function getPartner(persoon) {
    let partner;

    Object.keys(persoon).forEach(property => {
        if (property.includes('partner')) {
            partner = persoon[property].at(-1);
        }
    });

    return partner;
}

function createOntbindingPartnerschap(context, aanduiding, dataTable) {
    let overledenPersoon = getPersoon(context, aanduiding);

    Object.keys(overledenPersoon).some(property => {
        if (property.includes('partner')) {
            const partner = { ...getPartner(overledenPersoon) };
            if (partner.relatie_start_datum) {
                const partnerPersoon = getPersoon(context, partner.geslachts_naam);
                wijzigPartner(partnerPersoon, dataTable);
                return true;
            }
        }
        return false;
    });
}

Given(/^(?:'(.*)' )?is minderjarig/, function (aanduiding) {
    const datumGeboorte = 'gisteren - 17 jaar';

    aanvullenPersoon(
        getPersoon(this.context, aanduiding),
        arrayOfArraysToDataTable([
            ['geboortedatum (03.10)', datumGeboorte]
        ])
    );

    global.logger.info(`gegeven persoon '${aanduiding}' is minderjarig`, getPersoon(this.context, aanduiding));
});

Given(/^is een (man|vrouw)/, function (geslacht) {
    let geslachtsAanduiding = geslacht === 'man' ? 'M' : 'V';

    aanvullenPersoon(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['geslachtsaanduiding (04.10)', geslachtsAanduiding]
        ])
    );

    global.logger.info(`gegeven persoon is een ${geslacht}`, getPersoon(this.context, undefined));
});

Given(/^is meerderjarig(?:, niet overleden en staat niet onder curatele)?$/, function () {
    const datumGeboorte = 'gisteren - 45 jaar';

    aanvullenPersoon(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['geboortedatum (03.10)', datumGeboorte]
        ])
    );

    global.logger.info(`gegeven persoon is meerderjarig`, getPersoon(this.context, undefined));
});

Given(/^(?:'(.*)' )?is overleden$/, function (aanduiding) {
    const datumOpschortingBijhouding = 'gisteren - 2 jaar';
    const redenOpschortingBijhouding = 'O';
    const datumOverlijden = 'gisteren - 2 jaar';
    const gemeenteCode = '0518';
    const landCode = '6030';

    aanvullenInschrijving(
        getPersoon(this.context, aanduiding),
        arrayOfArraysToDataTable([
            ['datum opschorting bijhouding (67.10)', datumOpschortingBijhouding],
            ['reden opschorting bijhouding (67.20)', redenOpschortingBijhouding]
        ])
    );

    createOverlijden(
        getPersoon(this.context, aanduiding),
        arrayOfArraysToDataTable([
            ['datum overlijden (08.10)', datumOverlijden]
        ])
    );

    createOntbindingPartnerschap(this.context, aanduiding,
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(getPersoon(this.context, aanduiding))],
            ['geslachtsnaam (02.40)', aanduiding],
            ['datum ontbinding huwelijk/geregistreerd partnerschap (07.10)', datumOverlijden],
            ['plaats ontbinding huwelijk/geregistreerd partnerschap (07.20)', gemeenteCode],
            ['land ontbinding huwelijk/geregistreerd partnerschap (07.30)', landCode],
            ['reden ontbinding huwelijk/geregistreerd partnerschap (07.40)', redenOpschortingBijhouding]
        ])
    );
});

Given(/^'(.*)' is overleden met de volgende gegevens$/, function (aanduiding, dataTable) {
    const datumOpschortingBijhouden = 'gisteren - 2 jaar';
    const redenOpschortingBijhouding = 'O';

    aanvullenInschrijving(
        getPersoon(this.context, aanduiding),
        arrayOfArraysToDataTable([
            ['datum opschorting bijhouding (67.10)', datumOpschortingBijhouden],
            ['reden opschorting bijhouding (67.20)', redenOpschortingBijhouding]
        ])
    );

    createOverlijden(
        getPersoon(this.context, aanduiding),
        dataTable
    );
});


Given(/^bijhouding van de persoonsgegevens van '(.*)' is opgeschort met de volgende gegevens$/, function (aanduiding, dataTable) {
    aanvullenInschrijving(
        getPersoon(this.context, aanduiding),
        dataTable
    );
});

Given(/^de persoonslijst van '(.*)' is opgeschort met reden '(.)'$/, function (aanduiding, redenOpschortingBijhouding) {
    const datumOpschortingBijhouden = 'gisteren - 2 jaar';

    aanvullenInschrijving(
        getPersoon(this.context, aanduiding),
        arrayOfArraysToDataTable([
            ['datum opschorting bijhouding (67.10)', datumOpschortingBijhouden],
            ['reden opschorting bijhouding (67.20)', redenOpschortingBijhouding]
        ])
    );
});

Given(/^heeft de volgende gegevens$/, function (dataTable) {
    aanvullenPersoon(
        getPersoon(this.context, undefined),
        dataTable
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

Given(/^beide ouders zijn meerderjarig, niet overleden en staan niet onder curatele$/, function () {
    // doe niets
});

/**
 * Op dit moment wordt standaard landcode 6003 gebruikt.
 * Deze gegeven stap is voor testen waar het niet relevant is uit welk land de persoon geadopteerd is,
 * alleen dat de persoon in het buitenland is geboren.
 */
Given(/^is geboren in het buitenland/, function () {
    const codeVanLand = '6003';

    aanvullenPersoon(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['geboorteland (03.30)', codeVanLand]
        ])
    );
});

Given(/^(?:'(.*)' )?is geboren op (\d*)-(\d*)-(\d*)$/, function (aanduiding, dag, maand, jaar) {
    aanvullenPersoon(
        getPersoon(this.context, aanduiding),
        arrayOfArraysToDataTable([
            ['geboortedatum (03.10)', toBRPDate(dag, maand, jaar)]
        ])
    );
});

// ontkenning

Given(/^(.*) heeft '(.*)' het ouderschap ontkend$/, function (relatieveDatum, aanduidingOuder) {
    let plKind = getPersoon(this.context, undefined);
    let plOuder = getPersoon(this.context, aanduidingOuder);

    wijzigKind(
        plOuder,
        arrayOfArraysToDataTable([
            ['aktenummer (81.20)', '1AE0100'],
        ]),
        true,
        getBsn(plKind),
    );

    let ouderType = 1;
    if (plKind['ouder-2']) {
        let tmp = plKind['ouder-2'][0];
        if (tmp.burger_service_nr === getBsn(plOuder)) {
            ouderType = 2;
        }
    }

    wijzigOuder(
        plKind,
        ouderType,
        arrayOfArraysToDataTable([
            ['aktenummer (81.20)', '1AE0100'],
            ['ingangsdatum geldigheid (85.10)', relatieveDatum],
        ]),
        true
    );

    global.logger.info(`Gegeven ${relatieveDatum} heeft '${aanduidingOuder}' het ouderschap ontkend`, getPersoon(this.context, undefined));
});

Given('{string} heeft ontkend vader te zijn van {string}', function (aanduidingOuder, aanduidingKind) {
    let plKind = getPersoon(this.context, aanduidingKind);
    let plOuder = getPersoon(this.context, aanduidingOuder);

    wijzigKind(
        plOuder,
        arrayOfArraysToDataTable([
            ['aktenummer (81.20)', '1AE0100'],
        ]),
        true,
        getBsn(plKind),
    );

    let ouderType = 1;
    if (plKind['ouder-2']) {
        let tmp = plKind['ouder-2'][0];
        if (tmp.burger_service_nr === getBsn(plOuder)) {
            ouderType = 2;
        }
    }

    wijzigOuder(
        plKind,
        ouderType,
        arrayOfArraysToDataTable([
            ['aktenummer (81.20)', '1AE0100'],
            ['ingangsdatum geldigheid (85.10)', getGeboortedatum(plKind)],
        ]),
        true
    );

    global.logger.info(`gegeven '${aanduidingOuder}' heeft ontkend vader te zijn`, getPersoon(this.context, undefined));
});