# language: nl

Functionaliteit: vertalen van gevraagde samengestelde of afgeleide verblijfplaats velden naar leveren van bron velden
  Wanneer met fields wordt gevraagd om een veld dat wordt samengesteld uit verschillende andere velden in de GbaPersoon of als een veld dat moet worden meegeleverd wordt samengesteld uit verschillende andere velden in de GbaPersoon, dan worden deze benodigde velden geleverd.

  Rule: als met de alias verblijfplaatsBinnenland één of meerdere velden van een binnenlands verblijfplaats wordt gevraagd dan worden alle beschikbare verblijfplaats velden van Adres en/of Locatie geleverd
    - dit betreft alle velden uit groepen 11 (adres) en 12 (locatie)
    - dit geldt ongeacht of deze velden een standaardwaarde hebben of niet
    - een consumer die niet geautoriseerd is voor buitenlandse adressen dient deze alias te gebruiken

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
      | gemeentecode (92.10)                       | 0599                               |
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
      | .straat              | .           | .          | .        | .          | .                                | .                             |                              |
      | .locatiebeschrijving | .           | .          | .        | .          | .                                | .                             |                              |
      |                      | .           | .          | .        | .          | .                                | .                             |                              |
      | .straat              |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |
      | .locatiebeschrijving |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |
      |                      |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |
      | .straat              |             |            |          |            |                                  |                               | .                            |
      | .locatiebeschrijving |             |            |          |            |                                  |                               | .                            |
      |                      |             |            |          |            |                                  |                               | .                            |

  Rule: als de alias verblijfplaatsBinnenland of één of meerdere velden van verblijfplaatsBinnenland wordt gevraagd en er zijn geen waarden in de binnenlandsadres velden (dus ook geen standaardwaarden) dan wordt er geen verblijfplaats object teruggeleverd.

# Het is de vraag of dit scenario nog iets toevoegt aan het volgende.
    Scenario: met fields wordt gevraagd naar een adresveld bij een persoon zonder verblijfplaats m.b.v. de alias verblijfplaatsBinnenland
      Gegeven de persoon met burgerservicenummer '000000590' heeft de volgende gegevens
      | naam                  | waarde  |
      | geslachtsnaam (02.40) | Groenen |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                              |
      | type                | RaadpleegMetBurgerservicenummer                     |
      | burgerservicenummer | 000000590                                           |
      | fields              | burgerservicenummer,verblijfplaats.verblijfadres.straat |
