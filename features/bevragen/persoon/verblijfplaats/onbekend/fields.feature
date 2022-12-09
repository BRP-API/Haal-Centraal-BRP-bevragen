#language: nl

Functionaliteit: verblijfplaats onbekend velden vragen met fields

  Achtergrond:
    Gegeven de persoon met burgerservicenummer '000000153' heeft de volgende 'verblijfplaats' gegevens
    | naam                                   | waarde   |
    | land adres buitenland (13.10)          | 0000     |
    | datum aanvang adres buitenland (13.20) | 20160808 |
    | datum ingang geldigheid (85.10)        | 20200222 |

  Scenario: 'datum aanvang adres buitenland (13.20)' wordt gevraagd met field pad 'verblijfplaats.datumVan'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000153                       |
    | fields              | verblijfplaats.datumVan         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                 | waarde                 |
    | type                 | VerblijfplaatsOnbekend |
    | datumVan.type        | Datum                  |
    | datumVan.datum       | 2016-08-08             |
    | datumVan.langFormaat | 8 augustus 2016        |

  Scenario: 'datum ingang geldigheid (85.10)' wordt gevraagd met field pad 'verblijfplaats.datumIngangGeldigheid'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000153                            |
    | fields              | verblijfplaats.datumIngangGeldigheid |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                              | waarde                 |
    | type                              | VerblijfplaatsOnbekend |
    | datumIngangGeldigheid.type        | Datum                  |
    | datumIngangGeldigheid.datum       | 2020-02-22             |
    | datumIngangGeldigheid.langFormaat | 22 februari 2020       |

  Scenario: alle velden wordt gevraagd met field pad 'verblijfplaats'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000153                       |
    | fields              | verblijfplaats                  |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                              | waarde                 |
    | type                              | VerblijfplaatsOnbekend |
    | datumVan.type                     | Datum                  |
    | datumVan.datum                    | 2016-08-08             |
    | datumVan.langFormaat              | 8 augustus 2016        |
    | datumIngangGeldigheid.type        | Datum                  |
    | datumIngangGeldigheid.datum       | 2020-02-22             |
    | datumIngangGeldigheid.langFormaat | 22 februari 2020       |
