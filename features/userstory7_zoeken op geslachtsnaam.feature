# User story #7

Functionaliteit: ALS gemeente wil ik ingeschreven personen kunnen zoeken op geslachtsnaam
  Achtergrond:
    Gegeven de registratie ingeschreven personen kent zoals beschreven in testdata.csv











  Scenario: Default levert een zoekvraag alleen personen op die nog in leven zijn
    Gegeven de registratie ingeschreven personen kent met de geslachtsnaam "Groenen" en de datumOverlijden "2019-01-23"
    EN de registratie ingeschreven personen kent met de geslachtsnaam "Groen", "Groenlo", "Groenink"
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen*
    DAN is in elke van de gevonden ingeschrevennatuurlijkpersonen attribuut overlijden.datumOverlijden niet aanwezig of null
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&inclusiefoverledenpersonen=false
    DAN is in elke van de gevonden ingeschrevennatuurlijkpersonen attribuut overlijden.datumOverlijden niet aanwezig of null
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&inclusiefoverledenpersonen=true
    DAN wordt de ingeschreven persoon gevonden met overlijden.datumOverlijden=2019-01-23

  ## TODO: inclusiefnietingezetenen
