# language: nl

Functionaliteit: Persoon: verblijfplaats buitenland velden vragen met fields

  Achtergrond:
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                   | waarde   |
    | datum aanvang adres buitenland (13.20) | 20150808 |
    | datum ingang geldigheid (85.10)        | 20220222 |

  Abstract Scenario: 'datum aanvang adres buitenland (13.20)' wordt gevraagd met field pad '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                 | waarde                   |
    | type                 | VerblijfplaatsBuitenland |
    | datumVan.type        | Datum                    |
    | datumVan.datum       | 2015-08-08               |
    | datumVan.langFormaat | 8 augustus 2015          |

    Voorbeelden:
    | fields                  |
    | verblijfplaats.datumVan |

  Abstract Scenario: 'datum ingang geldigheid (85.10)' wordt gevraagd met field pad '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                              | waarde                   |
    | type                              | VerblijfplaatsBuitenland |
    | datumIngangGeldigheid.type        | Datum                    |
    | datumIngangGeldigheid.datum       | 2022-02-22               |
    | datumIngangGeldigheid.langFormaat | 22 februari 2022         |

    Voorbeelden:
    | fields                               |
    | datumIngangGeldigheid                |
    | verblijfplaats.datumIngangGeldigheid |
