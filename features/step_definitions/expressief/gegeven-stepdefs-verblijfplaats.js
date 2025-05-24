const { Given } = require('@cucumber/cucumber');
const { createVerblijfplaats, wijzigVerblijfplaats, aanvullenInschrijving } = require('../persoon-2');
const { getPersoon } = require('../contextHelpers');
const { arrayOfArraysToDataTable } = require('../dataTableFactory');
const { toDateOrString, toBRPDate } = require('../brpDatum');
const { selectFirstOrDefault } = require('../postgresqlHelpers-2');

function gegevenDePersoonIsIngeschrevenInGemeente(context, aanduiding, dataTable) {
    createVerblijfplaats(
        getPersoon(context, aanduiding),
        dataTable
    );
}

function gegevenDePersoonIsIngeschrevenInDeBrp(context, aanduiding) {
    gegevenDePersoonIsIngeschrevenInGemeente(
        context,
        aanduiding,
        arrayOfArraysToDataTable([
            ['gemeente van inschrijving (09.10)', '0518']
        ])
    );
}

function gegevenDePersoonIsIngeschrevenInDeRni(context, aanduiding) {
    gegevenDePersoonIsIngeschrevenInGemeente(
        context,
        aanduiding,
        arrayOfArraysToDataTable([
            ['gemeente van inschrijving (09.10)', '1999']
        ])
    );
}

Given(/^de gemeente heeft vastgesteld dat de minderjarige niet op het adres verblijft$/, function () {
    const codeVanGemeente = '0518';
    const aanduidingInOnderzoek = '089999';

    wijzigVerblijfplaats(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['gemeente van inschrijving (09.10)', codeVanGemeente],
            ['aanduiding in onderzoek (83.10)', aanduidingInOnderzoek]
        ]),
        false
    );
});

Given(/^(?:(?:de persoon )?'(.*)' )?is (.*) geïmmigreerd naar Nederland$/, function (aanduiding, relatieveDatum) {
    let brpDatum = toDateOrString(relatieveDatum);
    const gemeenteVanInschrijving = '0518';

    const data = [
        ['datum vestiging in Nederland (14.20)', brpDatum],
        ['gemeente van inschrijving (09.10)', gemeenteVanInschrijving]
    ];

    let vestigingLandCode;
    const huidigeVerblijfplaats = getPersoon(this.context, aanduiding).verblijfplaats;
    if (huidigeVerblijfplaats?.[0]?.vertrek_land_code) {
        vestigingLandCode = huidigeVerblijfplaats[0].vertrek_land_code;
        data.push(['land vanwaar ingeschreven (14.10)', vestigingLandCode]);
    }

    wijzigVerblijfplaats(
        getPersoon(this.context, aanduiding),
        arrayOfArraysToDataTable(data),
        false
    );
});

Given(/^(?:(?:de persoon )?'(.*)' )?is (.*) geëmigreerd naar (.*)$/, async function (aanduiding, relatieveDatum, landNaam) {
    let brpDatum = toDateOrString(relatieveDatum);
    let codeVanLand = await selectFirstOrDefault('lo3_land', ['land_code'], 'land_naam', landNaam, '6030');
    let gemeenteVanInschrijving = '1999';

    wijzigVerblijfplaats(
        getPersoon(this.context, aanduiding),
        arrayOfArraysToDataTable([
            ['land adres buitenland (13.10)', codeVanLand],
            ['datum aanvang adres buitenland (13.20)', brpDatum],
            ['gemeente van inschrijving (09.10)', gemeenteVanInschrijving]
        ]),
        false
    );
});

Given(/^(?:de persoon(?: '(.*)')? )?is niet geëmigreerd geweest$/, function (_) {
    // doe niets
});

Given(/^(?:de persoon(?: '(.*)')? )?is geëmigreerd geweest met de volgende gegevens?$/, function (_, dataTable) {
    createVerblijfplaats(this.context, dataTable);
});

Given(/^(?:de persoon(?: '(.*)')? )?is geëmigreerd geweest?$/, function (_) {
    const datumVestiging = 'vandaag - 1 jaar';
    const gemeenteVanInschrijving = '0518';

    wijzigVerblijfplaats(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['datum vestiging in Nederland (14.20)', datumVestiging],
            ['gemeente van inschrijving (09.10)', gemeenteVanInschrijving]
        ]),
        false
    );
});

Given(/^heeft een onbekende verblijfplaats$/, function () {
    const persoon = getPersoon(this.context, undefined);
    const verblijfplaats = persoon.verblijfplaats;

    if (verblijfplaats) {
        wijzigVerblijfplaats(
            getPersoon(this.context, undefined),
            undefined,
            false
        );
    } else {
        // Verblijfplaats is al onbekend
    }
});

Given(/^heeft een onbekende gemeente van inschrijving$/, function () {
    wijzigVerblijfplaats(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['gemeente van inschrijving (09.10)', '']
        ]),
        false
    );
});

/**
 * Op dit moment wordt standaard landcode 6014 gebruikt.
 * Deze gegeven stap is voor testen waar het niet relevant naar welk land de persoon is geëmigreerd,
 * alleen dat de persoon is geëmigreerd.
 */
