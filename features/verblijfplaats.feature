# language: nl

@proxy @post-assert
Functionaliteit: leveren van een verblijfplaats

  Rule: Een verblijfplaats is een binnenlands adres wanneer ten minste één gegeven van binnenlands adres (groep 11) een waarde heeft
    - veld 'type' krijgt de waarde 'Adres'
    - een standaardwaarde in de bron geldt hier niet als waarde
    - een string met lengte nul ("") geldt hier niet als waarde

  Rule: Een verblijfplaats is een binnenlandse locatie wanneer locatiebeschrijving (12.10) een waarde heeft
    - veld 'type' krijgt de waarde 'Locatie' 

  Rule: Een verblijfplaats is een adres of locatie in het buitenland wanneer ten minste één gegeven van land (13.10), regel 1 (13.30), regel 2 (13.40) of regel 3 (13.50) een waarde heeft
    - veld 'type' krijgt de waarde 'VerblijfplaatsBuitenland'
    - een standaardwaarde in de bron voor land ('0000' onbekend) geldt hier niet als waarde
    - een string met lengte nul ("") geldt hier niet als waarde

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
      | naam                                       | waarde           |
      | straatnaam (11.10)                         | .                |
      | huisnummer (11.20)                         | 0                |
      | postcode (11.60)                           |                  |
      | woonplaatsnaam (11.70)                     | .                |
      | identificatiecode verblijfplaats (11.80)   | 0000000000000000 |
      | identificatiecode nummeraanduiding (11.90) | 0000000000000000 |
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
