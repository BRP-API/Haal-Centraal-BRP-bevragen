# language: nl

Functionaliteit: vertalen van gevraagde samengestelde of afgeleide verblijfplaats velden naar leveren van bron velden
  Wanneer met fields wordt gevraagd om een veld dat wordt samengesteld uit verschillende andere velden in de GbaPersoon of als een veld dat moet worden meegeleverd wordt samengesteld uit verschillende andere velden in de GbaPersoon, dan worden deze benodigde velden geleverd.

  Rule: als met de alias verblijfplaatsBinnenland één of meerdere velden van een binnenlands verblijfplaats wordt gevraagd dan worden de gevraagde velden geleverd aangevuld met de velden straat en locatiebeschrijving
    - dit geldt ongeacht of deze velden een standaardwaarde hebben of niet
    - een consumer die niet geautoriseerd is voor buitenlandse adressen dient deze alias te gebruiken

    Abstract Scenario: met fields wordt gevraagd naar een adresveld m.b.v. de alias verblijfplaatsBinnenland
      Gegeven de persoon met burgerservicenummer '000000267' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde   |
      | functieAdres.code (10.10)              | W        |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                       | waarde                |
      | straatnaam (11.10)                         | <straat>              |
      | naam openbare ruimte (11.15)               | <straat>              |
      | huisnummer (11.20)                         | <huisnrInBRP>         |
      | postcode (11.60)                           | <postcodeInBRP>       |
      | locatiebeschrijving (12.10)                | <locatiebeschrijving> |
      | gemeentecode (92.10)                       | 0599                  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000267                       |
      | fields              | <fields>                        |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                             | waarde                |
      | straat                           | <straat>              |
      | naamOpenbareRuimte               | <straat>              |
      | huisnummer                       | <huisnr>              |
      | postcode                         | <postcode>            |
	  | locatiebeschrijving              | <locatiebeschrijving> |

