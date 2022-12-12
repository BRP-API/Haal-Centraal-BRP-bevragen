#language: nl

Functionaliteit: Als gebruiker van de API wil ik geen onbekend waardes ontvangen binnen het buitenlands adres
  zodat ik deze niet hoef te (kunnen) interpreteren en ik geen code voor hoef te schrijven om deze situatie af te vangen

  Rule: Wanneer in de registratie specifieke waarden gereserveerd zijn voor een onbekende waarde, worden deze waarden niet doorgegeven in de API.
  
  Rule: Wanneer een element in de registratie een standaardwaarde heeft, die betekent dat de waarde onbekend is, wordt het corresponderende veld niet opgenomen in de response.

    Scenario: verblijfplaats buitenland met onbekend land en waarde in regel
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde                 |
      | land adres buitenland (13.10)          | 0000                   |
      | datum aanvang adres buitenland (13.20) | 00000000               |
      | regel 2 adres buitenland (13.40)       | Pietermaai 19, Curaçao |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | verblijfplaats                  |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                 | waarde                   |
      | type                 | VerblijfplaatsBuitenland |
      | verblijfadres.regel2 | Pietermaai 19, Curaçao   |

  Rule: datumvelden waarde "00000000": worden vertaald naar DatumOnbekend

    Scenario: volledig onbekende datum in verblijfplaats buitenland
      Gegeven de persoon met burgerservicenummer '000000383' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde   |
      | land adres buitenland (13.10)          | 6014     |
      | datum aanvang adres buitenland (13.20) | 00000000 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 000000383                          |
      | fields              | verblijfplaats.datumVan            |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                 | waarde                   |
      | type                 | VerblijfplaatsBuitenland |
      | datumVan.type        | DatumOnbekend            |
      | datumVan.onbekend    | true                     |
      | datumVan.langFormaat | onbekend                 |