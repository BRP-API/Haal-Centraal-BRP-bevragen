# User story #8

Functionaliteit: Als gemeente wil ik ingeschreven personen kunnen zoeken op postcode en huisnummer van het verblijfsadres
  Achtergrond:
    Gegeven de registratie ingeschreven personen kent zoals beschreven in testdata.csv

  Scenario: Default levert een zoekvraag alleen personen op die nog in leven zijn
    Gegeven de registratie ingeschreven personen kent met postcode=2595AK, huisnummer=21, geslachtsnaam=Groenen en datumOverlijden "2019-01-23"
    En de registratie ingeschreven personen kent met postcode=2595AK, huisnummer=21 en geen datumOverlijden
    ALS ingeschreven personen gezocht worden met ?postcode=2595AK&huisnummer=21
    DAN is in elke van de gevonden ingeschrevennatuurlijkpersonen attribuut overlijden.datumOverlijden niet aanwezig of null
    ALS ingeschreven personen gezocht worden met ?postcode=2595AK&huisnummer=21&inclusiefoverledenpersonen=false
    DAN is in elke van de gevonden ingeschrevennatuurlijkpersonen attribuut overlijden.datumOverlijden niet aanwezig of null
    ALS ingeschreven personen gezocht worden met ?postcode=2595AK&huisnummer=21&inclusiefoverledenpersonen=true
    DAN wordt de ingeschreven persoon gevonden met overlijden.datumOverlijden=2019-01-23
    EN heeft elke van de gevonden ingeschrevennatuurlijkpersonen verblijfplaats.postcode=2595AK
    EN heeft elke van de gevonden ingeschrevennatuurlijkpersonen verblijfplaats.huisnummer=21
