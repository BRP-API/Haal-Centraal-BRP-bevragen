#language: nl

Functionaliteit: verblijfplaats

Rule: Een verblijfplaats is een adres wanneer ten minste één gegeven van adres (groep 11) een waarde heeft

  Abstract Scenario: '<gba veld>' heeft een waarde
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20170423 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde   |
    | gemeentecode (92.10) | 0518     |
    | <gba veld>           | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | verblijfplaats.type             |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |

    Voorbeelden:
    | gba veld                                   | waarde           |
    | straatnaam (11.10)                         | Spui             |
    | naam openbare ruimte (11.15)               | Spui             |
    | huisnummer (11.20)                         | 123              |
    | huisletter (11.30)                         | a                |
    | huisnummertoevoeging (11.40)               | 2                |
    | aanduiding bij huisnummer (11.50)          | to               |
    | postcode (11.60)                           | 1234AA           |
    | woonplaatsnaam (11.70)                     | 's-Gravenhage    |
    | identificatiecode verblijfplaats (11.80)   | 0599010000208579 |
    | identificatiecode nummeraanduiding (11.90) | 0599200000219678 |

Rule: Een verblijfplaats is een binnenlandse locatie wanneer locatiebeschrijving (12.10) een waarde heeft

  Scenario: 'locatiebeschrijving (12.10)' heeft een waarde 
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20170423 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                       |
    | gemeentecode (92.10)        | 0518                         |
    | locatiebeschrijving (12.10) | Woonboot in de Grotere Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | verblijfplaats.type             |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam | waarde  |
    | type | Locatie |

Rule: Een verblijfplaats is een verblijfplaats buitenland wanneer 'land adres buitenland (13.10)' ongelijk is aan 0000

  Abstract Scenario: '<gba veld>' heeft een waarde
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | naam                          | waarde   |
    | land adres buitenland (13.10) | 6014     |
    | <gba veld>                    | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | verblijfplaats.type             |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam | waarde                   |
    | type | VerblijfplaatsBuitenland |

    Voorbeelden:
    | gba veld                         | waarde                     |
    | regel 1 adres buitenland (13.30) | Pietermaai 19, Curaçao     |
    | regel 1 adres buitenland (13.30) | VOW                        |
    | regel 2 adres buitenland (13.40) | Pietermaai 19, Curaçao     |
    | regel 2 adres buitenland (13.40) | .                          |
    | regel 2 adres buitenland (13.40) | onbekend                   |
    | regel 3 adres buitenland (13.50) | Amundsen-Scott, Antarctica |

Rule: Een verblijfplaats is een onbekend verblijfplaats wanneer 'land adres buitenland (13.10)' gelijk is aan 0000

  Scenario: waarde 'land adres buitenland (13.10)' is gelijk aan 0000
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | land adres buitenland (13.10) |
    | 0000                          |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | verblijfplaats.type             |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                 |
    | type | VerblijfplaatsOnbekend |

Rule: Een persoon heeft geen verblijfplaats wanneer geen enkel gegeven van adres een waarde heeft én locatiebeschrijving geen waarde heeft én 'land adres buitenland' geen waarde heeft

  Scenario: De adres gegevens én locatiebeschrijving hebben geen waarde
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20170423 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0518   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | verblijfplaats                  |
    Dan heeft de response een persoon zonder gegevens

  Scenario: 'land adres buitenland' heeft geen waarde
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | naam                                   | waarde   |
    | datum aanvang adres buitenland (13.20) | 20150808 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | verblijfplaats                  |
    Dan heeft de response een persoon zonder gegevens

Rule: Een persoon heeft geen verblijfplaats wanneer de verblijfplaatsBinnenland field alias wordt gebruikt en de persoon heeft een verblijfplaats buitenland of verblijfplaats onbekend

  Abstract Scenario: Een verblijfplaats <type> wordt gevraagd met field pad 'verblijfplaatsBinnenland'
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | land adres buitenland (13.10) |
    | <land code>                   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | verblijfplaatsBinnenland        |
    Dan heeft de response een persoon zonder gegevens

  Voorbeelden:
  | land code | type       |
  | 6014      | buitenland |
  | 0000      | onbekend   |