# Zodra dat kan 'verblijfplaats.verblijfadres' vervangen door 'verblijfplaatsBinnenland'
      Voorbeelden:
      | fields                                                                      | straat      | huisnrInBRP | huisnr | postcodeInBRP  | postcode  | locatiebeschrijving          |
      | verblijfplaats.verblijfadres.straat                                         | Boterondiep | 31          |        | 3077AW         |           |                              |
      | verblijfplaats.verblijfadres.huisnummer                                     | Boterondiep | 31          | 31     | 3077AW         |           |                              |
      | verblijfplaats.verblijfadres.straat,verblijfplaats.verblijfadres.huisnummer | Boterondiep | 31          | 31     | 3077AW         |           |                              |
      | verblijfplaats.verblijfadres.straat,verblijfplaats.verblijfadres.postcode   | Boterondiep | 31          |        | 3077AW         | 3077AW    |                              |
      | verblijfplaats.verblijfadres.locatiebeschrijving                            | Boterondiep | 31          |        | 3077AW         |           |                              |
      | verblijfplaats.type                                                         | Boterondiep | 31          |        | 3077AW         |           |                              |
      | verblijfplaats.verblijfadres                                                | Boterondiep | 31          | 31     | 3077AW         | 3077AW    |                              |
      | verblijfplaats.verblijfadres.straat                                         | .           | 0           |        | 3077AW         |           |                              |
      | verblijfplaats.verblijfadres.huisnummer                                     | .           | 0           | 0      | 3077AW         |           |                              |
      | verblijfplaats.verblijfadres.straat,verblijfplaats.verblijfadres.huisnummer | .           | 0           | 0      | 3077AW         |           |                              |
      | verblijfplaats.verblijfadres.straat,verblijfplaats.verblijfadres.postcode   | .           | 0           |        | 3077AW         | 3077AW    |                              |
      | verblijfplaats.verblijfadres.locatiebeschrijving                            | .           | 0           |        | 3077AW         |           |                              |
      | verblijfplaats.type                                                         | .           | 0           |        | 3077AW         |           |                              |
      | verblijfplaats.verblijfadres                                                | .           | 0           | 0      | 3077AW         | 3077AW    |                              |
      | verblijfplaats.verblijfadres.straat                                         |             |             |        |                |           | Woonboot in de Grotere Sloot |
      | verblijfplaats.verblijfadres.locatiebeschrijving                            |             |             |        |                |           | Woonboot in de Grotere Sloot |
      | verblijfplaats.type                                                         |             |             |        |                |           | Woonboot in de Grotere Sloot |
      | verblijfplaats.verblijfadres                                                |             |             |        |                |           | Woonboot in de Grotere Sloot |

  Rule: als verblijfplaats of één of meerdere velden van verblijfplaats wordt gevraagd dan worden de gevraagde velden geleverd aangevuld met de velden straat, locatiebeschrijving en land
    - dit geldt ongeacht of deze velden een standaardwaarde hebben of niet
    - alleen een consumer die geautoriseerd is voor buitenlandse adressen mag deze variant gebruiken

    Abstract Scenario: met fields wordt gevraagd naar een <omschrijving> adres veld zonder de alias verblijfplaatsBinnenland
      Gegeven de persoon met burgerservicenummer '000000279' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde        |
      | functieAdres.code (10.10)              | W             |
      | land (13.10)                           | <landcode>    |
      | regel 1 adres buitenland (13.30)       | <regel1InBRP> |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                       | waarde                |
      | straatnaam (11.10)                         | <straat>              |
      | naam openbare ruimte (11.15)               | <straat>              |
      | huisnummer (11.20)                         | <huisnrInBRP>         |
      | postcode (11.60)                           | <postcodeInBRP>       |
      | locatiebeschrijving (12.10)                | <locatiebeschrijving> |
      | gemeentecode (92.10)                       | 0599                  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000279                       |
      | fields              | <fields>                        |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                             | waarde                |
      | straat                           | <straat>              |
      | naamOpenbareRuimte               | <straat>              |
      | huisnummer                       | <huisnr>              |
      | postcode                         | <postcode>            |
      | locatiebeschrijving              | <locatiebeschrijving> |
      | land.code                        | <landcode>            |
      | regel1                           | <regel1>              |

      Voorbeelden:
      | fields                                                                      | straat      | huisnrInBRP | huisnr | postcodeInBRP | postcode | locatiebeschrijving          | landcode | regel1InBRP       | regel1            | omschrijving |
      | verblijfplaats.verblijfadres.straat                                         | Boterondiep | 31          |        | 3077AW        |          |                              |          |                   |                   | binnenlands  |
      | verblijfplaats.verblijfadres.huisnummer                                     | Boterondiep | 31          | 31     | 3077AW        |          |                              |          |                   |                   | binnenlands  |
      | verblijfplaats.verblijfadres.straat,verblijfplaats.verblijfadres.huisnummer | Boterondiep | 31          | 31     | 3077AW        |          |                              |          |                   |                   | binnenlands  |
      | verblijfplaats.verblijfadres.postcode                                       | Boterondiep | 31          |        | 3077AW        | 3077AW   |                              |          |                   |                   | binnenlands  |
      | verblijfplaats.type                                                         | Boterondiep | 31          |        | 3077AW        |          |                              |          |                   |                   | type         |
      | verblijfplaats.verblijfadres.locatiebeschrijving                            | Boterondiep | 31          |        | 3077AW        |          |                              |          |                   |                   | locatie      |
      | verblijfplaats.regel1                                                       | Boterondiep | 31          |        | 3077AW        |          |                              |          |                   |                   | buitenlands  |
      | verblijfplaats.verblijfadres.straat                                         | .           | 0           |        | 3077AW        |          |                              |          |                   |                   | binnenlands  |
      | verblijfplaats.verblijfadres.huisnummer                                     | .           | 0           | 0      | 3077AW        |          |                              |          |                   |                   | binnenlands  |
      | verblijfplaats.verblijfadres.straat,verblijfplaats.verblijfadres.huisnummer | .           | 0           | 0      | 3077AW        |          |                              |          |                   |                   | binnenlands  |
      | verblijfplaats.verblijfadres.postcode                                       | .           | 0           |        | 3077AW        | 3077AW   |                              |          |                   |                   | binnenlands  |
      | verblijfplaats.type                                                         | .           | 0           |        | 3077AW        |          |                              |          |                   |                   | type         |
      | verblijfplaats.verblijfadres.locatiebeschrijving                            | .           | 0           |        | 3077AW        |          |                              |          |                   |                   | locatie      |
      | verblijfplaats.regel1                                                       | .           | 0           |        | 3077AW        |          |                              |          |                   |                   | buitenlands  |
      | verblijfplaats.verblijfadres.straat                                         |             |             |        |               |          | Woonboot in de Grotere Sloot |          |                   |                   | binnenlands  |
      | verblijfplaats.type                                                         |             |             |        |               |          | Woonboot in de Grotere Sloot |          |                   |                   | type         |
      | verblijfplaats.verblijfadres.locatiebeschrijving                            |             |             |        |               |          | Woonboot in de Grotere Sloot |          |                   |                   | locatie      |
      | verblijfplaats.verblijfadres.regel1                                         |             |             |        |               |          | Woonboot in de Grotere Sloot |          |                   |                   | buitenlands  |
      | verblijfplaats.verblijfadres.straat                                         |             |             |        |               |          |                              | 0599     | 14 Rue Camulogene |                   | binnenlands  |
      | verblijfplaats.type                                                         |             |             |        |               |          |                              | 0599     | 14 Rue Camulogene |                   | type         |
      | verblijfplaats.verblijfadres.locatiebeschrijving                            |             |             |        |               |          |                              | 0599     | 14 Rue Camulogene |                   | locatie      |
      | verblijfplaats.regel1                                                       |             |             |        |               |          |                              | 0599     | 14 Rue Camulogene | 14 Rue Camulogene | buitenlands  |
      | verblijfplaats.regel1,verblijfplaats.land                                   |             |             |        |               |          |                              | 0599     | 14 Rue Camulogene | 14 Rue Camulogene | buitenlands  |
      | verblijfplaats.verblijfadres.straat                                         |             |             |        |               |          |                              | 0000     |                   |                   | binnenlands  |
      | verblijfplaats.type                                                         |             |             |        |               |          |                              | 0000     |                   |                   | type         |
      | verblijfplaats.verblijfadres.locatiebeschrijving                            |             |             |        |               |          |                              | 0000     |                   |                   | locatie      |
      | verblijfplaats.regel1                                                       |             |             |        |               |          |                              | 0000     |                   |                   | buitenlands  |

  Rule: wanneer gevraagd wordt om verblijfplaatsBinnenland.datumVan van de verblijfplaats, wordt datumAanvangAdreshouding geleverd
    - dit datumveld wordt geleverd samen met de velden die automatisch geleverd worden omdat ze nodig zijn voor het bepalen van het type
    - een consumer die niet geautoriseerd is voor buitenlandse adressen dient deze vorm te gebruiken

   Abstract Scenario: Vragen om datumVan van een <omschrijving>adres m.b.v. de alias verblijfplaatsBinnenland
      Gegeven de persoon met burgerservicenummer '000000310' heeft de volgende 'verblijfplaats' gegevens
      | naam                               | waarde                     |
      | datum aanvang adreshouding (10.30) | <datumAanvangAdreshouding> |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                         | waarde                |
      | straatnaam (11.10)           | <straat>              |
      | naam openbare ruimte (11.15) | <straat>              |
      | locatiebeschrijving (12.10)  | <locatiebeschrijving> |
      | gemeentecode (92.10)         | 0599                  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000310                       |
      | fields              | verblijfplaats.datumVan         |
