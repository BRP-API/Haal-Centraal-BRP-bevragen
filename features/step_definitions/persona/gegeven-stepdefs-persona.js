const { Given } = require('@cucumber/cucumber');
const { arrayOfArraysToDataTable } = require('../dataTableFactory');
const { aanvullenInschrijving } = require('../persoon-2');
const { getPersoon,
        wijzigPersoonContext } = require('../contextHelpers');
const { gegevenDePersoon } = require('../expressief/gegeven-stepdefs-persoon');
const { gegevenDePersoonIsIngeschrevenInGemeente,
        gegevenDePersoonIsIngeschrevenInDeBrp } = require('../expressief/gegeven-stepdefs-verblijfplaats');
const { gegevenDePersoonHeeftAlsOuders } = require('../expressief/gegeven-stepdefs-ouder');
const { gegevenDePersonenZijnGehuwd } = require('../expressief/gegeven-stepdefs-partner');
const { gegevenDePersoonIsBijGeboorteaangifteErkendDoor } = require('../expressief/gegeven-stepdefs-erkenning');
const { gegevenDePersoonIsGeadopteerdOpDatum } = require('../expressief/gegeven-stepdefs-adoptie');

// **************************************************************************************************************
//                     default gevulde personen als startpunt van een scenario
// **************************************************************************************************************

const ouder1Burgerservicenummer        = '000000101'
const ouder2Burgerservicenummer        = '000000102'
const persoonBurgerservicenummer       = '000000103'
const adoptieOuder1Burgerservicenummer = '000000104'
const adoptieOuder2Burgerservicenummer = '000000105'
const partnerBurgerservicenummer       = '000000106'

const geboortedatumMinderjarige  = 'gisteren - 16 jaar'
const geboortedatumMeerderjarige = 'morgen - 37 jaar'

const defaultLandCode = '6030';

function gegevenDePersonenZijnInNederlandGehuwd(context, aanduiding1, aanduiding2) {
  const huwelijkData = [
    ['datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)', 'gisteren - 20 jaar'],
    ['plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)', '0518'],
    ['land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)', '6030'],
    ['soort verbintenis (15.10)', 'H'],
    ['aktenummer (81.20)', '3XA1224']
  ]
  gegevenDePersonenZijnGehuwd(context, aanduiding1, aanduiding2, arrayOfArraysToDataTable(huwelijkData));
}

const vanuitBuitenlandVerblijfplaatsData = [
  ['gemeente van inschrijving (09.10)', '0518'],
  ['land vanwaar ingeschreven (14.10)', '6029'],
  ['datum vestiging in Nederland (14.20)', 'gisteren - 5 jaar'],
];

function minderjarigePersoonMetOngehuwdeOuders(geboortedatum, aanduidingPersoon, aanduidingOuder1, aanduidingOuder2) {
  gegevenDePersoon(this.context, aanduidingOuder1, ouder1Burgerservicenummer, geboortedatumMeerderjarige, defaultLandCode, 'V');
  gegevenDePersoon(this.context, aanduidingOuder2, ouder2Burgerservicenummer, geboortedatumMeerderjarige, defaultLandCode, 'M');

  gegevenDePersoon(this.context, aanduidingPersoon, persoonBurgerservicenummer, geboortedatum, defaultLandCode, 'M');
  gegevenDePersoonIsIngeschrevenInDeBrp(this.context, aanduidingPersoon);
  gegevenDePersoonHeeftAlsOuders(this.context, aanduidingPersoon, aanduidingOuder1, aanduidingOuder2);

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
}

// dit is een in Nederland geboren minderjarige met een moeder en een vader die nooit met elkaar gehuwd waren, minderjarige is als ongeboren vrucht erkend
Given('de {meer- of minderjarige} persoon {string} met twee ouders {string} en {string} die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren', minderjarigePersoonMetOngehuwdeOuders);
Given('de {vandaag, gisteren of morgen x jaar geleden} geboren persoon {string} met twee ouders {string} en {string} die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren', minderjarigePersoonMetOngehuwdeOuders);
Given('de (op ){dd maand yyyy datum} geboren persoon {string} met twee ouders {string} en {string} die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren', minderjarigePersoonMetOngehuwdeOuders);
Given('de (op ){dd-mm-yyyy datum} geboren persoon {string} met twee ouders {string} en {string} die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren', minderjarigePersoonMetOngehuwdeOuders);
Given('de {onbekende datum} geboren persoon {string} met twee ouders {string} en {string} die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren', minderjarigePersoonMetOngehuwdeOuders);
Given('de {relatieve datum} geboren persoon {string} met twee ouders {string} en {string} die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren', minderjarigePersoonMetOngehuwdeOuders);

