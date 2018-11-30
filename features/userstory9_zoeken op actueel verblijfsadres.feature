# User story #9

Functionaliteit: Als gemeente wil ik ingeschreven personen kunnen zoeken op het actuele verblijfsadres
  Achtergrond:
    Gegeven de registratie ingeschreven personen kent zoals beschreven in testdata.csv

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
