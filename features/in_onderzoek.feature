# language: nl

Functionaliteit: in onderzoek
  Wanneer een attribuut in onderzoek is, krijgt in het antwoord het attribuut met dezelfde naam binnen inOnderzoek de waarde true.

  Een categorie (groep van attributen) kan in zijn geheel in onderzoek zijn, maar er kunnen ook individuele attributen binnen de categorie in onderzoek zijn.
  Wanneer een categorie in zijn geheel in onderzoek is, krijgt in het antwoord in inOnderzoek elk attribuut van deze categorie de waarde true.

  Een attribuut dat niet in onderzoek is, wordt niet in het antwoord in inOnderzoek opgenomen, ook niet met de waarde false of null.

  Scenario: Hele categorie in onderzoek
    Gegeven categorie naam is in onderzoek bij Johannes van der Veen
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam_geslachtsnaam=veen&voornamen=johannes
    Dan heeft elke van de gevonden ingeschrevennatuurlijkpersonen inOnderzoek.naam.geslachtsnaam=true
    En heeft elke van de gevonden ingeschrevennatuurlijkpersonen inOnderzoek.naam.voornamen=true
    En heeft elke van de gevonden ingeschrevennatuurlijkpersonen inOnderzoek.naam.voorvoegsel=true

  Scenario: Een attribuut is in inOnderzoek
    Gegeven attribuut naam.voornamen is in onderzoek bij Anna Cornelia van der Veen
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam_geslachtsnaam=veen&voornamen=Anna%20Cornelia
    Dan heeft elke van de gevonden ingeschrevennatuurlijkpersonen inOnderzoek.naam.voornamen=true
    En is in elke van de gevonden ingeschrevennatuurlijkpersonen attribuut inOnderzoek.naam.geslachtsnaam niet aanwezig of null
    En is in elke van de gevonden ingeschrevennatuurlijkpersonen attribuut inOnderzoek.naam.voorvoegsel niet aanwezig of null
