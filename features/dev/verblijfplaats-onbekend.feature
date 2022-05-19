# language: nl

@proxy @post-assert
Functionaliteit: verblijfplaats onbekend

  Abstract Scenario: persoon heeft 'verblijfplaats onbekend' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                        | waarde                     |
    | <gba naam>                  | <waarde>                   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | verblijfplaats.<naam>           |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam   | waarde   |
    | type   | VerblijfplaatsOnbekend  |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam              | naam              | waarde |
    | functie adres (10.10) | functieAdres.code | W      |

  Abstract Scenario: persoon heeft 'verblijfplaats onbekend' datum veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                        | waarde                     |
    | <gba naam>                  | <gba waarde>               |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                    |
    | type                | RaadpleegMetBurgerservicenummer           |
    | burgerservicenummer | 555550001                                 |
    | fields              | verblijfplaats.<naam> |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam               | waarde         |
    | type   | VerblijfplaatsOnbekend  |
    | <naam>.type        | Datum          |
    | <naam>.datum       | <waarde>       |
    | <naam>.langFormaat | <lang formaat> |

    Voorbeelden:
    | gba naam                           | gba waarde | naam                  | waarde     | lang formaat     |
    | datum aanvang adreshouding (10.30) | 20220128   | datumVan              | 2022-01-28 | 28 januari 2022  |
    | datum ingang geldigheid (85.10)    | 20220222   | datumIngangGeldigheid | 2022-02-22 | 22 februari 2022 |
    | datum aanvang adres buitenland (13.20) | 20220128   | datumVan              | 2022-01-28 | 28 januari 2022  |
