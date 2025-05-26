const { Given, defineParameterType } = require('@cucumber/cucumber');
const { 
        createOuder, wijzigOuder,
        aanvullenInschrijving,
        createVerblijfplaats, wijzigVerblijfplaats,
        createOverlijden,
        createGezagsverhouding,
        createPartnerMetAanduiding,
        wijzigPartnerMetAanduiding,
        createKindMetAanduiding,
        wijzigKindMetAanduiding
      } = require('../persoon-2');
const { getAdresIndex,getPersoon } = require('../contextHelpers');
const { arrayOfArraysToDataTable } = require('../dataTableFactory');

defineParameterType({
  name: 'ouder type',
  regexp: /(1|2)/
});

defineParameterType({
    name: 'gewijzigd of gecorrigeerd',
    regexp: /(gewijzigd|gecorrigeerd)/,
    transformer(soortMutatie) {
        return soortMutatie=='gecorrigeerd';
    }
});

Given('heeft een ouder {ouder type} met de volgende gegevens', function (soortOuder, dataTable) {
  createOuder(
    getPersoon(this.context, undefined),
    soortOuder,
    dataTable
  );
});

Given('heeft een partner {aanduiding} met de volgende gegevens', function (relatieAanduiding, dataTable) {
  createPartnerMetAanduiding(
    getPersoon(this.context, undefined),
    relatieAanduiding,
    dataTable
  );
});

Given('heeft een kind {aanduiding} met de volgende gegevens', function (relatieAanduiding, dataTable) {
  createKindMetAanduiding(
    getPersoon(this.context, undefined),
    relatieAanduiding,
    dataTable
  );
});

Given('ouder {ouder type} is {gewijzigd of gecorrigeerd} naar de volgende gegevens', function (soortOuder, isCorrectie, dataTable) {
  wijzigOuder(
    getPersoon(this.context, undefined),
    soortOuder,
    dataTable,
    isCorrectie
  );
});

Given('partner {aanduiding} is {gewijzigd of gecorrigeerd} naar de volgende gegevens', function (relatieAanduiding, isCorrectie, dataTable) {
  wijzigPartnerMetAanduiding(
    getPersoon(this.context, undefined),
    relatieAanduiding,
    dataTable,
    isCorrectie
  );
});

Given('kind {aanduiding} is {gewijzigd of gecorrigeerd} naar de volgende gegevens', function (relatieAanduiding, isCorrectie, dataTable) {
  wijzigKindMetAanduiding(
    getPersoon(this.context, undefined),
    relatieAanduiding,
    dataTable,
    isCorrectie
  );
});

function inschrijvingOpVerblijfplaats(context, dataTable) {
  let persoon = getPersoon(context, undefined)

  if (!persoon.verblijfplaats) {
    createVerblijfplaats(
      persoon,
      dataTable
    );
  } else {
    wijzigVerblijfplaats(
      persoon,
      dataTable
    );
  }
}

Given('is ingeschreven op adres {string} met de volgende gegevens', function (adresAanduiding, dataTable) {
  const data = [
    ['adres_id', getAdresIndex(this.context, adresAanduiding) + '']
  ];

  inschrijvingOpVerblijfplaats(this.context, arrayOfArraysToDataTable(data, dataTable));

  global.logger.info(`is ingeschreven op adres ${adresAanduiding} met de volgende gegevens`, getPersoon(this.context, undefined));
});

Given('is ingeschreven op een buitenlands adres met de volgende gegevens', function (dataTable) {
  inschrijvingOpVerblijfplaats(this.context, dataTable)

  global.logger.info(`is ingeschreven op de buitenlandse verblijfplaats met de volgende gegevens`, getPersoon(this.context, undefined));
});

Given('is overleden met de volgende gegevens', function (dataTable) {
  createOverlijden(
    getPersoon(this.context, undefined),
    dataTable
  );

  global.logger.info(`is overleden met de volgende gegevens`, getPersoon(this.context, undefined));
});

Given('is ingeschreven met de volgende gegevens', function (dataTable) {
  aanvullenInschrijving(
    getPersoon(this.context, undefined),
    dataTable
  );

  global.logger.info(`is ingeschreven met de volgende gegevens`, getPersoon(this.context, undefined));
});

Given('heeft de volgende gezagsverhouding gegevens', function (dataTable) {
      createGezagsverhouding(
        getPersoon(this.context, undefined),
        dataTable
      );
});
