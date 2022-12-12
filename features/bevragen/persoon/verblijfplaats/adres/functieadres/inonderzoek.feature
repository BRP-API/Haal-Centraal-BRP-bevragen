  #language: nl

Functionaliteit: persoon.verblijfplaats.inOnderzoek.functieAdres boolean leveren als de aanduidingInOnderzoek een waarde bevat waardoor functie adres (10.10) in onderzoek is. 

  
  Rule: Als functie adres (10.10) in Onderzoek is wordt de corresponderende boolean geleverd. 
    
    Abstract Scenario: 'functie adres (10.10)' is in onderzoek
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
      | naam                            | waarde                    |
      | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      | functie adres (10.10)           | W                         |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                 | waarde |
      | gemeentecode (92.10) | 0518   |
      | straatnaam (11.10)   | Spui   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | verblijfplaats.functieAdres     |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                                         | waarde      |
      | type                                         | Adres       |
      | functieAdres.code                            | W           |
      | functieAdres.omschrijving                    | woonadres   |
      | inOnderzoek.functieAdres                     | true        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 | 

      Voorbeelden:
      | gba in onderzoek waarde |
      | 080000                  |
      | 081000                  |
      | 081010                  |

    Abstract Scenario: 'functie adres (10.10)' is in onderzoek, maar wordt niet gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
      | naam                            | waarde                    |
      | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      | functie adres (10.10)           | W                         |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                 | waarde |
      | gemeentecode (92.10) | 0518   |
      | straatnaam (11.10)   | Spui   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | verblijfplaats.datumVan     |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                                         | waarde      |
      | type                                         | Adres       |

      Voorbeelden:
      | gba in onderzoek waarde |
      | 081000                  |
      | 081010                  |
