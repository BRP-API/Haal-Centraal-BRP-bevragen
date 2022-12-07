# language: nl

Functionaliteit: vertalen van gevraagde samengestelde of afgeleide verblijfplaats velden naar leveren van bron velden
  Wanneer met fields wordt gevraagd om een veld dat wordt samengesteld uit verschillende andere velden in de GbaPersoon of als een veld dat moet worden meegeleverd wordt samengesteld uit verschillende andere velden in de GbaPersoon, dan worden deze benodigde velden geleverd.

  Rule: wanneer een veld van verblijfplaats m.b.v. de alias 'verblijfplaatsBinnenland' wordt gevraagd worden alleen de velden die horen bij een binnenlandse verblijfplaats geleverd die nodig zijn voor het bepalen van het type binnenlands verblijfplaats.
    - dit betreft alle velden uit groepen 11 (adres) en 12 (locatie)
    - dit is het geval als de consumer niet geautoriseerd is voor buitenlandse adressen

    Abstract Scenario: met fields wordt gevraagd naar een adresveld m.b.v. de alias verblijfplaatsBinnenland
      Gegeven de persoon met burgerservicenummer '000000267' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde   |
      | functieAdres.code (10.10)              | W        |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                       | waarde                             |
      | straatnaam (11.10)                         | <straat>                           |
      | naam openbare ruimte (11.15)               | <straat>                           |
      | huisnummer (11.20)                         | <huisnummer>                       |
      | postcode (11.60)                           | <postcode>                         |
      | woonplaats (11.70)                         | <woonplaats>                       |
      | identificatiecode verblijfplaats (11.80)   | <adresseerbaarObjectIdentificatie> |
      | identificatiecode nummeraanduiding (11.90) | <nummeraanduidingIdentificatie>    |
      | locatiebeschrijving (12.10)                | <locatiebeschrijving>              |
      | gemeente_code                              | 0599                               |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000267                       |
      | fields              | verblijfplaats.verblijfadres<veld>  |
#      | fields              | verblijfplaatsBinnenland<veld>  |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                             | waarde                             |
      | straat                           | <straat>                           |
      | huisnummer                       | <huisnummer>                       |
      | postcode                         | <postcode>                         |
      | woonplaats                       | <woonplaats>                       |
      | locatiebeschrijving              | <locatiebeschrijving>              |
      | adresseerbaarObjectIdentificatie | <adresseerbaarObjectIdentificatie> |
      | nummeraanduidingIdentificatie    | <nummeraanduidingIdentificatie>    |
      | naamOpenbareRuimte               | <straat>                           |

      Voorbeelden:
      | veld                 | straat      | huisnummer | postcode | woonplaats | adresseerbaarObjectIdentificatie | nummeraanduidingIdentificatie | locatiebeschrijving          |
      | .straat              | Boterondiep | 31         | 3077AW   | Rotterdam  | 0599010000208579                 | 0599200000219678              |                              |
      | .locatiebeschrijving | Boterondiep | 31         | 3077AW   | Rotterdam  | 0599010000208579                 | 0599200000219678              |                              |
      |                      | Boterondiep | 31         | 3077AW   | Rotterdam  | 0599010000208579                 | 0599200000219678              |                              |
      | .straat              |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |
      | .locatiebeschrijving |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |
      |                      |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |

  Rule: wanneer een veld van verblijfplaats m.b.v. de alias 'verblijfplaatsBinnenland' wordt gevraagd en het veld 'land' heeft de waarde '0000' dan wordt dat veld geleverd zodat het type 'VerblijfplaatsOnbekend' kan worden bepaald.

    Scenario: met fields wordt gevraagd naar een adresveld bij een onbekend adres m.b.v. de alias verblijfplaatsBinnenland
      Gegeven de persoon met burgerservicenummer '000000292' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde   |
      | land (13.10)                           | 0000     |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000292                       |
      | fields              | verblijfplaats.verblijfadres.straat |
