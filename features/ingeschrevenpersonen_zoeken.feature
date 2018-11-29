# Operatie /ingeschrevennatuurlijkpersonen ondersteunt het zoeken van ingeschreven personen op verschillende combinaties van query parameters

Functionaliteit: personen kunnen worden gezocht met bepaalde parameters
  In de specificatie van deze operatie is een aantal mogelijke paramters gedefinieerd. Zie de [Open API](specificaties https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/api-specificatie/openapi.yaml) of [Swagger](https://petstore.swagger.io/?url=https://raw.githubusercontent.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/master/api-specificatie/openapi.yaml#/ingeschrevennatuurlijkpersonen/ingeschrevennatuurlijkpersonen).

  Er mag niet gezocht worden zonder zoekparamters. Bij het zoeken moet ten minste één van de volgende combinaties van parameters aanwezig zijn.
  - geslachtsnaam + geboortedatum
  - postcode + huisnummer
  - gemeentevaninschrijving + openbareruimtenaam + huisnummer
  - identificatiecodenummeraanduiding

  Het is mogelijk bovenop deze parameters alle toegestane parameters te gebruiken om de zoekresultaten verder in te perken.

  Scenario: Er kan niet gezocht worden zonder zoekparameters
    Als ingeschreven personen gezocht worden zonder parameters
    Dan levert dit een foutmelding

  | geslachtsnaam | voornamen | geboortedatum | geboorteplaats | geslachtsaanduiding | gemeentevaninschrijving | naamopenbareruimte | huisnummer | huisletter | huisnummertoevoeging | postcode | identificatiecodenummeraanduiding | Resultaat | Voorbeeld |
  | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
  | Ja  |  -  | Ja  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  | zoekresultaten | ?naam__geslachtsnaam=groen&geboorte__geboortedatum=1975-01-01 |
  | Ja  | Ja  | Ja  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  | zoekresultaten | ?naam__geslachtsnaam=groen&naam__voornamen=frank&geboorte__geboortedatum=1975-01-01 |
  | Ja  | Ja  | Ja  | Ja  | Ja  | Ja  |  -  |  -  |  -  |  -  |  -  |  -  | zoekresultaten | ?naam__geslachtsnaam=groen&naam__voornamen=frank&geboorte__datum=1975-01-01&geboorte__plaats=Sas%20van%20Gent&geslachtsaanduiding=M&verblijfplaats__gemeentevaninschrijving=0014 |
  | Ja  |  -  | Ja  |  -  |  -  |  -  |  -  |  -  |  -  |  -  | Ja  |  -  | zoekresultaten | ?naam__geslachtsnaam=groen&geboorte__geboortedatum=1975-01-01&verblijfplaats__postcode=9744CZ |
  | Ja  |  -  | Ja  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  | Ja  | zoekresultaten | ?naam__geslachtsnaam=groen&geboorte__geboortedatum=1975-01-01&identificatiecodenummeraanduiding=0704019876543210 |
  | Ja  | Ja  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  | Ja  |  -  | foutmelding    | ?naam__geslachtsnaam=groen&naam__voornamen=frank&verblijfplaats__postcode=9744CZ |
  | Ja  | Ja  |  -  | Ja  | Ja  | Ja  | Ja  |  -  | Ja  | Ja  | Ja  |  -  | foutmelding    | ?naam__geslachtsnaam=groen&naam__voornamen=frank&verblijfplaats__postcode=9744CZ |




  # tabel maken!!
  Abstract Scenario: Er kan gezocht worden op minimale combinaties van zoekparamters + optioneel andere zoekparameters
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
