#language: nl

Functionaliteit: Geen inOnderzoek booleans bij sommige inOnderzoeke aanduidingen uit categorie 08 (verblijfplaats)
    - gemeentaVaninschrijving en datumVanInschrijving zijn in de response op een ander niveau geplaatst. Dat betekent dat als deze in onderzoek zijn 
    er geen inOnderzoek booleans op het niveau van de verblijfplaats worden geretourneerd, maar op het niveau van de persoon. 
    
   Rule: Als "verblijfplaats"-gegevens die niet opgenomen zijn in de groep adres (binnenland) in onderzoek zijn wordt er voor de gtoep adres geen inOnderzoek geleverd. 
  
    Abstract Scenario: niet-verblijfplaats binnenland veld(en) van persoon is/zijn in onderzoek
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
      | naam                               | waarde                    |
      | datum aanvang adreshouding (10.30) | 20220128                  |
      | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
      | datum ingang onderzoek (83.20)     | 20020701                  |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                 | waarde |
      | gemeentecode (92.10) | 0518   |
      | straatnaam (11.10)   | Spui   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | verblijfplaats                  |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                  | waarde |
      | type                  | Adres  |
      | verblijfadres.straat  | Spui   |

      Voorbeelden:
      | gba in onderzoek waarde |
      | 080900                  |
      | 080910                  |
      | 080920                  |