#      | fields              | verblijfplaatsBinnenland.straat |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam              | waarde   |
      | land.code         | 0000     |
      | land.omschrijving | Onbekend |
	  
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# In het volgende scenario heeft de persoon een buitenlandsadres, de consumer heeft echter geen rechten om een buitenlands adres uit te vragen en moet dus een leeg verblijfplaats geleverd krijgen.
# Hoe kan ik hier simuleren dat de consumer die rechten niet heeft?
    Scenario: met fields wordt gevraagd naar een buitenlandsadres veld waar de consumer geen rechten voor heeft
      Gegeven de persoon met burgerservicenummer '000000280' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde            |
      | land (13.10)                           | 5002              |
      | datum aanvang adres buitenland (13.20) | 20150808          |
      | regel 1 adres buitenland (13.30)       | 14 Rue Camulogene |
      | regel 2 adres buitenland (13.40)       | 75015 Parijs      |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000280                           |
      | fields              | verblijfplaats.verblijfadres.regel1 |
      Dan heeft de response een persoon met leeg 'verblijfplaats' object

  Rule: wanneer een veld van verblijfplaats zonder de alias 'verblijfplaatsBinnenland' wordt gevraagd, worden alle beschikbare verblijfplaats velden geleverd die nodig zijn voor het bepalen van het type verblijfplaats
    - dit betreft alle velden uit groepen 11 (adres), 12 (locatie) en land, regel 1, regel 2 en regel 3 van groep 13 (verblijf buitenland)

    Abstract Scenario: met fields wordt gevraagd naar een <omschrijving>adres veld zonder de alias verblijfplaatsBinnenland
      Gegeven de persoon met burgerservicenummer '000000279' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde     |
      | functieAdres.code (10.10)              | W          |
      | land (13.10)                           | <landcode> |
      | regel 1 adres buitenland (13.30)       | <regel 1>  |
      | regel 2 adres buitenland (13.40)       | <regel 2>  |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                       | waarde                             |
      | straatnaam (11.10)                         | <straat>                           |
      | naam openbare ruimte (11.15)               | <straat>                           |
      | huisnummer (11.20)                         | <huisnummer>                       |
      | postcode (11.60)                           | <postcode>                         |
      | woonplaats (11.70)                         | <woonplaats>                       |
      | identificatiecode verblijfplaats (11.80)   | <adresseerbaarObjectIdentificatie> |
      | identificatiecode nummeraanduiding (11.90) | <nummeraanduidingIdentificatie>    |
      | locatiebeschrijving (12.10)                | <locatiebeschrijving>              |
      | gemeente_code                              | 0599                               |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000279                           |
      | fields              | verblijfplaats.verblijfadres.<veld> |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                             | waarde                             |
      | straat                           | <straat>                           |
      | huisnummer                       | <huisnummer>                       |
      | postcode                         | <postcode>                         |
      | woonplaats                       | <woonplaats>                       |
      | locatiebeschrijving              | <locatiebeschrijving>              |
      | adresseerbaarObjectIdentificatie | <adresseerbaarObjectIdentificatie> |
      | nummeraanduidingIdentificatie    | <nummeraanduidingIdentificatie>    |
      | naamOpenbareRuimte               | <straat>                           |
      | land.code                        | <landcode>                         |
      | land.omschrijving                | <land omschrijving>                |
      | regel1                           | <regel 1>                          |
      | regel2                           | <regel 2>                          |

      Voorbeelden:
      | veld                | straat      | huisnummer | postcode | woonplaats | adresseerbaarObjectIdentificatie | nummeraanduidingIdentificatie | locatiebeschrijving          | landcode | land omschrijving |regel 1            | regel 2      | omschrijving |
      | straat              | Boterondiep | 31         | 3077AW   | Rotterdam  | 0599010000208579                 | 0599200000219678              |                              |          |                   |                   |              | binnenlands  |
      | locatiebeschrijving | Boterondiep | 31         | 3077AW   | Rotterdam  | 0599010000208579                 | 0599200000219678              |                              |          |                   |                   |              | locatie      |
      | regel1              | Boterondiep | 31         | 3077AW   | Rotterdam  | 0599010000208579                 | 0599200000219678              |                              |          |                   |                   |              | buitenlands  |
      | straat              |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |          |                   |                   |              | binnenlands  |
      | locatiebeschrijving |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |          |                   |                   |              | locatie      |
      | regel1              |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |          |                   |                   |              | buitenlands  |
      | straat              |             |            |          |            |                                  |                               |                              | 0599     | Frankrijk         | 14 Rue Camulogene | 75015 Parijs | binnenlands  |
      | locatiebeschrijving |             |            |          |            |                                  |                               |                              | 0599     | Frankrijk         | 14 Rue Camulogene | 75015 Parijs | locatie      |
      | regel1              |             |            |          |            |                                  |                               |                              | 0599     | Frankrijk         | 14 Rue Camulogene | 75015 Parijs | buitenlands  |
      | straat              |             |            |          |            |                                  |                               |                              | 0000     | onbekend          |                   |              | binnenlands  |
      | locatiebeschrijving |             |            |          |            |                                  |                               |                              | 0000     | onbekend          |                   |              | locatie      |
      | regel1              |             |            |          |            |                                  |                               |                              | 0000     | onbekend          |                   |              | buitenlands  |

  Rule: wanneer gevraagd wordt om verblijfplaatsBinnenland.datumVan van de verblijfplaats, wordt datumAanvangAdreshouding geleverd
    - dit datumveld wordt geleverd samen met de velden die automatisch geleverd worden omdat ze nodig zijn voor het bepalen van het type
    - dit is het geval als de consumer niet geautoriseerd is voor buitenlandse adressen

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Kan de situatie voorkomen dat land.code de waarde '0000' heeft en dat datumAanvangAdreshouding een waarde heeft? Zo ja, moeten die dan ook geleverd worden?
# Afhankelijk van de antwoorden op deze vraag het uitbecommentarieerde scenario hieronder invullen.

   Abstract Scenario: Vragen om datumVan van een <omschrijving>adres m.b.v. de alias verblijfplaatsBinnenland
      Gegeven de persoon met burgerservicenummer '000000310' heeft de volgende 'verblijfplaats' gegevens
      | naam                                       | waarde                     |
      | datum aanvang adreshouding (10.30)         | <datumAanvangAdreshouding> |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                       | waarde                             |
      | straatnaam (11.10)                         | <straat>                           |
      | naam openbare ruimte (11.15)               | <straat>                           |
      | huisnummer (11.20)                         | <huisnummer>                       |
      | postcode (11.60)                           | <postcode>                         |
      | woonplaats (11.70)                         | <woonplaats>                       |
      | identificatiecode verblijfplaats (11.80)   | <adresseerbaarObjectIdentificatie> |
      | identificatiecode nummeraanduiding (11.90) | <nummeraanduidingIdentificatie>    |
      | locatiebeschrijving (12.10)                | <locatiebeschrijving>              |
      | gemeente_code                              | 0599                               |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                            |
      | type                | RaadpleegMetBurgerservicenummer   |
      | burgerservicenummer | 000000310                         |
      | fields              | verblijfplaats.verblijfadres.datumVan |
