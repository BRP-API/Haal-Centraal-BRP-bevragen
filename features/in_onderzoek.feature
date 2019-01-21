# language: nl

Functionaliteit: in onderzoek
  Wanneer een attribuut in onderzoek is, krijgt in het antwoord het attribuut met dezelfde naam binnen inOnderzoek de waarde true.

  Een groep kan in zijn geheel in onderzoek zijn, maar er kunnen ook individuele attributen binnen de groep in onderzoek zijn.
  Wanneer een groep in zijn geheel in onderzoek is, krijgt in het antwoord in inOnderzoek elk attribuut van deze groep de waarde true.

  Een attribuut dat niet in onderzoek is, wordt niet in het antwoord in inOnderzoek opgenomen, ook niet met de waarde false of null.

  Scenario: Hele groep in onderzoek
    Gegeven de te raadplegen persoon heeft groep naam in onderzoek
    Als de ingeschreven persoon met burgerservicenummer 999999151 wordt geraadpleegd
    Dan is in het antwoord inOnderzoek.naam.geslachtsnaam=true
    En is in het antwoord inOnderzoek.naam.voornamen=true
    En is in het antwoord inOnderzoek.naam.voorvoegsel=true
    Gegeven de te raadplegen persoon heeft groep nationaliteit in onderzoek
    Als de ingeschreven persoon met burgerservicenummer 999999102 wordt geraadpleegd
    Dan is in het antwoord inOnderzoek.nationaliteit.nationaliteit=true
    En is in het antwoord inOnderzoek.nationaliteit.redenOpname=true
    En is in het antwoord inOnderzoek.nationaliteit.redenBeindigen=true
    En is in het antwoord inOnderzoek.nationaliteit.aanduidingBijzonderNederlanderschap=true

  Scenario: Een attribuut is in inOnderzoek
    Gegeven de te raadplegen persoon heeft attribuut naam.voornamen in onderzoek
    Als de ingeschreven persoon met burgerservicenummer 999999163 wordt geraadpleegd
    Dan is in het antwoord inOnderzoek.naam.geslachtsnaam niet aanwezig of null
    En is in het antwoord inOnderzoek.naam.voornamen=true
    En is in het antwoord inOnderzoek.naam.voorvoegsel niet aanwezig of null
