# Test van endpoint /ingeschrevennatuurlijkpersonen op benodigde combinaties van query parameters

Functionaliteit: bij zoeken moet tenminste gezocht worden met
# OF geslachtsnaam + geboortedatum
# OF postcode + huisnummer
# OF gemeentevaninschrijving + openbareruimtenaam + huisnummer
# OF identificatiecodenummeraanduiding

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


  # Foutafhandeling -->

  # Fields en Expand
  Functionaliteit: Filteren van antwoord inhoud met fields parameter
    Scenario: enkel attribuut

    Scenario: meerdere attributen

    Scenario: groepsattribuut
      gegeven er een persoon de Vries
      naam
      DAN krijg ik naam.geslachtsnaam, naam.voornamen, naam.aanschrijfwijze, ...

    Scenario: attributen binnen een groep
      naam.geslachtsnaam

    Scenario: relatie (links)
      ouders
      partners
      kinderen

    Scenario: altijd self link

  Functionaliteit: direct meekrijgen van nested resource (subresource) via expand parameter

  Functionaliteit: er worden alleen actuele partners teruggegeven
    Gegeven persoon heeft ex-partner en actuele partner
    DAN krijgen we alleen de actuele partner

    Gegeven persoon heeft ex-partner, geen actuele partner
    DAN krijgen we geen partner(s)

    Gegeven persoon heeft twee actuele partners en één ex-partner
    DAN krijgen we de twee actuele partners, geen ex-partner

  Functionaliteit: in onderzoek
    # Een categorie kan in zijn geheel in onderzoek zijn, maar er kunnen ook individuele attributen binnen de categorie in onderzoek zijn
    Scenario: hele categorie in onderzoek
    ALS een hele categorie in onderzoek is
    DAN komen in het antwoord alle attributen van de categorie voor en hebben de waarde True

  Functionaliteit: historie wordt gesorteerd op geldigheid met meest actuele bovenaan
    Scenario: partnerhistorie wordt aflopend gesorteerd op geldigVan

    Scenario: verblijfplaatshistorie wordt aflopend gesorteerd op geldigVan

    Scenario: verblijfstitelhistorie wordt aflopend gesorteerd op geldigVan

    Scenario: bij bewoningen worden de bewoners aflopend gesorteerd op geldigVan