#      | fields              | verblijfplaatsBinnenland.datumVan |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                             | waarde                     |
      | straat                           | <straat>                   |
      | naamOpenbareRuimte               | <straat>                   |
      | locatiebeschrijving              | <locatiebeschrijving>      |
      | datumAanvangAdreshouding         | <datumAanvangAdreshouding> |

      Voorbeelden:
      | omschrijving | datumAanvangAdreshouding | straat      | locatiebeschrijving          |
      | binnenlands  | 20150808                 | Boterondiep |                              |
      | binnenlands  | 20150808                 | .           |                              |
      | locatie      | 20000310                 |             | Woonboot in de Grotere Sloot |

  Rule: wanneer gevraagd wordt om datumVan van de verblijfplaats zonder de alias 'verblijfplaatsBinnenland', wordt datumAanvangAdreshouding of datumAanvangAdresBuitenland geleverd
    - deze datumvelden worden geleverd samen met de velden die automatisch geleverd worden omdat ze nodig zijn voor het bepalen van het type
    - datumAanvangAdreshouding wordt geleverd als de velden straat en locatiebeschrijving worden geleverd
    - datumAanvangAdresBuitenland wordt geleverd als het veld land wordt geleverd

   Abstract Scenario: Vragen om datumVan van een <omschrijving>adres zonder de alias verblijfplaatsBinnenland
      Gegeven de persoon met burgerservicenummer '000000322' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde                       |
      | functieAdres.code (10.10)              | W                            |
      | datum aanvang adreshouding (10.30)     | <datumAanvangAdreshouding>   |
      | land (13.10)                           | <landcode>                   |
      | datum aanvang adres buitenland (13.20) | <datumAanvangAdresBuitenland |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                         | waarde                |
      | straatnaam (11.10)           | <straat>              |
      | naam openbare ruimte (11.15) | <straat>              |
      | locatiebeschrijving (12.10)  | <locatiebeschrijving> |
      | gemeentecode (92.10)         | 0599                  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000322                       |
      | fields              | verblijfplaats.datumVan         |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                             | waarde                        |
      | straat                           | <straat>                      |
      | naamOpenbareRuimte               | <straat>                      |
      | locatiebeschrijving              | <locatiebeschrijving>         |
      | datumAanvangAdreshouding         | <datumAanvangAdreshouding>    |
      | land.code                        | <landcode>                    |
      | datumAanvangAdresBuitenland      | <datumAanvangAdresBuitenland> |

      Voorbeelden:
      | straat      | locatiebeschrijving          | landcode | omschrijving | datumAanvangAdreshouding | datumAanvangAdresBuitenland |
      | Boterondiep |                              |          | binnenlands  | 20150808                 |                             |
      | Boterondiep |                              |          | locatie      | 20150808                 |                             |
      | Boterondiep |                              |          | buitenlands  | 20150808                 |                             |
      | .           |                              |          | binnenlands  | 20150808                 |                             |
      | .           |                              |          | locatie      | 20150808                 |                             |
      | .           |                              |          | buitenlands  | 20150808                 |                             |
      |             | Woonboot in de Grotere Sloot |          | binnenlands  | 20150808                 |                             |
      |             | Woonboot in de Grotere Sloot |          | locatie      | 20150808                 |                             |
      |             | Woonboot in de Grotere Sloot |          | buitenlands  | 20150808                 |                             |
      |             |                              | 0599     | binnenlands  |                          | 20150808                    |
      |             |                              | 0599     | locatie      |                          | 20150808                    |
      |             |                              | 0599     | buitenlands  |                          | 20150808                    |
      |             |                              | 0000     | binnenlands  |                          | 20150808                    |
      |             |                              | 0000     | locatie      |                          | 20150808                    |
      |             |                              | 0000     | buitenlands  |                          | 20150808                    |
      |             |                              | 0000     | binnenlands  |                          |                             |
      |             |                              | 0000     | locatie      |                          |                             |
      |             |                              | 0000     | buitenlands  |                          |                             |
