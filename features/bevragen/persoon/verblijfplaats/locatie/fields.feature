# language: nl

Functionaliteit: Persoon - verblijfplaats binnenland (locatie) velden vragen met fields

  Achtergrond:
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    | datum ingang geldigheid (85.10)    | 20220222 |
    | functie adres (10.10)              | W        |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeentecode (92.10)        | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |

  Scenario: 'datum aanvang adreshouding (10.30)' wordt gevraagd met field pad 'verblijfplaats.datumVan'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.datumVan         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                 | waarde          |
    | type                 | Locatie         |
    | datumVan.type        | Datum           |
    | datumVan.datum       | 2015-08-08      |
    | datumVan.langFormaat | 8 augustus 2015 |

  Scenario: 'datum ingang geldigheid (85.10)' wordt gevraagd met field pad 'verblijfplaats.datumIngangGeldigheid'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000152                            |
    | fields              | verblijfplaats.datumIngangGeldigheid |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                              | waarde           |
    | type                              | Locatie          |
    | datumIngangGeldigheid.type        | Datum            |
    | datumIngangGeldigheid.datum       | 2022-02-22       |
    | datumIngangGeldigheid.langFormaat | 22 februari 2022 |

  Abstract Scenario: 'functie adres (10.10)' wordt gevraagd met field pad '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                      | waarde    |
    | type                      | Locatie   |
    | functieAdres.code         | W         |
    | functieAdres.omschrijving | woonadres |

    Voorbeelden:
    | fields                                   |
    | verblijfplaats.functieAdres              |
    | verblijfplaats.functieAdres.code         |
    | verblijfplaats.functieAdres.omschrijving |

  Scenario: alle adres velden wordt gevraagd met field pad 'verblijfplaats'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats                  |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                              | waarde                      |
    | type                              | Locatie                     |
    | datumVan.type                     | Datum                       |
    | datumVan.datum                    | 2015-08-08                  |
    | datumVan.langFormaat              | 8 augustus 2015             |
    | datumIngangGeldigheid.type        | Datum                       |
    | datumIngangGeldigheid.datum       | 2022-02-22                  |
    | datumIngangGeldigheid.langFormaat | 22 februari 2022            |
    | functieAdres.code                 | W                           |
    | functieAdres.omschrijving         | woonadres                   |
    | verblijfadres.locatiebeschrijving | Woonboot bij de Grote Sloot |
