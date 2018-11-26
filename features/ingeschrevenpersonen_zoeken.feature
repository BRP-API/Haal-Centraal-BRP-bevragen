# Test van endpoint /ingeschrevennatuurlijkpersonen op benodigde combinaties van query parameters

Functionaliteit: bij zoeken moet tenminste gezocht worden met bepaalde parameters
  Bij het zoeken moet ten minste één van de volgende combinaties van parameters aanwezig zijn.
  - geslachtsnaam + geboortedatum
  - postcode + huisnummer
  - gemeentevaninschrijving + openbareruimtenaam + huisnummer
  - identificatiecodenummeraanduiding

  Het is mogelijk bovenop deze parameters alle toegestane parameters te gebruiken om de zoekresultaten verder in te perken.


  Scenario: Er kan niet gezocht worden zonder zoekparameters
    Als ingeschreven personen gezocht worden zonder parameters
    Dan levert dit een foutmelding

  # tabel maken!!
  Scenario: Er kan gezocht worden op geslachtsnaam + geboortedatum + optioneel andere zoekparameters
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen&gemeentevaninschrijving=0014
    DAN levert dit zoekresultaten
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen&geboortedatum=1975-01-01
    DAN levert dit zoekresultaten
    # verplichte attributen gemeentevaninschrijving én geboortedatum ontbreken
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen
    DAN levert dit een foutmelding
    # verplicht attribuut geslachtsnaam ontbreekt
    ALS ingeschreven personen gezocht worden met ?gemeentevaninschrijving=0014&geboortedatum=1975-01-01&voornamen=Frank&voorvoegselGeslachtsnaam=van&geslachtsaanduiding=M&geboorteplaats=Sas%20van%20Gent
    DAN levert dit een foutmelding
    # verplicht attribuut geslachtsnaam is leeg/heeft geen waarde
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=&gemeentevaninschrijving=0014&geboortedatum=1975-01-01&voornamen=Frank&voorvoegselGeslachtsnaam=van&geslachtsaanduiding=M&geboorteplaats=Sas%20van%20Gent
    DAN levert dit een foutmelding
    # verplicht attribuut gemeentevaninschrijving ontbreekt
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen&geboortedatum=1975-01-01&voornamen=Frank&voorvoegselGeslachtsnaam=van&geslachtsaanduiding=M&geboorteplaats=Sas%20van%20Gent
    DAN levert dit een foutmelding
    # verplicht attribuut gemeentevaninschrijving is leeg/heeft geen waarde en geboortedatum ontbreekt
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen&gemeentevaninschrijving=&voornamen=Frank&voorvoegselGeslachtsnaam=van&geslachtsaanduiding=M&geboorteplaats=Sas%20van%20Gent
    DAN levert dit een foutmelding
    # verplicht attribuut geboortedatum is leeg/heeft geen waarde en gemeentevaninschrijving ontbreekt
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen&geboortedatum=&voornamen=Frank&voorvoegselGeslachtsnaam=van&geslachtsaanduiding=M&geboorteplaats=Sas%20van%20Gent
    DAN levert dit een foutmelding
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen&geboortedatum=null&voornamen=Frank&voorvoegselGeslachtsnaam=van&geslachtsaanduiding=M&geboorteplaats=Sas%20van%20Gent
    DAN levert dit een foutmelding

  Scenario: Er kan gezocht worden op postcode + huisnummer + optioneel andere zoekparameters

  Scenario: Er kan gezocht worden met de volgende optionele zoekparameters: ...
