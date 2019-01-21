# language: nl

Functionaliteit: zoeken met een wildcard wordt ondersteund op enkele parameters
  Het is mogelijk te zoeken met een wildcard met de volgende parameters van de ingeschreven persoon:
  - naam__geslachtsnaam
  - naam__voornamen
  - naamopenbareruimte

  Ondersteund worden twee soorten wildcard:
  - "*": Komt overeen met nul of meer (niet-spatie) karakters
  - "?": Komt precies overeen met één (niet-spatie) karakter

  Een wildcard kan geplaatst worden aan het begin van de zoekstring en/of aan het eind van de zoekstring.

  De "?" wildcard kan meerdere keren achter elkaar worden opgenomen. Bijvoorbeeld zoeken op "groen??" zoekt op namen die beginnen met "groen" en exact 7 karakters bevatten (bijv. Groenlo en Groenen, maar niet Groen of Groens).

  Bij het zoeken op de parameters die een wildcard ondersteunen, moeten er minimaal 2 karakters exclusief de wildcard(s) worden opgegeven.

  Achtergrond:
    Gegeven de registratie ingeschreven personen kent zoals beschreven in testdata.csv

  Scenario: Voor attribuut geslachtsnaam wordt zoeken met een wildcard ondersteund
    Gegeven de registratie ingeschreven personen kent met de geslachtsnaam "Groen", "Groenlo", "Groenink", "Groenen"
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=groen*&naam__voornamen=*frank*
    Dan wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groen
    En wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groenlo
    En wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groenink
    En wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groenen
    En voldoet elke van de gevonden ingeschrevenpersonen aan de query naam.geslachtsnaam=groen*

  Scenario: Voor attribuut voornamen wordt zoeken met een wildcard ondersteund
    Gegeven de registratie ingeschreven personen kent met de voornamen "Frank", "Franka", "Johan Frank Robert", "Franklin", "Franky"
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=groen*&naam__voornamen=*frank*
    Dan wordt de ingeschreven persoon gevonden met naam.voornamen=Frank
    En wordt de ingeschreven persoon gevonden met naam.voornamen=Franka
    En wordt de ingeschreven persoon gevonden met naam.voornamen=Franklin
    En wordt de ingeschreven persoon gevonden met naam.voornamen=Franky
    En wordt de ingeschreven persoon gevonden met naam.voornamen=Johan Frank Robert
    En voldoet elke van de gevonden ingeschrevenpersonen aan de query naam.voornamen=*frank*

    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=groen*&naam__voornamen=frank?
    Dan wordt de ingeschreven persoon gevonden met naam.voornamen=Franka
    En wordt de ingeschreven persoon gevonden met naam.voornamen=Franky
    En wordt geen ingeschreven persoon gevonden met naam.voornamen=Frank
    En wordt geen ingeschreven persoon gevonden met naam.voornamen=Franklin
    En voldoet elke van de gevonden ingeschrevenpersonen aan de query naam.voornamen=frank?

    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=ve*&naam__voornamen=Mari?
    Dan wordt de ingeschreven persoon gevonden met naam.voornamen=Maria
    En wordt de ingeschreven persoon gevonden met naam.voornamen=Marie
    En wordt geen ingeschreven persoon gevonden met naam.voornamen=Mariëlle

  Scenario: Voor attribuut naamopenbareruimte wordt zoeken met een wildcard ondersteund
    Gegeven de registratie ingeschreven personen kent met de naamopenbareruimte "Prinses Beatrixlaan", "Beatrixstraat"
    Als ingeschreven personen gezocht worden met ?verblijfplaats__gemeentevaninschrijving=0518&verblijfplaats__huisnummer=21&verblijfplaats__naamopenbareruimte=*beatrix*
    Dan wordt de ingeschreven persoon gevonden met verblijfplaats.naamOpenbareRuimte=Prinses Beatrixlaan
    Als ingeschreven personen gezocht worden met ?verblijfplaats__gemeentevaninschrijving=0014&verblijfplaats__huisnummer=11&verblijfplaats__naamopenbareruimte=*beatrix*
    Dan wordt de ingeschreven persoon gevonden met verblijfplaats.naamOpenbareRuimte=Beatrixstraat
    Als ingeschreven personen gezocht worden met ?verblijfplaats__gemeentevaninschrijving=0014&verblijfplaats__huisnummer=11&verblijfplaats__naamopenbareruimte=*trixstraa?
    Dan wordt de ingeschreven persoon gevonden met verblijfplaats.naamOpenbareRuimte=Beatrixstraat

  Scenario: De "?" wildcard kan meerdere keren achter elkaar worden opgenomen
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=groen??
    Dan wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groenlo
    En wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groenen
    En wordt geen ingeschreven persoon gevonden met naam.geslachtsnaam=Groen
    En wordt geen ingeschreven persoon gevonden met naam.geslachtsnaam=Groenink
    En voldoet elke van de gevonden ingeschrevenpersonen aan de query naam.geslachtsnaam=groen??

  Scenario: De wildcard karakters moeten aan het begin en/of aan het eind van de zoekstring staan
    Als ingeschreven personen gezocht worden met ?naam__voornamen=ma*&geboorte__datum=1983-05-26&naam__geslachtsnaam=ve*en
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?naam__voornamen=ma*&geboorte__datum=1983-05-26&naam__geslachtsnaam=ve??en
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?naam__voornamen=ma*&geboorte__datum=1983-05-26&naam__geslachtsnaam=*de*
    Dan levert dit zoekresultaten
    En wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Velden

  Scenario: Bij het zoeken op de parameters die een wildcard ondersteunen, moeten er minimaal 2 karakters exclusief de wildcard(s) worden opgegeven.
    Als ingeschreven personen gezocht worden met ?naam__voornamen=ma*&geboorte__datum=1983-05-26&naam__geslachtsnaam=v
    Dan levert dit zoekresultaten
    En is het aantal gevonden ingeschrevenpersonen 0
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=groenen&naam__voornamen=.
    Dan levert dit zoekresultaten
    En wordt de ingeschreven persoon gevonden met naam.voornamen=.
    Als ingeschreven personen gezocht worden met ?naam__voornamen=ma*&geboorte__datum=1983-05-26&naam__geslachtsnaam=v*
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?naam__voornamen=ma*&geboorte__datum=1983-05-26&naam__geslachtsnaam=*n
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?naam__voornamen=ma*&geboorte__datum=1983-05-26&naam__geslachtsnaam=v?
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?naam__voornamen=ma*&geboorte__datum=1983-05-26&naam__geslachtsnaam=ve
    Dan levert dit zoekresultaten
    Als ingeschreven personen gezocht worden met ?naam__voornamen=ma*&geboorte__datum=1983-05-26&naam__geslachtsnaam=ve*
    Dan levert dit zoekresultaten
