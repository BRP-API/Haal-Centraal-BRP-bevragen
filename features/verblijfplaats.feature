# language: nl

@proxy @post-assert
Functionaliteit: leveren van een verblijfplaats

  Rule: Een verblijfplaats is onbekend wanneer land (13.10) de waarde '0000' heeft
    - veld 'type' krijgt de waarde 'VerblijfplaatsOnbekend' 
    - veld 'verblijfplaatsOnbekend' wordt opgenomen met de boolean waarde true

    Scenario: land onbekend 
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam         | waarde |
      | land (13.10) | 0000   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfplaats                  |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                   | waarde                 |
      | type                   | VerblijfplaatsOnbekend |
      | verblijfplaatsOnbekend | true                   |

  Rule: Een verblijfplaats is een adres of locatie in het buitenland wanneer land (13.10) een waarde ongelijk aan '0000' (onbekend) heeft
    - veld 'type' krijgt de waarde 'VerblijfplaatsBuitenland'

    Abstract Scenario: verblijfplaats buitenland
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam         | waarde |
      | land (13.10) | <land> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfplaats                  |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam      | waarde                   |
      | type      | VerblijfplaatsBuitenland |
      | land.code | <land>                   |

      Voorbeelden:
      | land | land omschrijving            |
      | 6014 | Verenigde Staten van Amerika |
      | 9999 | Internationaal gebied        |

  Rule: Een verblijfplaats is een binnenlands adres wanneer straat (11.10) en/of huisnummer (11.20) een waarde heeft
    - veld 'type' krijgt de waarde 'Adres' 

    Abstract Scenario: verblijfplaats binnenlands adres
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam               | waarde       |
      | land (13.10)       |              |
      | straatnaam (11.10) | <straat>     |
      | huisnummer (11.20) | <huisnummer> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfplaats.postcode         |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam | waarde |
      | type | Adres  |

      Voorbeelden:
      | straat | huisnummer |
      | Spui   | 70         |
      |        | 70         |
      | Spui   |            |

  Rule: Een verblijfplaats is een binnenlandse locatie wanneer locatiebeschrijving (12.10) een waarde heeft
    - veld 'type' krijgt de waarde 'Locatie' 

    Scenario: verblijfplaats binnenlandse locatie
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                        | waarde                     |
      | land (13.10)                |                            |
      | straatnaam (11.10)          |                            |
      | huisnummer (11.20)          |                            |
      | locatiebeschrijving (12.10) | Woonboot in de Grote Sloot |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfplaats.straat           |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam | waarde  |
      | type | Locatie |
