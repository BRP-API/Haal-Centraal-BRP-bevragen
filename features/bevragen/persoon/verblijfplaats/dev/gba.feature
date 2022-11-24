#language: nl

Functionaliteit: verblijfplaats

  Abstract Scenario: verblijfplaats veld 'datum aanvang adreshouding (10.30)' wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | datum aanvang adreshouding (10.30) |
    | 20170423                           |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | verblijfplaats                  |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                     | waarde   |
    | datumAanvangAdreshouding | 20170423 |

  Scenario: verblijfplaats veld 'datum aanvang adres buitenland (13.20)' wordt gevraagd
    Gegeven de consumer is geautoriseerd voor 'verblijfplaats binnenland' gegevens
    En de consumer is geautoriseerd voor 'verblijfplaats buitenland' gegevens
    En de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | datum aanvang adres buitenland (13.20) |
    | 19860801                               |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | verblijfplaats                  |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                        | waarde   |
    | datumAanvangAdresBuitenland | 19860801 |

Rule: verblijfplaats velden met standaard waarde moeten worden geleverd

  Abstract Scenario: adres veld '<gba naam>' met standaardwaarde wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | datum aanvang adreshouding (10.30) |
    | 20170423                           |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | <gba naam>   |
    | 0244                 | <gba waarde> |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | verblijfplaats                  |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                     | waarde       |
    | datumAanvangAdreshouding | 20170423     |
    | <gba api naam>           | <gba waarde> |

    Voorbeelden:
    | gba naam                                   | gba waarde       | gba api naam                     |
    | straatnaam (11.10)                         | .                | straat                           |
    | huisnummer (11.20)                         | 0                | huisnummer                       |
    | woonplaats (11.70)                         | .                | woonplaats                       |
    | identificatiecode verblijfplaats (11.80)   | 0000000000000000 | adresseerbaarObjectIdentificatie |
    | identificatiecode nummeraanduiding (11.90) | 0000000000000000 | nummeraanduidingIdentificatie    |

  Abstract Scenario: verblijfplaats buitenland veld '<gba naam>' wordt gevraagd
  