Given('de {meer- of minderjarige} persoon {string} met twee ongehuwde ouders {string} en {string}', minderjarigePersoonMetOngehuwdeOuders);
Given('de {vandaag, gisteren of morgen x jaar geleden} geboren persoon {string} met twee ongehuwde ouders {string} en {string}', minderjarigePersoonMetOngehuwdeOuders);
Given('de (op ){dd maand yyyy datum} geboren persoon {string} met twee ongehuwde ouders {string} en {string}', minderjarigePersoonMetOngehuwdeOuders);
Given('de (op ){dd-mm-yyyy datum} geboren persoon {string} met twee ongehuwde ouders {string} en {string}', minderjarigePersoonMetOngehuwdeOuders);
Given('de {onbekende datum} geboren persoon {string} met twee ongehuwde ouders {string} en {string}', minderjarigePersoonMetOngehuwdeOuders);
Given('de {relatieve datum} geboren persoon {string} met twee ongehuwde ouders {string} en {string}', minderjarigePersoonMetOngehuwdeOuders);

function minderjarigePersoonMetGehuwdeOuders(geboortedatum, aanduidingPersoon, aanduidingOuder1, aanduidingOuder2) {
  gegevenDePersoon(this.context, aanduidingOuder1, ouder1Burgerservicenummer, geboortedatumMeerderjarige, defaultLandCode, 'V');
  gegevenDePersoon(this.context, aanduidingOuder2, ouder2Burgerservicenummer, geboortedatumMeerderjarige, defaultLandCode, 'M');
  gegevenDePersonenZijnInNederlandGehuwd(this.context, aanduidingOuder1, aanduidingOuder2);

  gegevenDePersoon(this.context, aanduidingPersoon, persoonBurgerservicenummer, geboortedatum, defaultLandCode, 'M');
  gegevenDePersoonIsIngeschrevenInDeBrp(this.context, aanduidingPersoon);
  gegevenDePersoonHeeftAlsOuders(this.context, aanduidingPersoon, aanduidingOuder1, aanduidingOuder2);

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
}

// dit is een in Nederland geboren minderjarige met een moeder en een vader die met elkaar gehuwd zijn
Given('de {meer- of minderjarige} persoon {string} met twee gehuwde ouders {string} en {string}', minderjarigePersoonMetGehuwdeOuders);
Given('de {vandaag, gisteren of morgen x jaar geleden} geboren persoon {string} met twee gehuwde ouders {string} en {string}', minderjarigePersoonMetGehuwdeOuders);
Given('de (op ){dd maand yyyy datum} geboren persoon {string} met twee gehuwde ouders {string} en {string}', minderjarigePersoonMetGehuwdeOuders);
Given('de (op ){dd-mm-yyyy datum} geboren persoon {string} met twee gehuwde ouders {string} en {string}', minderjarigePersoonMetGehuwdeOuders);
Given('de {onbekende datum} geboren persoon {string} met twee gehuwde ouders {string} en {string}', minderjarigePersoonMetGehuwdeOuders);
Given('de {relatieve datum} geboren persoon {string} met twee gehuwde ouders {string} en {string}', minderjarigePersoonMetGehuwdeOuders);

function minderjarigePersoonMetEenOuder(geboortedatum, aanduidingPersoon, aanduidingOuder1) {
  gegevenDePersoon(this.context, aanduidingOuder1, ouder1Burgerservicenummer, geboortedatumMeerderjarige, defaultLandCode, 'V');

  gegevenDePersoon(this.context, aanduidingPersoon, persoonBurgerservicenummer, geboortedatum, defaultLandCode, 'M');
  gegevenDePersoonIsIngeschrevenInDeBrp(this.context, aanduidingPersoon);
  gegevenDePersoonHeeftAlsOuders(this.context, aanduidingPersoon, aanduidingOuder1, undefined);

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
}

// dit is een in Nederland geboren minderjarige met een moeder die ongehuwd is en geen tweede ouder
Given('de {meer- of minderjarige} persoon {string} met één ouder {string}', minderjarigePersoonMetEenOuder);
Given('de {vandaag, gisteren of morgen x jaar geleden} geboren persoon {string} met één ouder {string}', minderjarigePersoonMetEenOuder);
Given('de (op ){dd maand yyyy datum} geboren persoon {string} met één ouder {string}', minderjarigePersoonMetEenOuder);
Given('de (op ){dd-mm-yyyy datum} geboren persoon {string} met één ouder {string}', minderjarigePersoonMetEenOuder);
Given('de {onbekende datum} geboren persoon {string} met één ouder {string}', minderjarigePersoonMetEenOuder);
Given('de {relatieve datum} geboren persoon {string} met één ouder {string}', minderjarigePersoonMetEenOuder);

