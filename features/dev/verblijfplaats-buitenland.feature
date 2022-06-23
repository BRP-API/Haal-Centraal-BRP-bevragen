# language: nl

@proxy @post-assert
Functionaliteit: verblijfplaats buitenland

  Abstract Scenario: persoon heeft 'verblijfplaats' veld: 'land adres buitenland (13.10)' met waarde ongelijk aan '0000'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                          | waarde |
    | land adres buitenland (13.10) | <land> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | verblijfplaats                  |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                    | waarde                   |
    | type                    | VerblijfplaatsBuitenland |
    | verblijfadres.land.code | <land>                   |

    Voorbeelden:
    | land |
    | 6014 |
    | 9999 |

  Abstract Scenario: persoon heeft 'verblijfplaats buitenland' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                          | waarde   |
    | land adres buitenland (13.10) | 6014     |
    | <gba naam>                    | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 555550001                           |
    | fields              | verblijfplaats.verblijfadres.<naam> |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                 | waarde                   |
    | type                 | VerblijfplaatsBuitenland |
    | verblijfadres.<naam> | <waarde>                 |

    Voorbeelden:
    | gba naam                         | naam              | waarde                       |
    | regel 1 adres buitenland (13.30) | regel1            | 1600 Pennsylvania Avenue NW  |
    | regel 2 adres buitenland (13.40) | regel2            | Washington, DC 20500         |
    | regel 3 adres buitenland (13.50) | regel3            | Selangor                     |
    | land.omschrijving                | land.omschrijving | Verenigde Staten van Amerika |

  Abstract Scenario: persoon heeft 'verblijfplaats buitenland' veld met onbekend waarde: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                             | waarde                      |
    | regel 1 adres buitenland (13.30) | 1600 Pennsylvania Avenue NW |
    | <gba naam>                       | <waarde>                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 555550001                           |
    | fields              | verblijfplaats.verblijfadres.<naam> |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                   |
    | type | VerblijfplaatsBuitenland |

    Voorbeelden:
    | gba naam                      | naam      | waarde |
    | land adres buitenland (13.10) | land.code | 0000   |

  Abstract Scenario: persoon heeft 'verblijfplaats buitenland' datum veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                          | waarde       |
    | land adres buitenland (13.10) | 6014         |
    | <gba naam>                    | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                    |
    | type                | RaadpleegMetBurgerservicenummer           |
    | burgerservicenummer | 555550001                                 |
    | fields              | burgerservicenummer,verblijfplaats.<naam> |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    Dan heeft de persoon de volgende 'verblijfplaats' gegevens
    | naam               | waarde                   |
    | type               | VerblijfplaatsBuitenland |
    | <naam>.type        | Datum                    |
    | <naam>.datum       | <waarde>                 |
    | <naam>.langFormaat | <lang formaat>           |

    Voorbeelden:
    | gba naam                               | gba waarde | naam                  | waarde     | lang formaat     |
    | datum aanvang adres buitenland (13.20) | 20220128   | datumVan              | 2022-01-28 | 28 januari 2022  |
    | datum ingang geldigheid (85.10)        | 20220222   | datumIngangGeldigheid | 2022-02-22 | 22 februari 2022 |

  Abstract Scenario: 'verblijfplaats buitenland' veld(en) van persoon is/zijn in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                                     | waarde                    |
    | land adres buitenland (13.10)            | 6014                      |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
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

  Abstract Scenario: 'verblijfadres buitenland' veld(en) van persoon is/zijn in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                                     | waarde                    |
    | land adres buitenland (13.10)            | 6014                      |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                   |
    | type                | RaadpleegMetBurgerservicenummer          |
    | burgerservicenummer | 555550001                                |
    | fields              | verblijfplaats.verblijfadres.inOnderzoek |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                                       | waarde                   |
    | type                                                       | VerblijfplaatsBuitenland |
    | verblijfadres.inOnderzoek.regel1                           | <regel1 in onderzoek>    |
    | verblijfadres.inOnderzoek.regel2                           | <regel2 in onderzoek>    |
    | verblijfadres.inOnderzoek.regel3                           | <regel3 in onderzoek>    |
    | verblijfadres.inOnderzoek.land                             | <land in onderzoek>      |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum                    |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01               |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002              |

    Voorbeelden:
    | gba in onderzoek waarde | regel1 in onderzoek | regel2 in onderzoek | regel3 in onderzoek | land in onderzoek |
    | 080000                  | true                | true                | true                | true              |
    | 081300                  | true                | true                | true                | true              |
    | 081310                  |                     |                     |                     | true              |
    | 081330                  | true                |                     |                     |                   |
    | 081340                  |                     | true                |                     |                   |
    | 081350                  |                     |                     | true                |                   |
