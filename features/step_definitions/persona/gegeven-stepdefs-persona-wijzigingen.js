const { Given } = require('@cucumber/cucumber');
const { wijzigPersoonContext,
        getAanduidingDefaultPersoon } = require('../contextHelpers');
const { gegevenDePersoon } = require('../expressief/gegeven-stepdefs-persoon');
const { gegevenDePersoonIsGeadopteerdOpDatum } = require('../expressief/gegeven-stepdefs-adoptie');

// **************************************************************************************************************
//                     aanvullende Gegeven stappen
// **************************************************************************************************************

const adoptieOuder1Burgerservicenummer = '000000104'
const adoptieOuder2Burgerservicenummer = '000000105'

const geboortedatumMeerderjarige = 'morgen - 37 jaar'

// maakt de adoptieouder als meerderjarige persoon en legt ouder-kind relatie tussen de persoon in context en de adoptieouder
Given('is {vandaag, gisteren of morgen x jaar geleden} geadopteerd door Nederlandse adoptieouder {string} met een Nederlandse adoptieakte', function (adoptieDatum, aanduidingAdoptieOuder) {
  const aanduidingPersoon = getAanduidingDefaultPersoon(this.context);

  gegevenDePersoon(this.context, aanduidingAdoptieOuder, adoptieOuder1Burgerservicenummer, geboortedatumMeerderjarige, '6030', 'M');
  gegevenDePersoonIsGeadopteerdOpDatum(this.context, aanduidingPersoon, aanduidingAdoptieOuder, undefined, adoptieDatum);

  // zet context terug naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// maakt de adoptieouders als meerderjarige personen en legt ouder-kind relaties tussen de persoon in context en de adoptieouders
Given('is {vandaag, gisteren of morgen x jaar geleden} geadopteerd door twee Nederlandse adoptieouders {string} en {string} met een Nederlandse adoptieakte', function(adoptieDatum, aanduidingOuder1, aanduidingOuder2) {
  const aanduidingPersoon = getAanduidingDefaultPersoon(this.context);

  gegevenDePersoon(this.context, aanduidingOuder1, adoptieOuder1Burgerservicenummer, geboortedatumMeerderjarige, '6030', 'V');
  gegevenDePersoon(this.context, aanduidingOuder2, adoptieOuder2Burgerservicenummer, geboortedatumMeerderjarige, '6030', 'M');
  gegevenDePersoonIsGeadopteerdOpDatum(this.context, aanduidingPersoon, aanduidingOuder1, aanduidingOuder2, adoptieDatum);

  // zet context terug naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});
 