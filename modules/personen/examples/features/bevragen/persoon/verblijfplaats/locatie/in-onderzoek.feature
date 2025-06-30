# language: nl

Functionaliteit: Persoon: verblijfplaats binnenland (locatie) velden zijn in onderzoek

Regel: Het in onderzoek zijn van een veld en bijbehorende datumIngangOnderzoek worden geleverd als het betreffende veld wordt gevraagd

  Abstract Scenario: '<type>' is in onderzoek en alle adres velden excl. verblijfadres velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeentecode (92.10)        | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                   |
    | type                | RaadpleegMetBurgerservicenummer                                                          |
    | burgerservicenummer | 000000152                                                                                |
    | fields              | verblijfplaats.datumVan,verblijfplaats.datumIngangGeldigheid,verblijfplaats.functieAdres |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde                     |
    | type                                         | Locatie                    |
    | inOnderzoek.type                             | <type io>                  |
    | inOnderzoek.datumVan                         | <datumVan io>              |
    | inOnderzoek.datumIngangGeldigheid            | <datumIngangGeldigheid io> |
    | inOnderzoek.functieAdres                     | <functieAdres io>          |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                      |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                 |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                |

    Voorbeelden:
    | aanduiding in onderzoek | type io | datumVan io | datumIngangGeldigheid io | functieAdres io | type                          |
    | 080000                  | true    | true        | true                     | true            | hele categorie verblijfplaats |
    | 081000                  |         | true        |                          | true            | hele groep adreshouding       |
    | 081010                  |         |             |                          | true            | functie adres                 |
    | 081030                  |         | true        |                          |                 | datum aanvang adreshouding    |
    | 081200                  | true    |             |                          |                 | hele groep locatie            |
    | 081210                  | true    |             |                          |                 | locatiebeschrijving           |
    | 088500                  |         |             | true                     |                 | hele groep geldigheid         |
    | 088510                  |         |             | true                     |                 | datum ingang geldigheid       |

  Abstract Scenario: 'datum aanvang adreshouding (10.30)' is in onderzoek, en wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeentecode (92.10)        | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.datumVan         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde      |
    | type                                         | Locatie     |
    | inOnderzoek.type                             | <type io>   |
    | inOnderzoek.datumVan                         | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | type io |
    | 080000                  | true    |
    | 081000                  |         |
    | 081030                  |         |

  Abstract Scenario: 'datum ingang geldigheid (85.10)' is in onderzoek, en wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeentecode (92.10)        | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000152                            |
    | fields              | verblijfplaats.datumIngangGeldigheid |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde      |
    | type                                         | Locatie     |
    | inOnderzoek.type                             | <type io>   |
    | inOnderzoek.datumIngangGeldigheid            | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | type io |
    | 080000                  | true    |
    | 088500                  |         |
    | 088510                  |         |

  Abstract Scenario: 'functie adres (10.10)' is in onderzoek, en wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeentecode (92.10)        | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.functieAdres     |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde      |
    | type                                         | Locatie     |
    | inOnderzoek.type                             | <type io>   |
    | inOnderzoek.functieAdres                     | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | type io |
    | 080000                  | true    |
    | 081000                  |         |
    | 081010                  |         |

  Scenario: 'datum aanvang adreshouding (10.30)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde   |
    | aanduiding in onderzoek (83.10) | 081030   |
    | datum ingang onderzoek (83.20)  | 20020701 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeentecode (92.10)        | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000152                            |
    | fields              | verblijfplaats.datumIngangGeldigheid |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde  |
    | type | Locatie |

  Abstract Scenario: 'datum ingang geldigheid (85.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | datum ingang geldigheid (85.10) | 20220222                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeentecode (92.10)        | 0518                        |
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
    | gemeentecode (92.10)        | 0518                        |
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
    | 081010                  |

Regel: 'type' veld van 'verblijfplaats binnenland (locatie)' is in onderzoek als het identificerende gegeven van locatie ('locatiebeschrijving (12.10)') in onderzoek is

  Abstract Scenario: '<type>' veld is in onderzoek en functieAdres wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeentecode (92.10)        | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.functieAdres     |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde  |
    | type | Locatie |
    En heeft de 'verblijfplaats' de volgende 'inOnderzoek' gegevens
    | naam                             | waarde            |
    | type                             | true              |
    | functieAdres                     | <functieAdres io> |
    | datumIngangOnderzoek.type        | Datum             |
    | datumIngangOnderzoek.datum       | 2002-07-01        |
    | datumIngangOnderzoek.langFormaat | 1 juli 2002       |

    Voorbeelden:
    | aanduiding in onderzoek | functieAdres io | type                          |
    | 080000                  | true            | hele categorie verblijfplaats |
    | 081200                  |                 | hele groep locatie            |
    | 081210                  |                 | locatiebeschrijving           |
