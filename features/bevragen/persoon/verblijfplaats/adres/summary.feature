#language: nl

Functionaliteit: Het leveren van een binnenlands adres met als type "Adres" 

  Rule: Een verblijfplaats is een binnenlands adres wanneer ten minste één gegeven van binnenlands adres (groep 11) een waarde heeft
    - veld 'type' krijgt de waarde 'Adres'
    - een standaardwaarde in de bron geldt hier niet als waarde
    - een string met lengte nul ("") geldt hier niet als waarde

    Abstract Scenario: straatnaam (11.10) heeft een valide waarde
      Gegeven de persoon met burgerservicenummer '000000267' heeft de volgende 'verblijfplaats' gegevens
      | naam                               | waarde   |
      | functie adres (10.10)              | W        |
      | datum aanvang adreshouding (10.30) | 20200101 |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                 | waarde     |
      | gemeentecode (92.10) | 0518       |
      | straatnaam (11.10)   | een straat |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000267                           |
      | fields              | verblijfplaats.verblijfadres.straat |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                 | waarde                 |
      | type                 | Adres                  |
      | verblijfadres.straat | een straat             |