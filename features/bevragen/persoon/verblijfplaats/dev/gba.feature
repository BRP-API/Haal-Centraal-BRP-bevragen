#language: nl

Functionaliteit: verblijfplaats

  Abstract Scenario: verblijfplaats veld 'datum aanvang adreshouding (10.30)' wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | datum aanvang adreshouding (10.30) |
    | 20170423                           |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | verblijfplaats                  |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                     | waarde   |
    | datumAanvangAdreshouding | 20170423 |
    | straat                   | Spui     |

  Scenario: verblijfplaats veld 'datum aanvang adres buitenland (13.20)' wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
    | 19860801                               | 6014                          |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | verblijfplaats                  |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                        | waarde                       |
    | datumAanvangAdresBuitenland | 19860801                     |
    | land.code                   | 6014                         |
    | land.omschrijving           | Verenigde Staten van Amerika |