// dit is een in Nederland geboren minderjarige met een moeder die gehuwd is en er is geen tweede ouder
Given('de minderjarige persoon {string} met één ouder {string} die gehuwd is met {string}', function(aanduidingPersoon, aanduidingOuder1, aanduidingPartner) {
  gegevenDePersoon(this.context, aanduidingOuder1, ouder1Burgerservicenummer, geboortedatumMeerderjarige, defaultLandCode, 'V');
  gegevenDePersoon(this.context, aanduidingPartner, ouder2Burgerservicenummer, geboortedatumMeerderjarige, defaultLandCode, 'V');
  gegevenDePersonenZijnInNederlandGehuwd(this.context, aanduidingOuder1, aanduidingPartner);

  gegevenDePersoon(this.context, aanduidingPersoon, persoonBurgerservicenummer, geboortedatumMinderjarige, defaultLandCode, 'M');
  gegevenDePersoonIsIngeschrevenInDeBrp(this.context, aanduidingPersoon);
  gegevenDePersoonHeeftAlsOuders(this.context, aanduidingPersoon, aanduidingOuder1, undefined);

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// dit is een in het buitenland geboren minderjarige met een moeder en een vader die met elkaar gehuwd zijn en het hele gezin is geïmmigreerd naar Nederland
Given('de minderjarige persoon {string} geboren in het buitenland met twee gehuwde ouders {string} en {string}', function (aanduidingPersoon, aanduidingOuder1, aanduidingOuder2) {
  const geboorteakteMoeder = [
    ['beschrijving document (82.30)', 'paspoort']
  ];

  const geboorteakteVader = [
    ['beschrijving document (82.30)', 'beëdigde verklaring']
  ];

  const huwelijkData = [
    ['datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)', 'gisteren - 20 jaar'],
    ['plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)', 'Teststadt'],
    ['land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)', '6029'],
    ['soort verbintenis (15.10)', 'H'],
    ['beschrijving document (82.30)', 'buitenlandse huwelijkseakte']
  ]

  gegevenDePersoon(this.context, aanduidingOuder1, ouder1Burgerservicenummer, geboortedatumMeerderjarige, '6029', 'V', arrayOfArraysToDataTable(geboorteakteMoeder));
  gegevenDePersoon(this.context, aanduidingOuder2, ouder2Burgerservicenummer, geboortedatumMeerderjarige, '6029', 'M', arrayOfArraysToDataTable(geboorteakteVader));
  gegevenDePersonenZijnGehuwd(this.context, aanduidingOuder1, aanduidingOuder2, arrayOfArraysToDataTable(huwelijkData));

  gegevenDePersoon(this.context, aanduidingPersoon, persoonBurgerservicenummer, geboortedatumMinderjarige, '6029', 'M');
  gegevenDePersoonIsIngeschrevenInGemeente(this.context, aanduidingPersoon, arrayOfArraysToDataTable(vanuitBuitenlandVerblijfplaatsData));
  gegevenDePersoonHeeftAlsOuders(this.context, aanduidingPersoon, aanduidingOuder1, aanduidingOuder2);

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// dit is een in het buitenland geboren minderjarige met een moeder en minderjarige en moeder zijn geïmmigreerd naar Nederland
Given('de minderjarige persoon {string} geboren in het buitenland met één ouder {string}', function (aanduidingPersoon, aanduidingOuder1) {
  const geboorteakteMoeder = [
    ['beschrijving document (82.30)', 'paspoort']
  ];

  gegevenDePersoon(this.context, aanduidingOuder1, ouder1Burgerservicenummer, geboortedatumMeerderjarige, '6029', 'V', arrayOfArraysToDataTable(geboorteakteMoeder));

  gegevenDePersoon(this.context, aanduidingPersoon, persoonBurgerservicenummer, geboortedatumMinderjarige, '6029', 'M');
  gegevenDePersoonIsIngeschrevenInGemeente(this.context, aanduidingPersoon, arrayOfArraysToDataTable(vanuitBuitenlandVerblijfplaatsData));
  gegevenDePersoonHeeftAlsOuders(this.context, aanduidingPersoon, aanduidingOuder1, undefined);

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// dit is een in het buitenland geboren minderjarige die is geadopteerd door één ouder
Given('de minderjarige persoon {string} geboren in het buitenland geadopteerd door één ouder {string}', function (aanduidingPersoon, aanduidingAdoptieouder) {
  const adoptiedatum = 'gisteren - 15 jaar'

  const geboorteakteMoeder = [
    ['beschrijving document (82.30)', 'paspoort']
  ];

  gegevenDePersoon(this.context, aanduidingAdoptieouder, adoptieOuder1Burgerservicenummer, geboortedatumMeerderjarige, '6029', 'V', arrayOfArraysToDataTable(geboorteakteMoeder));

  gegevenDePersoon(this.context, aanduidingPersoon, persoonBurgerservicenummer, geboortedatumMinderjarige, '6029', 'M');
  gegevenDePersoonIsIngeschrevenInGemeente(this.context, aanduidingPersoon, arrayOfArraysToDataTable(vanuitBuitenlandVerblijfplaatsData));
  gegevenDePersoonIsGeadopteerdOpDatum(this.context, aanduidingPersoon, aanduidingAdoptieouder, undefined, adoptiedatum);

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// dit is een in het buitenland geboren minderjarige met ouders die niet in de BRP of RNI staan
Given('de minderjarige persoon {string} geboren in het buitenland met niet-ingezeten ouders {string} en {string}', function (aanduidingPersoon, aanduidingOuder1, aanduidingOuder2) {
  const moederData = [
    ['voornamen (02.10)', 'Jane' ]
  ];

  const vaderData = [
    ['voornamen (02.10)', 'John' ]
  ];

  gegevenDePersoon(this.context, aanduidingOuder1, undefined, geboortedatumMeerderjarige, '6029', 'V', arrayOfArraysToDataTable(moederData));
  gegevenDePersoon(this.context, aanduidingOuder2, undefined, geboortedatumMeerderjarige, '6029', 'M', arrayOfArraysToDataTable(vaderData));

  gegevenDePersoon(this.context, aanduidingPersoon, persoonBurgerservicenummer, geboortedatumMinderjarige, '6029', 'M');
  gegevenDePersoonIsIngeschrevenInGemeente(this.context, aanduidingPersoon, arrayOfArraysToDataTable(vanuitBuitenlandVerblijfplaatsData));
  gegevenDePersoonHeeftAlsOuders(this.context, aanduidingPersoon, aanduidingOuder1, aanduidingOuder2);

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// dit is een minderjarige in RNI die nooit ingezetene is geweest
Given('de minderjarige persoon {string} die nooit ingezetene is geweest', function (aanduidingPersoon) {
  const verblijfplaatsData = [
    ['gemeente van inschrijving (09.10)', '1999']
  ];

  const deelnemerData = [
    ['rni-deelnemer (88.10)', '201']
  ];

  opschortingData = [
    ['datum opschorting bijhouding (67.10)', 'gisteren - 1 jaar'],
    ['reden opschorting bijhouding (67.20)', 'R']
  ];

  gegevenDePersoon(this.context, aanduidingPersoon, persoonBurgerservicenummer, geboortedatumMinderjarige, '6029', 'M', arrayOfArraysToDataTable(deelnemerData));
  gegevenDePersoonIsIngeschrevenInGemeente(this.context, aanduidingPersoon, arrayOfArraysToDataTable(verblijfplaatsData.concat(deelnemerData)));

  aanvullenInschrijving(
    getPersoon(this.context, aanduidingPersoon),
    arrayOfArraysToDataTable(opschortingData)
  );
});

function minderjarigeVondeling(geboortedatum, aanduidingPersoon) {
  gegevenDePersoon(this.context, '.', undefined, undefined, undefined, undefined);
  
  gegevenDePersoon(this.context, aanduidingPersoon, persoonBurgerservicenummer, geboortedatum, '6030', 'M');
  gegevenDePersoonIsIngeschrevenInDeBrp(this.context, aanduidingPersoon);
  gegevenDePersoonHeeftAlsOuders(this.context, aanduidingPersoon, '.', undefined);

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
}

// dit is een in Nederland geboren minderjarige die als vondeling geboren is: één onbekende ouder
Given('de {meer- of minderjarige} persoon {aanduiding} die als vondeling geboren is', minderjarigeVondeling)
Given('de {vandaag, gisteren of morgen x jaar geleden} geboren persoon {aanduiding} die als vondeling geboren is', minderjarigeVondeling)
Given('de (op ){dd maand yyyy datum} geboren persoon {aanduiding} die als vondeling geboren is', minderjarigeVondeling)
Given('de (op ){dd-mm-yyyy datum} geboren persoon {aanduiding} die als vondeling geboren is', minderjarigeVondeling)
Given('de {onbekende datum} geboren persoon {aanduiding} die als vondeling geboren is', minderjarigeVondeling)

// dit is een in Nederland geboren en ingezeten meerderjarige zonder kinderen
Given('de meerderjarige persoon {string}', function (aanduidingPersoon) {
  gegevenDePersoon(this.context, aanduidingPersoon, partnerBurgerservicenummer, geboortedatumMeerderjarige, defaultLandCode, 'M');
  gegevenDePersoonIsIngeschrevenInDeBrp(this.context, aanduidingPersoon);
});
