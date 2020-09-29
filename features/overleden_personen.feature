# language: nl

Functionaliteit: Een zoekvraag levert alleen personen op die nog in leven zijn
  De gebruiker kan ook overlede personen vinden door gebruik van de parameter inclusiefoverledenpersonen.

  Achtergrond:
    Gegeven er is een persoon met geslachtsnaam "Groenen", gebooortedatum "1983-05-26", postcode "2595AK" en huisnummer 21 en nummeraanduidingIdentificatie "689047857696734"
    En deze persoon is overleden op de datum "2018-01-23"
    En er is ten minste één andere ingeschreven persoon met geslachtsnaam "Groenen" en geboortedatum "1983-05-26" die niet overleden is
    En er is ten minste één andere ingeschreven persoon met postcode "2595AK" en huisnummer 21 die niet overleden is
    En er is ten minste één andere ingeschreven persoon met nummeraanduidingIdentificatie "689047857696734" die niet overleden is

  Scenario: Default levert een zoekvraag alleen personen op die nog in leven zijn
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groenen&geboorte__datum=1983-05-26
    Dan is in elke van de gevonden ingeschrevenpersonen attribuut overlijden niet aanwezig
    Als ingeschreven personen gezocht worden met ?verblijfplaats__postcode=2595AK&verblijfplaats__huisnummer=21
    Dan is in elke van de gevonden ingeschrevenpersonen attribuut overlijden niet aanwezig
    Als ingeschreven personen gezocht worden met ?veblijfplaats__nummeraanduidingIdentificatie=689047857696734
    Dan is in elke van de gevonden ingeschrevenpersonen attribuut overlijden niet aanwezig

  Scenario: Met parameter inclusiefoverledenpersonen=true worden ook overleden personen gezocht
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groenen&geboorte__datum=1983-05-26&inclusiefoverledenpersonen=true
    Dan wordt de ingeschreven persoon gevonden met overlijden.datum.datum=2018-01-23
    En wordt de ingeschreven persoon gevonden zonder veld overlijden
    Als ingeschreven personen gezocht worden met ?verblijfplaats__postcode=2595AK&verblijfplaats__huisnummer=21&inclusiefoverledenpersonen=true
    Dan wordt de ingeschreven persoon gevonden met overlijden.datum.datum=2018-01-23
    En wordt de ingeschreven persoon gevonden veld overlijden
    Als ingeschreven personen gezocht worden met ?veblijfplaats__nummeraanduidingIdentificatie=689047857696734&inclusiefoverledenpersonen=true
    Dan wordt de ingeschreven persoon gevonden met overlijden.datum.datum=2018-01-23
    En wordt de ingeschreven persoon gevonden veld overlijden
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groenen&geboorte__datum=1983-05-26&inclusiefoverledenpersonen=false
    Dan is in elke van de gevonden ingeschrevenpersonen attribuut overlijden niet aanwezig
