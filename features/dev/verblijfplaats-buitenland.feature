# language: nl

Functionaliteit: Persoon: verblijfplaats buitenland

  Abstract Scenario: persoon heeft 'verblijfplaats buitenland' datum veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                   | waarde   |
    | land (13.10)                           | 6014     |
    | datum aanvang adres buitenland (13.20) | 20220128 |
    | datum ingang geldigheid (85.10)        | 20220222 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.<naam>           |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam               | waarde                   |
    | type               | VerblijfplaatsBuitenland |
    | <naam>.type        | Datum                    |
    | <naam>.datum       | <waarde>                 |
    | <naam>.langFormaat | <lang formaat>           |

    Voorbeelden:
    | naam                  | waarde     | lang formaat     |
    | datumVan              | 2022-01-28 | 28 januari 2022  |
    | datumIngangGeldigheid | 2022-02-22 | 22 februari 2022 |

  Abstract Scenario: 'verblijfplaats buitenland' veld(en) van persoon is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | land (13.10)                    | 6014                      |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.inOnderzoek      |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde                               |
    | type                                         | VerblijfplaatsBuitenland             |
    | inOnderzoek.type                             | <type in onderzoek>                  |
    | inOnderzoek.datumVan                         | <datumVan in onderzoek>              |
    | inOnderzoek.datumIngangGeldigheid            | <datumIngangGeldigheid in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                                |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                           |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                          |

    Voorbeelden:
    | gba in onderzoek waarde | type in onderzoek | datumVan in onderzoek | datumIngangGeldigheid in onderzoek |
    | 080000                  |                   | true                  | true                               |
    | 081000                  |                   | true                  |                                    |
    | 081030                  |                   | true                  |                                    |
    | 081300                  |                   | true                  |                                    |
    | 081320                  |                   | true                  |                                    |
    | 088500                  |                   |                       | true                               |
    | 088510                  |                   |                       | true                               |

  Abstract Scenario: 'datum aanvang adreshouding (10.30)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                   | waarde                    |
    | aanduiding in onderzoek (83.10)        | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)         | 20020701                  |
    | land (13.10)                           | 6014                      |
    | datum aanvang adres buitenland (13.20) | 20220128                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.datumVan         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde                   |
    | type                                         | VerblijfplaatsBuitenland |
    | datumVan.type                                | Datum                    |
    | datumVan.datum                               | 2022-01-28               |
    | datumVan.langFormaat                         | 28 januari 2022          |
    | inOnderzoek.datumVan                         | true                     |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                    |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01               |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002              |

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
    | land (13.10)                    | 6014                      |
    | datum ingang geldigheid (85.10) | 20220222                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000152                            |
    | fields              | verblijfplaats.datumIngangGeldigheid |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde                   |
    | type                                         | VerblijfplaatsBuitenland |
    | datumIngangGeldigheid.type                   | Datum                    |
    | datumIngangGeldigheid.datum                  | 2022-02-22               |
    | datumIngangGeldigheid.langFormaat            | 22 februari 2022         |
    | inOnderzoek.datumIngangGeldigheid            | true                     |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                    |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01               |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002              |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 088500                  |
    | 088510                  |

  Abstract Scenario: 'datum aanvang adreshouding (10.30)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                   | waarde                    |
    | aanduiding in onderzoek (83.10)        | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)         | 20020701                  |
    | land (13.10)                           | 6014                      |
    | datum aanvang adres buitenland (13.20) | 20220128                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000152                            |
    | fields              | verblijfplaats.datumIngangGeldigheid |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                   |
    | type | VerblijfplaatsBuitenland |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 081000                  |
    | 081030                  |
    | 081300                  |
    | 081320                  |

  Abstract Scenario: 'datum ingang geldigheid (85.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | land (13.10)                    | 6014                      |
    | datum ingang geldigheid (85.10) | 20220222                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.datumVan         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                   |
    | type | VerblijfplaatsBuitenland |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 088500                  |
    | 088510                  |
