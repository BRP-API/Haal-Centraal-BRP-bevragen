# User story #7

Functionaliteit: Als gemeente wil ik ingeschreven personen kunnen zoeken op geslachtsnaam
  Achtergrond:
    Gegeven de registratie ingeschreven personen kent zoals beschreven in testdata.csv

  Scenario: Er kan gezocht worden op geslachtsnaam
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=Groen&geboortedatum=1975-01-01&voornamen=Frank&voorvoegselGeslachtsnaam=van&geslachtsaanduiding=M&geboorteplaats=Sas%20van%20Gent&gemeenteVanInschrijving=0014
    Dan levert dit zoekresultaten

  Scenario: Bij zoeken op geslachtsnaam is geslachtsnaam verplicht en zijn de overige parameters optioneel
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen
    Dan levert dit zoekresultaten
    Als ingeschreven personen gezocht worden met ?geboortedatum=1975-01-01&voornamen=Frank&voorvoegselGeslachtsnaam=van&geslachtsaanduiding=M&geboorteplaats=Sas%20van%20Gent&gemeenteVanInschrijving=0014
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=&geboortedatum=1975-01-01&voornamen=Frank&voorvoegselGeslachtsnaam=van&geslachtsaanduiding=M&geboorteplaats=Sas%20van%20Gent&gemeenteVanInschrijving=0014
    Dan levert dit een foutmelding

  Scenario: Zoeken op geslachtsnaam kan NIET gecombineerd worden met andere zoekpaden
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen&postcode=9744CZ
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen&huisletter=A
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen&woonplaatsnaam=Amsterdam
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen&identificatiecodenummeraanduiding=0704019876543210
    Dan levert dit een foutmelding

  Scenario: Om alleen personen die zijn ingeschreven in de eigen gemeente in het antwoord te krijgen, kan zoekparameter gemeenteVanInschrijving worden gebruikt
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&voornamen=frank*&gemeenteVanInschrijving=0518
    Dan heeft elke van de gevonden ingeschrevennatuurlijkpersonen gemeenteVanInschrijving=0518

  Scenario: Om alleen personen te vinden met een specifieke geboorteplaats kan de zoekparameter geboorteplaats gebruikt worden
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&geboorteplaats=sas%20van%20gent
    Dan heeft elke van de gevonden ingeschrevennatuurlijkpersonen geboorte.geboorteplaats=Sas van Gent

  Scenario: Voor attribuut geslachtsnaam wordt zoeken met een wildcard ondersteund
    Gegeven de registratie ingeschreven personen kent met de geslachtsnaam "Groen", "Groenlo", "Groenink"
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen*
    Dan wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groen
    En wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groenlo
    En wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groenink
    En voldoet elke van de gevonden ingeschrevennatuurlijkpersonen aan de query naam.geslachtsnaam=groen*

  Scenario: Voor attribuut voornamen wordt zoeken met een wildcard ondersteund
    Gegeven de registratie ingeschreven personen kent met de voornamen "Frank", "Franka", "Johan Frank Robert", "Franklin", "Franky"
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&voornamen=*frank*
    Dan wordt de ingeschreven persoon gevonden met naam.voornamen=Frank
    En wordt de ingeschreven persoon gevonden met naam.voornamen=Franka
    En wordt de ingeschreven persoon gevonden met naam.voornamen=Johan Frank Robert
    En wordt de ingeschreven persoon gevonden met naam.voornamen=Franklin
    En wordt de ingeschreven persoon gevonden met naam.voornamen=Franky
    En voldoet elke van de gevonden ingeschrevennatuurlijkpersonen aan de query naam.voornamen=*frank*
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&voornamen=frank?
    Dan wordt de ingeschreven persoon gevonden met naam.voornamen=Franka
    Dan wordt de ingeschreven persoon gevonden met naam.voornamen=Franky
    En voldoet elke van de gevonden ingeschrevennatuurlijkpersonen aan de query naam.voornamen=frank?

  Scenario: Zoeken met onvolledige geboortedatum wordt niet ondersteund
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&geboortedatum=1975-01-00
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&geboortedatum=1975-01
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&geboortedatum=1975
    Dan levert dit een foutmelding

  Scenario: Default levert een zoekvraag alleen personen op die nog in leven zijn
    Gegeven de registratie ingeschreven personen kent met de geslachtsnaam "Groenen" en de datumOverlijden "2019-01-23"
    En de registratie ingeschreven personen kent met de geslachtsnaam "Groen", "Groenlo", "Groenink"
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen*
    Dan is in elke van de gevonden ingeschrevennatuurlijkpersonen attribuut overlijden.datumOverlijden niet aanwezig of null
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&inclusiefoverledenpersonen=false
    Dan is in elke van de gevonden ingeschrevennatuurlijkpersonen attribuut overlijden.datumOverlijden niet aanwezig of null
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&inclusiefoverledenpersonen=true
    Dan wordt de ingeschreven persoon gevonden met overlijden.datumOverlijden=2019-01-23

  ## TODO: inclusiefnietingezetenen
