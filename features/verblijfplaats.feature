# language: nl

@proxy @post-assert
Functionaliteit: leveren van een verblijfplaats

  Rule: Een verblijfplaats is een binnenlands adres wanneer ten minste één gegeven van binnenlands adres (groep 11) een waarde heeft
    - veld 'type' krijgt de waarde 'Adres'
    - een standaardwaarde in de bron geldt hier niet als waarde
    - een string met lengte nul ("") geldt hier niet als waarde

    Abstract Scenario: verblijfplaats binnenlands adres met alleen een waarde voor <gba veld>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                               | waarde   |
      | functieAdres (10.10)               | W        |
      | datum aanvang adreshouding (10.30) | 20170423 |
      | <gba veld>                         | <waarde> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfplaats.type             |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam | waarde |
      | type | Adres  |

      Voorbeelden:
      | gba veld                                 | waarde           |
      | straatnaam (11.10)                       | Spui             |
      | naam openbare ruimte (11.15)             | Spui             |
      | huisnummer (11.20)                       | 123              |
      | huisletter (11.30)                       | a                |
      | huisnummertoevoeging (11.40)             | 2                |
      | aanduiding bij huisnummer (11.50)        | to               |
      | postcode (11.60)                         | 1234AA           |
      | woonplaatsnaam (11.70)                   | 's-Gravenhage    |
      | adresseerbaarObjectIdentificatie (11.80) | 0599010000208579 |
      | nummeraanduidingIdentificatie (11.90)    | 0599200000219678 |

  Rule: Een verblijfplaats is een binnenlandse locatie wanneer locatiebeschrijving (12.10) een waarde heeft
    - veld 'type' krijgt de waarde 'Locatie' 

    Scenario: verblijfplaats binnenlandse locatie
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                        | waarde                     |
      | locatiebeschrijving (12.10) | Woonboot in de Grote Sloot |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfplaats.type             |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam | waarde  |
      | type | Locatie |

  Rule: Een verblijfplaats is een adres of locatie in het buitenland wanneer ten minste één gegeven van land (13.10), regel 1 (13.30), regel 2 (13.40) of regel 3 (13.50) een waarde heeft
    - veld 'type' krijgt de waarde 'VerblijfplaatsBuitenland'
    - een standaardwaarde in de bron voor land ('0000' onbekend) geldt hier niet als waarde
    - een string met lengte nul ("") geldt hier niet als waarde

    Abstract Scenario: verblijfplaats buitenland met alleen een waarde voor <gba veld>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde   |
      | datum aanvang adres buitenland (13.20) | 20191104 |
      | <gba veld>                             | <waarde> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfplaats.type             |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam | waarde                   |
      | type | VerblijfplaatsBuitenland |

      Voorbeelden:
      | gba veld                         | waarde                     |
      | land adres buitenland (13.10)    | 6014                       |
      | land adres buitenland (13.10)    | 9999                       |
      | regel 1 adres buitenland (13.30) | Pietermaai 19, Curaçao     |
      | regel 1 adres buitenland (13.30) | VOW                        |
      | regel 2 adres buitenland (13.40) | Pietermaai 19, Curaçao     |
      | regel 2 adres buitenland (13.40) | .                          |
      | regel 2 adres buitenland (13.40) | onbekend                   |
      | regel 3 adres buitenland (13.50) | Amundsen-Scott, Antarctica |

    Scenario: verblijfplaats buitenland met onbekend land en waarde in regel
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde                 |
      | land adres buitenland (13.10)          | 0000                   |
      | datum aanvang adres buitenland (13.20) | 00000000               |
      | regel 2 adres buitenland (13.40)       | Pietermaai 19, Curaçao |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfplaats.type             |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam | waarde                   |
      | type | VerblijfplaatsBuitenland |

  Rule: Een verblijfplaats is onbekend wanneer geen adres, locatie of verblijf buitenland gegeven een waarde heeft
    - veld 'type' krijgt de waarde 'VerblijfplaatsOnbekend' 
    - veld 'verblijfplaatsOnbekend' wordt opgenomen met de boolean waarde true
    - een standaardwaarde in de bron geldt hier niet als waarde
    - een string met lengte nul ("") geldt hier niet als waarde

    Scenario: adres onbekend 
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                     | waarde           |
      | straatnaam (11.10)                       | .                |
      | huisnummer (11.20)                       | 0                |
      | postcode (11.60)                         |                  |
      | woonplaatsnaam (11.70)                   | .                |
      | adresseerbaarObjectIdentificatie (11.80) | 0000000000000000 |
      | nummeraanduidingIdentificatie (11.90)    | 0000000000000000 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfplaats.type             |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam | waarde                 |
      | type | VerblijfplaatsOnbekend |

    Scenario: land onbekend 
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde   |
      | land adres buitenland (13.10)          | 0000     |
      | datum aanvang adres buitenland (13.20) | 20201105 |
      | regel 2 adres buitenland (13.40)       |          |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfplaats.type             |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam | waarde                 |
      | type | VerblijfplaatsOnbekend |
