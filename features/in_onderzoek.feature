# language: nl

Functionaliteit: in onderzoek
  Wanneer een attribuut in onderzoek is, krijgt in het antwoord het attribuut met dezelfde naam binnen inOnderzoek de waarde true.

  Een categorie kan in zijn geheel in onderzoek zijn, maar er kunnen ook individuele groepen of attributen binnen de categorie in onderzoek zijn.
  Wanneer een categorie in zijn geheel in onderzoek is, krijgt in het antwoord in inOnderzoek elk attribuut van deze categorie de waarde true.
  Wanneer een categorie in zijn geheel in onderzoek is, krijgt in het antwoord in  inOnderzoek in elke groep van de categorie elk attribuut van deze categorie de waarde true.
  Voor de categorie 01 persoon betreft dit in het antwoord alleen de groepen naam en geboorte.

  Een groep kan in zijn geheel in onderzoek zijn, maar er kunnen ook individuele attributen binnen de groep in onderzoek zijn.
  Wanneer een groep in zijn geheel in onderzoek is, krijgt in het antwoord in inOnderzoek elk attribuut van deze groep de waarde true.

  Een attribuut dat niet in onderzoek is, wordt niet in het antwoord in inOnderzoek opgenomen, ook niet met de waarde false of null.

  Scenario: hele categorie persoon in onderzoek
    Gegeven de te raadplegen persoon heeft de hele persoon in onderzoek (01.83.10=010000)
    En geen enkele andere categorie, groep of attribuut is in onderzoek
    Als de ingeschreven persoon met burgerservicenummer 999991449 wordt geraadpleegd
    Dan is in het antwoord inOnderzoek.burgerservicenummer=true
    En is in het antwoord inOnderzoek.geslachtsaanduiding=true
    En is in het antwoord inOnderzoek.datumOpschortingBijhouding=true
    En is in het antwoord inOnderzoek.indicatieOpschortingBijhouding=true
    En is in het antwoord inOnderzoek.indicatieGeheim=true
    En is in het antwoord inOnderzoek.datumEersteInschrijvingGBA=true
    En is in het antwoord inOnderzoek.redenOpschortingBijhouding=true
    Dan is in het antwoord naam.inOnderzoek.geslachtsnaam=true
    En is in het antwoord naam.inOnderzoek.voornamen=true
    En is in het antwoord naam.inOnderzoek.voorvoegsel=true
    En is in het antwoord naam.inOnderzoek.adellijkeTitel_predikaat=true
    Dan is in het antwoord geboorte.inOnderzoek.plaats=true
    En is in het antwoord geboorte.inOnderzoek.datum=true
    En is in het antwoord geboorte.inOnderzoek.land=true
    En is in het antwoord attribuut nationaliteit.inOnderzoek null, leeg of afwezig
    En is in het antwoord attribuut overlijden.inOnderzoek null, leeg of afwezig
    En is in het antwoord attribuut verblijfplaats.inOnderzoek null, leeg of afwezig
    En is in het antwoord attribuut gezagsverhouding.inOnderzoek null, leeg of afwezig
    En is in het antwoord attribuut verblijfstitel.inOnderzoek null, leeg of afwezig

  Scenario: hele categorie in onderzoek
    Gegeven de te raadplegen persoon heeft categorie nationaliteit in onderzoek
    Als de ingeschreven persoon met burgerservicenummer 999999102 wordt geraadpleegd
    Dan is in het antwoord nationaliteit.inOnderzoek.nationaliteit=true
    En is in het antwoord nationaliteit.inOnderzoek.redenOpname=true
    En is in het antwoord nationaliteit.inOnderzoek.redenBeindigen=true
    En is in het antwoord nationaliteit.inOnderzoek.aanduidingBijzonderNederlanderschap=true

  Scenario: Hele groep in onderzoek
    Gegeven de te raadplegen persoon heeft groep naam in onderzoek
    Als de ingeschreven persoon met burgerservicenummer 999999151 wordt geraadpleegd
    Dan is in het antwoord inOnderzoek.naam.geslachtsnaam=true
    En is in het antwoord inOnderzoek.naam.voornamen=true
    En is in het antwoord inOnderzoek.naam.voorvoegsel=true

  Scenario: Een attribuut is in inOnderzoek
    Gegeven de te raadplegen persoon heeft attribuut naam.voornamen in onderzoek
    Als de ingeschreven persoon met burgerservicenummer 999999163 wordt geraadpleegd
    Dan is in het antwoord inOnderzoek.naam.geslachtsnaam niet aanwezig of null
    En is in het antwoord inOnderzoek.naam.voornamen=true
    En is in het antwoord inOnderzoek.naam.voorvoegsel niet aanwezig of null
