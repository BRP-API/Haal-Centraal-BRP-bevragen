#language: nl

Functionaliteit: inOnderzoek booleans van adres buitenland vullen

  Rule: Als aanduiding in onderzoek (83.10) een waarde heeft wordt deze waarde vertaald naar de corresponderde ïnOnderzoek" Booleans. 
   
    Abstract Scenario: 'verblijfplaats buitenland' veld(en) van persoon is/zijn in onderzoek
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
      | naam                            | waarde                    |
      | land adres buitenland (13.10)   | 6014                      |
      | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | verblijfplaats.inOnderzoek      |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                                         | waarde                               |
      | type                                         | VerblijfplaatsBuitenland             |
      | inOnderzoek.type                             | <type in onderzoek>                  |
      | inOnderzoek.datumVan                         | <datumVan in onderzoek>              |
      | inOnderzoek.datumIngangGeldigheid            | <datumIngangGeldigheid in onderzoek> |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum                                |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                           |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                          |

      Voorbeelden:
      | gba in onderzoek waarde | type in onderzoek | datumVan in onderzoek | datumIngangGeldigheid in onderzoek |
      | 080000                  |                   | true                  | true                               |
      | 081000                  |                   | true                  |                                    |
      | 081030                  |                   | true                  |                                    |
      | 081300                  |                   | true                  |                                    |
      | 081320                  |                   | true                  |                                    |
      | 088500                  |                   |                       | true                               |
      | 088510                  |                   |                       | true                               |



 

