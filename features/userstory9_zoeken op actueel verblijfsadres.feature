# User story #9

Functionaliteit: Als gemeente wil ik ingeschreven personen kunnen zoeken op het actuele verblijfsadres
  Achtergrond:
    Gegeven de registratie ingeschreven personen kent zoals beschreven in testdata.csv

  Scenario: Er kan gezocht worden op verblijfplaats
    Als ingeschreven personen gezocht worden met ?woonplaatsnaam=Amsterdam&naamopenbareruimte=Beatrixlaan&huisnummer=10&huisletter=Z&huisnummertoevoeging=to
    Dan levert dit zoekresultaten

  Scenario: Er kan gezocht worden op nummeraanduiding
    Als ingeschreven personen gezocht worden met ?identificatiecodenummeraanduiding=0704019876543210
    Dan levert dit zoekresultaten

  Scenario: Bij het zoeken op verblijfplaats zijn woonplaatsnaam, naamopenbareruimte en huisnummer verplicht en zijn de overige parameters optioneel
    Als ingeschreven personen gezocht worden met ?woonplaatsnaam=Amsterdam&naamopenbareruimte=Beatrixlaan&huisnummer=10
    Dan levert dit zoekresultaten
    Als ingeschreven personen gezocht worden met ?naamopenbareruimte=Beatrixlaan&huisnummer=10&huisletter=Z&huisnummertoevoeging=to
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?woonplaatsnaam=&naamopenbareruimte=Beatrixlaan&huisnummer=10&huisletter=Z&huisnummertoevoeging=to
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?woonplaatsnaam=Amsterdam&huisnummer=10&huisletter=Z&huisnummertoevoeging=to
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?woonplaatsnaam=Amsterdam&naamopenbareruimte=&huisnummer=10&huisletter=Z&huisnummertoevoeging=to
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?woonplaatsnaam=Amsterdam&naamopenbareruimte=Beatrixlaan&huisletter=Z&huisnummertoevoeging=to
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?woonplaatsnaam=Amsterdam&naamopenbareruimte=Beatrixlaan&huisnummer=&huisletter=Z&huisnummertoevoeging=to
    Dan levert dit een foutmelding

  Scenario: Zoeken op verblijfsadres kan NIET gecombineerd worden met andere zoekpaden
    Als ingeschreven personen gezocht worden met ?woonplaatsnaam=Amsterdam&naamopenbareruimte=Beatrixlaan&huisnummer=10&geboortedatum=1980-06-03
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?woonplaatsnaam=Amsterdam&naamopenbareruimte=Beatrixlaan&huisnummer=10&postcode=1234AZ
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?woonplaatsnaam=Amsterdam&naamopenbareruimte=Beatrixlaan&huisnummer=10&identificatiecodenummeraanduiding=0704019876543210
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?identificatiecodenummeraanduiding=0704019876543210&geboortedatum=1980-06-03
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?identificatiecodenummeraanduiding=0704019876543210&huisletter=Z
    Dan levert dit een foutmelding

  Scenario: Voor attribuut naamopenbareruimte wordt zoeken met een wildcard ondersteund
    Gegeven de registratie ingeschreven personen kent met de naamopenbareruimte "Prinses Beatrixlaan", "Beatrixstraat"
    Als ingeschreven personen gezocht worden met ?naamopenbareruimte=*beatrix*
    Dan wordt de ingeschreven persoon gevonden met verblijfplaats.naamOpenbareRuimte=Prinses Beatrixlaan
    En wordt de ingeschreven persoon gevonden met verblijfplaats.naamOpenbareRuimte=Beatrixstraat
    En voldoet elke van de gevonden ingeschrevennatuurlijkpersonen aan de query verblijfplaats.naamOpenbareRuimte=*beatrix*
    Als ingeschreven personen gezocht worden met ?naamopenbareruimte=*beatri?laan
    Dan wordt de ingeschreven persoon gevonden met verblijfplaats.naamOpenbareRuimte=Prinses Beatrixlaan
    En voldoet elke van de gevonden ingeschrevennatuurlijkpersonen aan de query verblijfplaats.naamOpenbareRuimte=*beatri?laan

  Scenario: Default levert een zoekvraag alleen personen op die nog in leven zijn
    Gegeven de registratie ingeschreven personen kent met naamopenbareruimte "Prinses Beatrixlaan", huisnummer=21, geslachtsnaam=Groenen en datumOverlijden "2019-01-23"
    En de registratie ingeschreven personen kent met naamopenbareruimte "Prinses Beatrixlaan", huisnummer=21 en geslachtsnaam "Groen", "Groenlo", "Groenink" en geen datumOverlijden
    Als ingeschreven personen gezocht worden met ?naamopenbareruimte "Prinses Beatrixlaan"&huisnummer=21
    Dan is in elke van de gevonden ingeschrevennatuurlijkpersonen attribuut overlijden.datumOverlijden niet aanwezig of null
    Als ingeschreven personen gezocht worden met ?naamopenbareruimte "Prinses Beatrixlaan"&huisnummer=21&inclusiefoverledenpersonen=false
    Dan is in elke van de gevonden ingeschrevennatuurlijkpersonen attribuut overlijden.datumOverlijden niet aanwezig of null
    Als ingeschreven personen gezocht worden met ?naamopenbareruimte "Prinses Beatrixlaan"&huisnummer=21&inclusiefoverledenpersonen=true
    Dan wordt de ingeschreven persoon gevonden met overlijden.datumOverlijden=2019-01-23
    En heeft elke van de gevonden ingeschrevennatuurlijkpersonen verblijfplaats.naamOpenbareRuimte=Prinses Beatrixlaan
    En heeft elke van de gevonden ingeschrevennatuurlijkpersonen verblijfplaats.huisnummer=21
