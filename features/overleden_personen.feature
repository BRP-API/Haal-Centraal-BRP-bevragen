# language: nl

Functionaliteit: Een zoekvraag levert alleen personen op die nog in leven zijn
  De gebruiker kan ook overlede personen vinden door gebruik van de parameter inclusiefoverledenpersonen.

  Achtergrond:
    Gegeven de registratie ingeschreven personen kent zoals beschreven in testdata.csv

  Scenario: Default levert een zoekvraag alleen personen op die nog in leven zijn
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen*&geboorte__datum=1983-05-26
    Dan is in elke van de gevonden ingeschrevennatuurlijkpersonen attribuut overlijden.datumOverlijden niet aanwezig of null
    Als ingeschreven personen gezocht worden met ?verblijfplaats__postcode=2595AK&verblijfplaats__huisnummer=21
    Dan is in elke van de gevonden ingeschrevennatuurlijkpersonen attribuut overlijden.datumOverlijden niet aanwezig of null
    Als ingeschreven personen gezocht worden met ?identificatiecodenummeraanduiding=689047857696734
    Dan is in elke van de gevonden ingeschrevennatuurlijkpersonen attribuut overlijden.datumOverlijden niet aanwezig of null

  Scenario: Met parameter inclusiefoverledenpersonen=true worden ook overleden personen gezocht
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen*&geboorte__datum=1983-05-26&inclusiefoverledenpersonen=true
    Dan wordt de ingeschreven persoon gevonden met overlijden.datumOverlijden=2018-01-23
    En wordt de ingeschreven persoon gevonden zonder overlijden.datumOverlijden
    Als ingeschreven personen gezocht worden met ?verblijfplaats__postcode=2595AK&verblijfplaats__huisnummer=21&inclusiefoverledenpersonen=true
    Dan wordt de ingeschreven persoon gevonden met overlijden.datumOverlijden=2019-01-23
    En wordt de ingeschreven persoon gevonden zonder overlijden.datumOverlijden
    Als ingeschreven personen gezocht worden met ?identificatiecodenummeraanduiding=689047857696734&inclusiefoverledenpersonen=true
    Dan wordt de ingeschreven persoon gevonden met overlijden.datumOverlijden=2019-01-23
    En wordt de ingeschreven persoon gevonden zonder overlijden.datumOverlijden
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&inclusiefoverledenpersonen=false
    Dan is in elke van de gevonden ingeschrevennatuurlijkpersonen attribuut overlijden.datumOverlijden niet aanwezig of null