#      | fields              | burgerservicenummer,verblijfplaatsBinnenland.straat |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000590 |
	  
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# In het volgende scenario heeft de persoon een buitenlandsadres, de consumer heeft echter geen rechten om een buitenlands adres uit te vragen en moet geen verblijfplaats object geleverd krijgen.
# Dit scenario moet nog worden uitgebreid met het zetten van de autorisatiegegevens van de consumer.
# Na het lezen van  https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/blob/autorisatie/features/autorisatie.feature denk ik dat scenario helemaal niet van toepassing is want de GBA API zal hier een foutmelding op gaan geven.
# Of is dit juist een situatie waarop geen foutmelding gegeven moet gaan worden omdat daar dan weer de conclusie uit getrokken kan worden dat betreffende persoon in het buitenland woont?
    Scenario: met fields wordt gevraagd naar een buitenlandsadres veld waar de consumer geen rechten voor heeft
      Gegeven de persoon met burgerservicenummer '000000590' heeft de volgende gegevens
      | naam                  | waarde  |
      | geslachtsnaam (02.40) | Groenen |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde            |
      | land (13.10)                           | 5002              |
      | datum aanvang adres buitenland (13.20) | 20150808          |
      | regel 1 adres buitenland (13.30)       | 14 Rue Camulogene |
      | regel 2 adres buitenland (13.40)       | 75015 Parijs      |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                  |
      | type                | RaadpleegMetBurgerservicenummer                         |
      | burgerservicenummer | 000000280                                               |
      | fields              | burgerservicenummer,verblijfplaats.verblijfadres.regel1 |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000590 |

  Rule: als verblijfplaats of één of meerdere velden van verblijfplaats wordt gevraagd en de consumer is geautoriseerd voor buitenlandse adressen, dan worden alle beschikbare verblijfplaats velden geleverd
    - dit betreft alle velden uit groepen 11 (adres), 12 (locatie) en land, regel 1, regel 2 en regel 3 van groep 13 (verblijf buitenland)
    - dit geldt ongeacht of deze velden een standaardwaarde hebben of niet

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
      | gemeentecode (92.10)                       | 0599                               |
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
      | veld                | straat      | huisnummer | postcode | woonplaats | adresseerbaarObjectIdentificatie | nummeraanduidingIdentificatie | locatiebeschrijving          | landcode | land omschrijving | regel 1           | regel 2      | omschrijving |
      | straat              | Boterondiep | 31         | 3077AW   | Rotterdam  | 0599010000208579                 | 0599200000219678              |                              |          |                   |                   |              | binnenlands  |
      | locatiebeschrijving | Boterondiep | 31         | 3077AW   | Rotterdam  | 0599010000208579                 | 0599200000219678              |                              |          |                   |                   |              | locatie      |
      | regel1              | Boterondiep | 31         | 3077AW   | Rotterdam  | 0599010000208579                 | 0599200000219678              |                              |          |                   |                   |              | buitenlands  |
      | straat              | .           | .          | .        | .          | .                                | .                             |                              |          |                   |                   |              | binnenlands  |
      | locatiebeschrijving | .           | .          | .        | .          | .                                | .                             |                              |          |                   |                   |              | locatie      |
      | regel1              | .           | .          | .        | .          | .                                | .                             |                              |          |                   |                   |              | buitenlands  |
      | straat              |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |          |                   |                   |              | binnenlands  |
      | locatiebeschrijving |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |          |                   |                   |              | locatie      |
      | regel1              |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |          |                   |                   |              | buitenlands  |
      | straat              |             |            |          |            |                                  |                               | .                            |          |                   |                   |              | binnenlands  |
      | locatiebeschrijving |             |            |          |            |                                  |                               | .                            |          |                   |                   |              | locatie      |
      | regel1              |             |            |          |            |                                  |                               | .                            |          |                   |                   |              | buitenlands  |
      | straat              |             |            |          |            |                                  |                               |                              | 0599     | Frankrijk         | 14 Rue Camulogene | 75015 Parijs | binnenlands  |
      | locatiebeschrijving |             |            |          |            |                                  |                               |                              | 0599     | Frankrijk         | 14 Rue Camulogene | 75015 Parijs | locatie      |
      | regel1              |             |            |          |            |                                  |                               |                              | 0599     | Frankrijk         | 14 Rue Camulogene | 75015 Parijs | buitenlands  |
      | straat              |             |            |          |            |                                  |                               |                              | 0000     | onbekend          |                   |              | binnenlands  |
      | locatiebeschrijving |             |            |          |            |                                  |                               |                              | 0000     | onbekend          |                   |              | locatie      |
      | regel1              |             |            |          |            |                                  |                               |                              | 0000     | onbekend          |                   |              | buitenlands  |

  Rule: wanneer gevraagd wordt om verblijfplaatsBinnenland.datumVan van de verblijfplaats, wordt datumAanvangAdreshouding geleverd
    - dit datumveld wordt geleverd samen met de velden die automatisch geleverd worden omdat ze nodig zijn voor het bepalen van het type
    - dit is het geval als de consumer niet geautoriseerd is voor buitenlandse adressen

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
      | gemeentecode (92.10)                       | 0599                               |
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
      | binnenlands  | 20150808                 | .           | .          | .        | .          | .                                | .                             |                              |
      | locatie      | 20000310                 |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |
      | locatie      | 20000310                 |             |            |          |            |                                  |                               | .                            |

  Rule: wanneer gevraagd wordt om datumVan van de verblijfplaats zonder de alias 'verblijfplaatsBinnenland', wordt datumAanvangAdreshouding of datumAanvangAdresBuitenland geleverd
    - deze datumvelden worden geleverd samen met de velden die automatisch geleverd worden omdat ze nodig zijn voor het bepalen van het type
    - datumAanvangAdreshouding wordt geleverd als velden van de groep 11 (adres) en 12 (locatie) worden geleverd
    - datumAanvangAdresBuitenland wordt geleverd als de velden land, regel 1, regel 2 en regel 3 van groep 13 (verblijf buitenland) worden geleverd

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Kan de situatie voorkomen dat land.code de waarde '0000' heeft en dat datumAanvangAdresBuitenland een waarde heeft? Zo ja, moeten die dan ook geleverd worden?
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
      | gemeentecode (92.10)                       | 0599                               |
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
      | .           | .          | .        | .          | .                                | .                             |                              |          |                   |                   |              | binnenlands  | 20150808                 |                             |
      | .           | .          | .        | .          | .                                | .                             |                              |          |                   |                   |              | locatie      | 20150808                 |                             |
      | .           | .          | .        | .          | .                                | .                             |                              |          |                   |                   |              | buitenlands  | 20150808                 |                             |
      |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |          |                   |                   |              | binnenlands  | 20150808                 |                             |
      |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |          |                   |                   |              | locatie      | 20150808                 |                             |
      |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |          |                   |                   |              | buitenlands  | 20150808                 |                             |
      |             |            |          |            |                                  |                               | .                            |          |                   |                   |              | binnenlands  | 20150808                 |                             |
      |             |            |          |            |                                  |                               | .                            |          |                   |                   |              | locatie      | 20150808                 |                             |
      |             |            |          |            |                                  |                               | .                            |          |                   |                   |              | buitenlands  | 20150808                 |                             |
      |             |            |          |            |                                  |                               |                              | 0599     | Frankrijk         | 14 Rue Camulogene | 75015 Parijs | binnenlands  |                          | 20150808                    |
      |             |            |          |            |                                  |                               |                              | 0599     | Frankrijk         | 14 Rue Camulogene | 75015 Parijs | locatie      |                          | 20150808                    |
      |             |            |          |            |                                  |                               |                              | 0599     | Frankrijk         | 14 Rue Camulogene | 75015 Parijs | buitenlands  |                          | 20150808                    |
      |             |            |          |            |                                  |                               |                              | 0000     | onbekend          |                   |              | binnenlands  |                          |                             |
      |             |            |          |            |                                  |                               |                              | 0000     | onbekend          |                   |              | locatie      |                          |                             |
      |             |            |          |            |                                  |                               |                              | 0000     | onbekend          |                   |              | buitenlands  |                          |                             |
