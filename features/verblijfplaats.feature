# language: nl

Functionaliteit: leveren van een verblijfplaats

  Rule: Een verblijfplaats is onbekend wanneer land (13.10) de waarde '0000' heeft
    - veld 'type' krijgt de waarde 'VerblijfplaatsOnbekend' 
    - veld 'verblijfplaatsOnbekend' wordt opgenomen met de boolean waarde true

    Scenario: land onbekend 
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                | waarde   |
      | gemeenteVanInschrijving (09.10)     | 1999     |
      | datumInschrijvingInGemeente (09.20) | 20220128 |
      | land (13.10)                        | 0000     |
      | datumAanvangAdresBuitenland (13.20) | 20220128 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 555550001                          |
      | fields              | burgerservicenummer,verblijfplaats |
      Dan bevat de persoon met burgerservicenummer '555550001' alleen de volgende 'verblijfplaats' gegevens
      | naam                        | waarde                 |
      | type                        | VerblijfplaatsOnbekend |
      | verblijfplaatsOnbekend      | true                   |
      | gemeenteVanInschrijving     | 1999                   |
      | datumInschrijvingInGemeente | 2022-01-28             |

  Rule: Een verblijfplaats is een adres of locatie in het buitenland wanneer land (13.10) een waarde ongelijk aan '0000' (onbekend) heeft
    - veld 'type' krijgt de waarde 'VerblijfplaatsBuitenland'

    Abstract Scenario: verblijfplaats buitenland
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                | waarde        |
      | gemeenteVanInschrijving (09.10)     | 1999          |
      | datumInschrijvingInGemeente (09.20) | 20020701      |
      | land (13.10)                        | <land>        |
      | datumAanvangAdresBuitenland (13.20) | 20220128      |
      | adresregel1 (13.30)                 | <adresregel1> |
      | adresregel2 (13.40)                 | <adresregel2> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 555550001                          |
      | fields              | burgerservicenummer,verblijfplaats |
      Dan bevat de persoon met burgerservicenummer '555550001' alleen de volgende 'verblijfplaats' gegevens
      | naam                        | waarde                      |
      | type                        | VerblijfplaatsBuitenland    |
      | gemeenteVanInschrijving     | 1999                        |
      | datumInschrijvingInGemeente | 2002-07-01                  |
      | land                        | <land>                      |
      | adresregel1                 | 1600 Pennsylvania Avenue NW |
      | adresregel2                 | Washington, DC 20500        |
      | datumVan                    | 2022-01-28                  |

      Voorbeelden:
      | land | land omschrijving            | adresregel1                 | adresregel2                |
      | 6014 | Verenigde Staten van Amerika | 1600 Pennsylvania Avenue NW | Washington, DC 20500       |
      | 9999 | Internationaal gebied        |                             | Amundsen-Scott, Antarctica |

  Rule: Een verblijfplaats is een binnenlands adres wanneer straat (11.10) en/of huisnummer (11.20) een waarde heeft
    - veld 'type' krijgt de waarde 'Adres' 

    Abstract Scenario: verblijfplaats binnenlands adres
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                | waarde         |
      | gemeenteVanInschrijving (09.10)     | 0518           |
      | datumInschrijvingInGemeente (09.20) | 20020701       |
      | functieAdres (10.10)                | B              |
      | datumAanvangAdreshouding (10.30)    | 20220128       |
      | straat (11.10)                      | Spui           |
      | huisnummer (11.20)                  | 70             |
      | postcode (11.60)                    | 2511BT         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 555550001                          |
      | fields              | burgerservicenummer,verblijfplaats |
      Dan bevat de persoon met burgerservicenummer '555550001' alleen de volgende 'verblijfplaats' gegevens
      | naam                        | waarde                 |
      | type                        | Adres                  |
      | gemeenteVanInschrijving     | 0518                   |
      | datumInschrijvingInGemeente | 2002-07-01             |
      | functieAdres                | B                      |
      | straat                      | Spui                   |
      | korteNaam                   | Spui                   |
      | huisnummer                  | 70                     |
      | postcode                    | 2511BT                 |
      | woonplaats                  | 's-Gravenhage          |
      | adresregel1                 | Spui 70                |
      | adresregel2                 | 2511 BT  'S-GRAVENHAGE |
      | datumVan                    | 2022-01-28             |

  Rule: Een verblijfplaats is een binnenlandse locatie wanneer locatiebeschrijving (12.10) een waarde heeft
    - veld 'type' krijgt de waarde 'Locatie' 

    Abstract Scenario: verblijfplaats binnenlandse locatie
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                | waarde                     |
      | gemeenteVanInschrijving (09.10)     | 0546                       |
      | datumInschrijvingInGemeente (09.20) | 20020701                   |
      | functieAdres (10.10)                | W                          |
      | datumAanvangAdreshouding (10.30)    | 20220128                   |
      | locatiebeschrijving (12.10)         | Woonboot in de Grote Sloot |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 555550001                          |
      | fields              | burgerservicenummer,verblijfplaats |
      Dan bevat de persoon met burgerservicenummer '555550001' alleen de volgende 'verblijfplaats' gegevens
      | naam                        | waarde                     |
      | type                        | Locatie                    |
      | gemeenteVanInschrijving     | 0546                       |
      | datumInschrijvingInGemeente | 2002-07-01                 |
      | functieAdres                | W                          |
      | locatiebeschrijving         | Woonboot in de Grote Sloot |
      | woonplaats                  | Leiden                     |
      | adresregel1                 | Woonboot in de Grote Sloot |
      | adresregel2                 | LEIDEN                     |
      | datumVan                    | 2022-01-28                 |