# language: nl

Functionaliteit: Persoon: verblijfplaats locatie

  Abstract Scenario: locatie veld(en) van persoon is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeente_code               | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
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

  Abstract Scenario: locatie 'verblijfadres' veld(en) van persoon is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeente_code               | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                   |
    | type                | RaadpleegMetBurgerservicenummer          |
    | burgerservicenummer | 000000152                                |
    | fields              | verblijfplaats.verblijfadres.inOnderzoek |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                                       | waarde                             |
    | type                                                       | Locatie                            |
    | verblijfadres.inOnderzoek.locatiebeschrijving              | <locatiebeschrijving in onderzoek> |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum                              |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                         |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                        |

    Voorbeelden:
    | gba in onderzoek waarde | locatiebeschrijving in onderzoek |
    | 080000                  | true                             |
    | 081200                  | true                             |
    | 081210                  | true                             |

  Abstract Scenario: 'datum aanvang adreshouding (10.30)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeente_code               | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.datumVan         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde          |
    | type                                         | Locatie         |
    | datumVan.type                                | Datum           |
    | datumVan.datum                               | 2022-01-28      |
    | datumVan.langFormaat                         | 28 januari 2022 |
    | inOnderzoek.datumVan                         | true            |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum           |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01      |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002     |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081000                  |
    | 081030                  |
    | 081300                  |
    | 081320                  |

  Abstract Scenario: 'datum ingang geldigheid (85.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | datum ingang geldigheid (85.10) | 20220222                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeente_code               | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000152                            |
    | fields              | verblijfplaats.datumIngangGeldigheid |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde           |
    | type                                         | Locatie          |
    | datumIngangGeldigheid.type                   | Datum            |
    | datumIngangGeldigheid.datum                  | 2022-02-22       |
    | datumIngangGeldigheid.langFormaat            | 22 februari 2022 |
    | inOnderzoek.datumIngangGeldigheid            | true             |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum            |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01       |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002      |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 088500                  |
    | 088510                  |

  Abstract Scenario: 'functie adres (10.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | functie adres (10.10)           | W                         |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeente_code               | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.functieAdres     |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde      |
    | type                                         | Locatie     |
    | functieAdres.code                            | W           |
    | functieAdres.omschrijving                    | woonadres   |
    | inOnderzoek.functieAdres                     | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081000                  |
    | 081010                  |

  Abstract Scenario: 'locatiebeschrijving (12.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeente_code               | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                           |
    | type                | RaadpleegMetBurgerservicenummer                  |
    | burgerservicenummer | 000000152                                        |
    | fields              | verblijfplaats.verblijfadres.locatiebeschrijving |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                                       | waarde                      |
    | type                                                       | Locatie                     |
    | verblijfadres.locatiebeschrijving                          | Woonboot bij de Grote Sloot |
    | verblijfadres.inOnderzoek.locatiebeschrijving              | true                        |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum                       |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                  |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081200                  |
    | 081210                  |

  Abstract Scenario: 'datum aanvang adreshouding (10.30)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeente_code               | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000152                            |
    | fields              | verblijfplaats.datumIngangGeldigheid |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde  |
    | type | Locatie |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 081030                  |
    | 081300                  |
    | 081320                  |

  Abstract Scenario: 'datum ingang geldigheid (85.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | datum ingang geldigheid (85.10) | 20220222                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeente_code               | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.functieAdres     |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde  |
    | type | Locatie |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 088500                  |
    | 088510                  |

  Abstract Scenario: 'functie adres (10.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | functie adres (10.10)           | W                         |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeente_code               | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.datumVan         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde  |
    | type | Locatie |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 081000                  |
    | 081010                  |

  Abstract Scenario: 'locatiebeschrijving (12.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeente_code               | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000152                            |
    | fields              | verblijfplaats.datumIngangGeldigheid |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde  |
    | type | Locatie |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 081200                  |
    | 081210                  |
