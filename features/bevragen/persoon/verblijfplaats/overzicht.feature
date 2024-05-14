#language: nl

Functionaliteit: verblijfplaats

Regel: Een verblijfplaats is een adres wanneer straatnaam (11.10) een waarde heeft

  Abstract Scenario: 'straatnaam (11.10)' heeft een waarde
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20170423 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde   |
    | gemeentecode (92.10) | 0519     |
    | straatnaam (11.10)   | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | verblijfplaats.type             |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |

    Voorbeelden:
    | waarde |
    | Spui   |
    | .      |

Regel: Een verblijfplaats is een binnenlandse locatie wanneer locatiebeschrijving (12.10) een waarde heeft

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

Regel: Een verblijfplaats is een verblijfplaats buitenland wanneer 'land adres buitenland (13.10)' ongelijk is aan 0000

  Scenario: 'land adres buitenland (13.10)' heeft een waarde
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | naam                          | waarde   |
    | land adres buitenland (13.10) | 6014     |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | verblijfplaats.type             |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam | waarde                   |
    | type | VerblijfplaatsBuitenland |

Regel: Een verblijfplaats is een onbekend verblijfplaats wanneer 'land adres buitenland (13.10)' gelijk is aan 0000

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

Regel: Een persoon heeft geen verblijfplaats wanneer 'straatnaam (11.10)' én 'locatiebeschrijving (12.10)' én 'land adres buitenland (13.10)' geen waarde heeft

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

Regel: Een persoon heeft geen verblijfplaats wanneer de verblijfplaatsBinnenland field alias wordt gebruikt en de persoon heeft een verblijfplaats buitenland of verblijfplaats onbekend

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
