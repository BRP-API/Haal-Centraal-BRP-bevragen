# User story #8

Functionaliteit: Als gemeente wil ik ingeschreven personen kunnen zoeken op postcode en huisnummer van het verblijfsadres
  Achtergrond:
    Gegeven de registratie ingeschreven personen kent zoals beschreven in testdata.csv
  
  Scenario: Er kan gezocht worden op postcode en huisnummer
    Als ingeschreven personen gezocht worden met ?postcode=2595AK&huisnummer=20&huisletter=a&huisnummertoevoeging=to
    Dan levert dit zoekresultaten

  Scenario: Bij zoeken op postcode en huisnummer zijn postcode en huisnummer verplicht en zijn de overige parameters optioneel
    Als ingeschreven personen gezocht worden met ?postcode=2595AK&huisnummer=21
    Dan levert dit zoekresultaten
    Als ingeschreven personen gezocht worden met ?huisnummer=21&huisletter=A&huisnummertoevoeging=to
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?postcode=2595AK&huisletter=A&huisnummertoevoeging=to
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?postcode=&huisnummer=21&huisletter=A&huisnummertoevoeging=to
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?postcode=2595AK&huisnummer=&huisletter=A&huisnummertoevoeging=to
    Dan levert dit een foutmelding

  Scenario: Zoeken op postcode en huisnummer kan NIET gecombineerd worden met andere zoekpaden
    Als ingeschreven personen gezocht worden met ?postcode=2595AK&huisnummer=21&geboortedatum=1980-06-03
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?postcode=2595AK&huisnummer=21&voornamen=john
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?postcode=2595AK&huisnummer=21&identificatiecodenummeraanduiding=0704019876543210
    Dan levert dit een foutmelding

  Scenario: Default levert een zoekvraag alleen personen op die nog in leven zijn
    Gegeven de registratie ingeschreven personen kent met postcode=2595AK, huisnummer=21, geslachtsnaam=Groenen en datumOverlijden "2019-01-23"
    En de registratie ingeschreven personen kent met postcode=2595AK, huisnummer=21 en geen datumOverlijden
    Als ingeschreven personen gezocht worden met ?postcode=2595AK&huisnummer=21
    Dan is in elke van de gevonden ingeschrevennatuurlijkpersonen attribuut overlijden.datumOverlijden niet aanwezig of null
    Als ingeschreven personen gezocht worden met ?postcode=2595AK&huisnummer=21&inclusiefoverledenpersonen=false
    Dan is in elke van de gevonden ingeschrevennatuurlijkpersonen attribuut overlijden.datumOverlijden niet aanwezig of null
    Als ingeschreven personen gezocht worden met ?postcode=2595AK&huisnummer=21&inclusiefoverledenpersonen=true
    Dan wordt de ingeschreven persoon gevonden met overlijden.datumOverlijden=2019-01-23
    En heeft elke van de gevonden ingeschrevennatuurlijkpersonen verblijfplaats.postcode=2595AK
    En heeft elke van de gevonden ingeschrevennatuurlijkpersonen verblijfplaats.huisnummer=21
