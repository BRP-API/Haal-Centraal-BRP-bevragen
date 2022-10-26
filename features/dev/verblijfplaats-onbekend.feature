# language: nl

Functionaliteit: Persoon: verblijfplaats onbekend

  Abstract Scenario: persoon heeft 'verblijfplaats onbekend' veld: 'functie adres (10.10)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    | functie adres (10.10)              | W        |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                      | waarde                 |
    | type                      | VerblijfplaatsOnbekend |
    | functieAdres.code         | W                      |
    | functieAdres.omschrijving | woonadres              |

    Voorbeelden:
    | field                       |
    | functieAdres                |
    | verblijfplaats.functieAdres |
    | functieAdres.code           |
    | functieAdres.omschrijving   |

  Abstract Scenario: persoon heeft 'verblijfplaats onbekend' datum veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20220128 |
    | datum ingang geldigheid (85.10)    | 20220222 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.<naam>           |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam               | waarde                 |
    | type               | VerblijfplaatsOnbekend |
    | <naam>.type        | Datum                  |
    | <naam>.datum       | <waarde>               |
    | <naam>.langFormaat | <lang formaat>         |

    Voorbeelden:
    | naam                  | waarde     | lang formaat     |
    | datumVan              | 2022-01-28 | 28 januari 2022  |
    | datumIngangGeldigheid | 2022-02-22 | 22 februari 2022 |

  Scenario: persoon heeft 'verblijfplaats onbekend' datum veld: 'datum aanvang adres buitenland (13.20)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                   | waarde   |
    | datum aanvang adres buitenland (13.20) | 20220128 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.datumVan         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                 | waarde                 |
    | type                 | VerblijfplaatsOnbekend |
    | datumVan.type        | Datum                  |
    | datumVan.datum       | 2022-01-28             |
    | datumVan.langFormaat | 28 januari 2022        |

  Abstract Scenario: 'verblijfplaats onbekend' veld(en) van persoon is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.inOnderzoek      |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde                               |
    | type                                         | VerblijfplaatsOnbekend               |
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

  Abstract Scenario: 'datum aanvang adreshouding (10.30)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.datumVan         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde                 |
    | type                                         | VerblijfplaatsOnbekend |
    | datumVan.type                                | Datum                  |
    | datumVan.datum                               | 2022-01-28             |
    | datumVan.langFormaat                         | 28 januari 2022        |
    | inOnderzoek.datumVan                         | true                   |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                  |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01             |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002            |

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
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000152                            |
    | fields              | verblijfplaats.datumIngangGeldigheid |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde                 |
    | type                                         | VerblijfplaatsOnbekend |
    | datumIngangGeldigheid.type                   | Datum                  |
    | datumIngangGeldigheid.datum                  | 2022-02-22             |
    | datumIngangGeldigheid.langFormaat            | 22 februari 2022       |
    | inOnderzoek.datumIngangGeldigheid            | true                   |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                  |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01             |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002            |

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
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.functieAdres     |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde                 |
    | type                                         | VerblijfplaatsOnbekend |
    | functieAdres.code                            | W                      |
    | functieAdres.omschrijving                    | woonadres              |
    | inOnderzoek.functieAdres                     | true                   |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                  |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01             |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002            |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081000                  |
    | 081010                  |

  Abstract Scenario: 'datum aanvang adreshouding (10.30)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000152                            |
    | fields              | verblijfplaats.datumIngangGeldigheid |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                 |
    | type | VerblijfplaatsOnbekend |

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
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.functieAdres     |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                 |
    | type | VerblijfplaatsOnbekend |

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
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.datumVan         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                 |
    | type | VerblijfplaatsOnbekend |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 081010                  |