#      | fields              | verblijfplaatsBinnenland.datumVan |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                             | waarde                             |
      | straat                           | <straat>                           |
      | huisnummer                       | <huisnummer>                       |
      | postcode                         | <postcode>                         |
      | woonplaats                       | <woonplaats>                       |
      | locatiebeschrijving              | <locatiebeschrijving>              |
      | adresseerbaarObjectIdentificatie | <adresseerbaarObjectIdentificatie> |
      | nummeraanduidingIdentificatie    | <nummeraanduidingIdentificatie>    |
      | datumAanvangAdreshouding         | <datumAanvangAdreshouding>         |

      Voorbeelden:
      | omschrijving | datumAanvangAdreshouding | straat      | huisnummer | postcode | woonplaats | adresseerbaarObjectIdentificatie | nummeraanduidingIdentificatie | locatiebeschrijving          |
      | binnenlands  | 20150808                 | Boterondiep | 31         | 3077AW   | Rotterdam  | 0599010000208579                 | 0599200000219678              |                              |
      | locatie      | 20000310                 |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |


#    Scenario: Vragen om datumVan bij een onbekend adres m.b.v. de alias verblijfplaatsBinnenland
#      Gegeven de persoon met burgerservicenummer '000000346' heeft de volgende 'verblijfplaats' gegevens
#      | naam                                       | waarde   |
#      | datum aanvang adres buitenland (13.20)     | 20080402 |
#      | land (13.10)                               | 0000     |
#      | ingangsdatum geldigheid (85.10)            | 20080402 |
#      Als gba personen wordt gezocht met de volgende parameters
#      | naam                | waarde                          |
#      | type                | RaadpleegMetBurgerservicenummer |
#      | burgerservicenummer | 000000346                       |
#      | fields              | verblijfplaats.datumVan         |
#      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
#      | naam                        | waarde   |
#      | land.code                   | 0000     |
#      | land.omschrijving           | Onbekend |
#      | datumAanvangAdresBuitenland | 20080402 |

  Rule: wanneer gevraagd wordt om datumVan van de verblijfplaats zonder de alias 'verblijfplaatsBinnenland', wordt datumAanvangAdreshouding of datumAanvangAdresBuitenland geleverd
    - deze datumvelden worden geleverd samen met de velden die automatisch geleverd worden omdat ze nodig zijn voor het bepalen van het type
    - datumAanvangAdreshouding wordt geleverd als velden van de groep 11 (adres) en 12 (locatie) worden geleverd
    - datumAanvangAdresBuitenland wordt geleverd als de velden land, regel 1, regel 2 en regel 3 van groep 13 (verblijf buitenland) worden geleverd

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Kan de situatie voorkomen dat land.code de waarde '0000' heeft en dat datumAanvangAdreshouding of datumAanvangAdresBuitenland een waarde heeft? Zo ja, moeten die dan ook geleverd worden?
# Afhankelijk van het antwoord op deze vragen de onderste voorbeelden aanpassen.

   Abstract Scenario: Vragen om datumVan van een <omschrijving>adres zonder de alias verblijfplaatsBinnenland
      Gegeven de persoon met burgerservicenummer '000000322' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde                       |
      | functieAdres.code (10.10)              | W                            |
      | datum aanvang adreshouding (10.30)     | <datumAanvangAdreshouding>   |
      | land (13.10)                           | <landcode>                   |
      | regel 1 adres buitenland (13.30)       | <regel 1>                    |
      | regel 2 adres buitenland (13.40)       | <regel 2>                    |
      | datum aanvang adres buitenland (13.20) | <datumAanvangAdresBuitenland |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                       | waarde                             |
      | straatnaam (11.10)                         | <straat>                           |
      | naam openbare ruimte (11.15)               | <straat>                           |
      | huisnummer (11.20)                         | <huisnummer>                       |
      | postcode (11.60)                           | <postcode>                         |
      | woonplaats (11.70)                         | <woonplaats>                       |
      | identificatiecode verblijfplaats (11.80)   | <adresseerbaarObjectIdentificatie> |
      | identificatiecode nummeraanduiding (11.90) | <nummeraanduidingIdentificatie>    |
      | locatiebeschrijving (12.10)                | <locatiebeschrijving>              |
      | gemeente_code                              | 0599                               |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000322                       |
      | fields              | verblijfplaats.datumVan         |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                             | waarde                             |
      | straat                           | <straat>                           |
      | huisnummer                       | <huisnummer>                       |
      | postcode                         | <postcode>                         |
      | woonplaats                       | <woonplaats>                       |
      | locatiebeschrijving              | <locatiebeschrijving>              |
      | adresseerbaarObjectIdentificatie | <adresseerbaarObjectIdentificatie> |
      | nummeraanduidingIdentificatie    | <nummeraanduidingIdentificatie>    |
      | datumAanvangAdreshouding         | <datumAanvangAdreshouding>         |
      | naamOpenbareRuimte               | <straat>                           |
      | land.code                        | <landcode>                         |
      | land.omschrijving                | <land omschrijving>                |
      | regel1                           | <regel 1>                          |
      | regel2                           | <regel 2>                          |
      | datumAanvangAdresBuitenland      | <datumAanvangAdresBuitenland>      |

      Voorbeelden:
      | straat      | huisnummer | postcode | woonplaats | adresseerbaarObjectIdentificatie | nummeraanduidingIdentificatie | locatiebeschrijving          | landcode | land omschrijving | regel 1           | regel 2      | omschrijving | datumAanvangAdreshouding | datumAanvangAdresBuitenland |
      | Boterondiep | 31         | 3077AW   | Rotterdam  | 0599010000208579                 | 0599200000219678              |                              |          |                   |                   |              | binnenlands  | 20150808                 |                             |
      | Boterondiep | 31         | 3077AW   | Rotterdam  | 0599010000208579                 | 0599200000219678              |                              |          |                   |                   |              | locatie      | 20150808                 |                             |
      | Boterondiep | 31         | 3077AW   | Rotterdam  | 0599010000208579                 | 0599200000219678              |                              |          |                   |                   |              | buitenlands  | 20150808                 |                             |
      |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |          |                   |                   |              | binnenlands  | 20150808                 |                             |
      |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |          |                   |                   |              | locatie      | 20150808                 |                             |
      |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |          |                   |                   |              | buitenlands  | 20150808                 |                             |
      |             |            |          |            |                                  |                               |                              | 0599     | Frankrijk         | 14 Rue Camulogene | 75015 Parijs | binnenlands  |                          | 20150808                    |
      |             |            |          |            |                                  |                               |                              | 0599     | Frankrijk         | 14 Rue Camulogene | 75015 Parijs | locatie      |                          | 20150808                    |
      |             |            |          |            |                                  |                               |                              | 0599     | Frankrijk         | 14 Rue Camulogene | 75015 Parijs | buitenlands  |                          | 20150808                    |
      |             |            |          |            |                                  |                               |                              | 0000     | onbekend          |                   |              | binnenlands  |                          |                             |
      |             |            |          |            |                                  |                               |                              | 0000     | onbekend          |                   |              | locatie      |                          |                             |
      |             |            |          |            |                                  |                               |                              | 0000     | onbekend          |                   |              | buitenlands  |                          |                             |
