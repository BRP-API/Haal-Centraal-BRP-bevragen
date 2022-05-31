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
    | naam                 | waarde                   |
    | type                 | VerblijfplaatsBuitenland |

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
