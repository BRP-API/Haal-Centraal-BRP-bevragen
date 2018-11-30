# language: nl

Functionaliteit: zoeken met een wildcard wordt ondersteund op enkele parameters
  Het is mogelijk te zoeken met een wildcard met de volgende parameters van de ingeschreven persoon:
  - naam__geslachtsnaam
  - naam__voornamen
  - naamopenbareruimte

  Ondersteund worden twee soorten wildcard:
  - "*": Komt overeen met nul of meer (niet-spatie) karakters
  - "?": Komt precies overeen met één (niet-spatie) karakter

  Er kan meer dan één wildcard in één zoekterm of zin voorkomen.
  De twee wildcard karakters kunnen in combinatie worden gebruikt. Bijvoorbeeld m*?? komt overeen met woorden die beginnen met m en drie of meer tekens hebben.

  Spaties (URL-encoded als %20) worden gebruikt als woordscheiding en wildcard-matching werkt alleen binnen een enkel woord. Bijvoorbeeld, r*te* komt overeen met de ruimtelijk, maar niet met ruimte tekort.

  Bij het zoeken op de parameters die een wildcard ondersteunen, moeten er minimaal 2 karakters exclusief de wildcard(s) worden opgegeven.

  Achtergrond:
    Gegeven de registratie ingeschreven personen kent zoAls beschreven in testdata.csv

  Scenario: Voor attribuut geslachtsnaam wordt zoeken met een wildcard ondersteund
    Gegeven de registratie ingeschreven personen kent met de geslachtsnaam "Groen", "Groenlo", "Groenink"
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=groen*
    Dan wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groen
    En wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groenlo
    En wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groenink
    En voldoet elke van de gevonden ingeschrevennatuurlijkpersonen aan de query naam.geslachtsnaam=groen*
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=ve*en
    Dan wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Velzen
    En wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Veen
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=ve??en
    Dan wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Velzen
    En wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Velden
    En wordt geen ingeschreven persoon gevonden met naam.geslachtsnaam=Veen
    En wordt geen ingeschreven persoon gevonden met naam.geslachtsnaam=Veerlen

  Scenario: Voor attribuut voornamen wordt zoeken met een wildcard ondersteund
    Gegeven de registratie ingeschreven personen kent met de voornamen "Frank", "Franka", "Johan Frank Robert", "Franklin", "Franky"
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=groen*&naam__voornamen=*frank*
    Dan wordt de ingeschreven persoon gevonden met naam.voornamen=Frank
    En wordt de ingeschreven persoon gevonden met naam.voornamen=Franka
    En wordt de ingeschreven persoon gevonden met naam.voornamen=Franklin
    En wordt de ingeschreven persoon gevonden met naam.voornamen=Franky
    En voldoet elke van de gevonden ingeschrevennatuurlijkpersonen aan de query naam.voornamen=*frank*
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=groen*&naam__voornamen=frank?
    Dan wordt de ingeschreven persoon gevonden met naam.voornamen=Franka
    En wordt de ingeschreven persoon gevonden met naam.voornamen=Franky
    En wordt geen ingeschreven persoon gevonden met naam.voornamen=Frank
    En wordt geen ingeschreven persoon gevonden met naam.voornamen=Franklin
    En voldoet elke van de gevonden ingeschrevennatuurlijkpersonen aan de query naam.voornamen=frank?
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=ve*&naam__voornamen=Mari?
    Dan wordt de ingeschreven persoon gevonden met naam.voornamen=Maria
    En wordt de ingeschreven persoon gevonden met naam.voornamen=Marie
    En wordt geen ingeschreven persoon gevonden met naam.voornamen=Mariëlle

  Scenario: Voor attribuut naamopenbareruimte wordt zoeken met een wildcard ondersteund
    Gegeven de registratie ingeschreven personen kent met de naamopenbareruimte "Prinses Beatrixlaan", "Beatrixstraat"
    Als ingeschreven personen gezocht worden met ?gemeentevaninschrijving=0503&verblijfplaats__huisnummer=2&verblijfplaats__naamopenbareruimte=*beatrix*
    Dan wordt de ingeschreven persoon gevonden met verblijfplaats.naamOpenbareRuimte=Prinses Beatrixlaan
    En wordt de ingeschreven persoon gevonden met verblijfplaats.naamOpenbareRuimte=Beatrixstraat
    En voldoet elke van de gevonden ingeschrevennatuurlijkpersonen aan de query verblijfplaats.naamOpenbareRuimte=*beatrix*
    Als ingeschreven personen gezocht worden met ?naamopenbareruimte=*tri?straat
    Dan wordt de ingeschreven persoon gevonden met verblijfplaats.naamOpenbareRuimte=Beatrixstraat
    Als ingeschreven personen gezocht worden met ?naamopenbareruimte=*%20?eatrix*
    Dan wordt de ingeschreven persoon gevonden met verblijfplaats.naamOpenbareRuimte=Prinses Beatrixlaan

  Scenario: Bij het zoeken op de parameters die een wildcard ondersteunen, moeten er minimaal 2 karakters exclusief de wildcard(s) worden opgegeven.
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=v
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=v*
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=*n
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=v?
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=ve
    Dan levert dit zoekresultaten
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=ve*
    Dan levert dit zoekresultaten

  Scenario: Zoeken met een wildcard zoekt alleen binnen enkele woorden
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=groen*
    Dan wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groenen
    En wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groen-Geel
    En wordt geen ingeschreven persoon gevonden met naam.geslachtsnaam=Groen en Geel
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=*en%20en%20Geel
    Dan wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groen en Geel
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=groen*&naam__voornamen=*frank*
    Dan wordt de ingeschreven persoon gevonden met naam.voornamen=Franklin
    En wordt geen ingeschreven persoon gevonden met naam.voornamen=Johan Frank Robert
    Als ingeschreven personen gezocht worden met ?gemeentevaninschrijving=0503&verblijfplaats__huisnummer=2&verblijfplaats__naamopenbareruimte=*beatrix*
    Dan wordt de ingeschreven persoon gevonden met verblijfplaats.naamOpenbareRuimte=Beatrixstraat
    En wordt geen ingeschreven persoon gevonden met verblijfplaats.naamOpenbareRuimte=Prinses Beatrixlaan
