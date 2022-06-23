# language: nl

@proxy @post-assert
Functionaliteit: verblijfplaats locatie

  Scenario: persoon heeft 'locatie' veld: 'locatiebeschrijving (12.10)'
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
    | fields              | verblijfplaats                  |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                              | waarde                     |
    | type                              | Locatie                    |
    | verblijfadres.locatiebeschrijving | Woonboot in de Grote Sloot |

  Abstract Scenario: persoon heeft 'locatie' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                        | waarde                     |
    | locatiebeschrijving (12.10) | Woonboot in de Grote Sloot |
    | <gba naam>                  | <waarde>                   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | verblijfplaats.<naam>           |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam   | waarde   |
    | type   | Locatie  |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam              | naam              | waarde |
    | functie adres (10.10) | functieAdres.code | W      |

  Abstract Scenario: persoon heeft 'locatie' datum veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                        | waarde                     |
    | locatiebeschrijving (12.10) | Woonboot in de Grote Sloot |
    | <gba naam>                  | <gba waarde>               |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | verblijfplaats.<naam>           |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam               | waarde         |
    | type               | Locatie        |
    | <naam>.type        | Datum          |
    | <naam>.datum       | <waarde>       |
    | <naam>.langFormaat | <lang formaat> |

    Voorbeelden:
    | gba naam                           | gba waarde | naam                  | waarde     | lang formaat     |
    | datum aanvang adreshouding (10.30) | 20220128   | datumVan              | 2022-01-28 | 28 januari 2022  |
    | datum ingang geldigheid (85.10)    | 20220222   | datumIngangGeldigheid | 2022-02-22 | 22 februari 2022 |

  Abstract Scenario: locatie veld(en) van persoon is/zijn in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                                     | waarde                     |
    | locatiebeschrijving (12.10)              | Woonboot in de Grote Sloot |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde>  |
    | datum ingang onderzoek (83.20)           | 20020701                   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | verblijfplaats.inOnderzoek      |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde                               |
    | type                                         | Locatie                              |
    | inOnderzoek.type                             | <type in onderzoek>                  |
    | inOnderzoek.datumVan                         | <datumVan in onderzoek>              |
    | inOnderzoek.datumIngangGeldigheid            | <datumIngangGeldigheid in onderzoek> |
    | inOnderzoek.functieAdres                     | <functieAdres in onderzoek>          |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                                |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                           |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                          |

    Voorbeelden:
    | gba in onderzoek waarde | type in onderzoek | datumVan in onderzoek | datumIngangGeldigheid in onderzoek | functieAdres in onderzoek |
    | 080000                  |                   | true                  | true                               | true                      |
    | 081000                  |                   | true                  |                                    | true                      |
    | 081010                  |                   |                       |                                    | true                      |
    | 081030                  |                   | true                  |                                    |                           |
    | 081300                  |                   | true                  |                                    |                           |
    | 081320                  |                   | true                  |                                    |                           |
    | 088500                  |                   |                       | true                               |                           |
    | 088510                  |                   |                       | true                               |                           |

  Abstract Scenario: 'verblijfadres locatie' veld(en) van persoon is/zijn in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                                     | waarde                     |
    | locatiebeschrijving (12.10)              | Woonboot in de Grote Sloot |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde>  |
    | datum ingang onderzoek (83.20)           | 20020701                   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                   |
    | type                | RaadpleegMetBurgerservicenummer          |
    | burgerservicenummer | 555550001                                |
    | fields              | verblijfplaats.verblijfadres.inOnderzoek |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                                       | waarde                             |
    | type                                                       | Locatie                            |
    | verblijfadres.inOnderzoek.locatiebeschrijving              | <locatiebeschrijving in onderzoek> |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum                              |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                         |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                        |

    Voorbeelden:
    | gba in onderzoek waarde | locatiebeschrijving in onderzoek | datumVan in onderzoek | datumIngangGeldigheid in onderzoek | nummeraanduidingIdentificatie in onderzoek | adresseerbaarObjectIdentificatie in onderzoek | functieAdres in onderzoek |
    | 080000                  | true                             |                       |                                    |                                            |                                               |                           |
    | 081200                  | true                             |                       |                                    |                                            |                                               |                           |
    | 081210                  | true                             |                       |                                    |                                            |                                               |                           |