Given(/^is geëmigreerd naar het buitenland/, function () {
    const verblijfplaats = arrayOfArraysToDataTable([
        ['land vanwaar ingeschreven (14.10)', '6014'],
        ['datum aanvang adres buitenland (13.20)', '01012023'],
        ['datum vestiging in Nederland (14.20)', ''],
        ['gemeente van inschrijving (09.10)', '0518']
    ])
    wijzigVerblijfplaats(
        getPersoon(this.context, undefined),
        verblijfplaats
    );
});

Given(/^verblijft in Nederland/, function () {
    const verblijfplaats = arrayOfArraysToDataTable([
        ['datum vestiging in Nederland (14.20)', 'vandaag - 1 jaar'],
        ['gemeente van inschrijving (09.10)', '0518']
    ])
    createVerblijfplaats(
        getPersoon(this.context, undefined),
        verblijfplaats
    );
});

Given(/^(?:de persoon(?: '(.*)')? )?is op (\d*)-(\d*)-(\d*) geïmmigreerd?$/, function (aanduiding, dag, maand, jaar) {
    const datumVestiging = toBRPDate(dag, maand, jaar);
    const gemeenteVanInschrijving = '0518';

    wijzigVerblijfplaats(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['datum vestiging in Nederland (14.20)', datumVestiging],
            ['gemeente van inschrijving (09.10)', gemeenteVanInschrijving]
        ]),
        false
    );
});

Given(/^is ingeschreven in een Nederlandse gemeente$/, function () {
    gegevenDePersoonIsIngeschrevenInDeBrp(this.context, undefined);
});

Given(/^is ingeschreven als niet-ingezetene met een verblijfplaats in België$/, function () {
    const codeVanGemeente = '1999';
    const codeVanLand = '5010';

    gegevenDePersoonIsIngeschrevenInGemeente(
        this.context,
        undefined,
        arrayOfArraysToDataTable([
            ['gemeente van inschrijving (09.10)', codeVanGemeente],
            ['land adres buitenland (13.10)', codeVanLand]
        ])
    );
});

Given(/^is ingeschreven als niet-ingezetene met een volledig onbekende verblijfplaats$/, function () {
    const codeVanGemeente = '1999';
    const codeVanLand = '0000';

    gegevenDePersoonIsIngeschrevenInGemeente(
        this.context,
        undefined,
        arrayOfArraysToDataTable([
            ['gemeente van inschrijving (09.10)', codeVanGemeente],
            ['land adres buitenland (13.10)', codeVanLand]
        ])
    );
});

Given(/^is ingeschreven in de BRP$/, function () {
    gegevenDePersoonIsIngeschrevenInDeBrp(this.context, undefined);
});

Given(/^is niet ingeschreven in de BRP$/, function () {
    gegevenDePersoonIsIngeschrevenInDeRni(this.context, undefined);
});

Given('is ingeschreven in de BRP/RNI met de volgende gegevens', function (dataTable) {
    gegevenDePersoonIsIngeschrevenInGemeente(this.context, undefined, dataTable);
});

Given(/^is ingeschreven in de RNI$/, function () {
    gegevenDePersoonIsIngeschrevenInDeRni(this.context, undefined);
});

Given(/^is ingeschreven in de RNI met een verblijfplaats in België$/, function () {
    const codeVanGemeente = '1999';
    const codeVanLand = '5010';

    gegevenDePersoonIsIngeschrevenInGemeente(
        this.context,
        undefined,
        arrayOfArraysToDataTable([
            ['gemeente van inschrijving (09.10)', codeVanGemeente],
            ['land adres buitenland (13.10)', codeVanLand]
        ])
    );
});

module.exports = {
    gegevenDePersoonIsIngeschrevenInGemeente,
    gegevenDePersoonIsIngeschrevenInDeBrp
}

Given('is ingeschreven met een tijdelijke verblijfplaats in Nederland', function () {
    // Later desgewenst invullen, wanneer we iets doen met tijdelijke verblijfplaats
});

Given('{vandaag, gisteren of morgen x jaar geleden} is geconstateerd dat {aanduiding} behoort tot de categorie NAVO-militair', function(relatieveDatum, aanduidingPersoon) {
    const redenOpschorting = 'M';

    const verblijfplaats = arrayOfArraysToDataTable([
        ['gemeente van inschrijving (09.10)', '0518'],
        ['land adres buitenland (13.10)', '0000'],
        ['datum aanvang adres buitenland (13.20)', relatieveDatum],
        ['aangifte adreshouding (72.10)', 'B']
    ]);

    const persoon = getPersoon(this.context, aanduidingPersoon)

    if (!persoon.verblijfplaats || persoon.verblijfplaats==[]) {
        createVerblijfplaats(persoon, verblijfplaats);
    } else {
        wijzigVerblijfplaats(persoon, verblijfplaats, false);
    }

    aanvullenInschrijving(
        persoon,
        arrayOfArraysToDataTable([
            ['datum opschorting bijhouding (67.10)', relatieveDatum],
            ['reden opschorting bijhouding (67.20)', redenOpschorting]
        ])
    );
});