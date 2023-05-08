#language: nl

@gba
Functionaliteit: ZoekMetStraatHuisnummerEnGemeenteVanInschrijving met diakriet en wildcard en case insensitive

    Abstract Scenario: zoeken met straat zoekt met of zonder diakrieten, case insensitive en met wildcard
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0518                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | straatnaam (diakrieten) | naam openbare ruimte (11.15) | naam openbare ruimte (diakrieten) | huisnummer (11.20) |
      | 0518                 | Burg Scholvinckpln | Burg Schölvinckpln      | Burgemeester Scholvinckplein | Burgemeester Schölvinckplein      | 39                 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                    | waarde                                           |
      | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
      | straat                  | <straat>                                         |
      | huisnummer              | 39                                               |
      | gemeenteVanInschrijving | 0518                                             |
      | fields                  | burgerservicenummer                              |
      Dan heeft de response 1 persoon
      En heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000024 |

      Voorbeelden:
      | straat                       |
      | Burg Scholvinckpln           |
      | Burg Schölvinckpln           |
      | Burgemeester Scholvinckplein |
      | Burgemeester Schölvinckplein |
      | burg Scholvinckpln           |
      | burg Schölvinckpln           |
      | burgemeester scholvinckplein |
      | burgemeester schölvinckplein |
      | BURG SCHOLVINCKPLN           |
      | BURG SCHÖLVINCKPLN           |
      | BURGEMEESTER SCHOLVINCKPLEIN |
      | BURGEMEESTER SCHÖLVINCKPLEIN |
      | *Scholvinckpln               |
      | *Schölvinckpln               |
      | *Scholvinckplein             |
      | *Schölvinckplein             |
      | Burg Scholvin*               |
      | Burg Schölvin*               |
      | Burgemeester Scholvin*       |
      | Burgemeester Schölvin*       |
      | *scholvinckpln               |
      | *schölvinckpln               |
      | *scholvinckplein             |
      | *schölvinckplein             |
      | burg scholvin*               |
      | burg schölvin*               |
      | burgemeester scholvin*       |
      | burgemeester schölvin*       |
      | *SCHOLVINCKPLN               |
      | *SCHÖLVINCKPLN               |
      | *SCHOLVINCKPLEIN             |
      | *SCHÖLVINCKPLEIN             |
      | BURG SCHOLVIN*               |
      | BURG SCHÖLVIN*               |
      | BURGEMEESTER SCHOLVIN*       |
      | BURGEMEESTER SCHÖLVIN*       |

    Abstract Scenario: Wanneer je een diakriet gebruikt in een parameter, dan moet die ook gebruikt worden bij zoeken
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0518                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | straatnaam (diakrieten) | naam openbare ruimte (11.15) | naam openbare ruimte (diakrieten) | huisnummer (11.20) |
      | 0518                 | Burg Scholvinckpln | Burg Schölvinckpln      | Burgemeester Scholvinckplein | Burgemeester Schölvinckplein      | 39                 |
      En de persoon met burgerservicenummer '000000048' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0518                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | straatnaam (diakrieten) | naam openbare ruimte (11.15) | naam openbare ruimte (diakrieten) | huisnummer (11.20) |
      | 0518                 | Burg Scholvinckpln |                         | Burgemeester Scholvinckplein |                                   | 39                 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                    | waarde                                           |
      | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
      | straat                  | <straat>                                         |
      | huisnummer              | 39                                               |
      | gemeenteVanInschrijving | 0518                                             |
      | fields                  | burgerservicenummer                              |
      Dan heeft de response <aantal> personen

      Voorbeelden:
      | straat                       | aantal |
      | Burg Scholvinckpln           | 2      |
      | Burg Schölvinckpln           | 1      |
      | Burgemeester Scholvinckplein | 2      |
      | Burgemeester Schölvinckplein | 1      |
      | *Scholvinckplein             | 2      |
      | *Schölvinckplein             | 1      |

