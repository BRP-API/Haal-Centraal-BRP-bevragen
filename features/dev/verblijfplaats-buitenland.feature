# language: nl

Functionaliteit: Persoon: verblijfplaats buitenland

  Abstract Scenario: 'datum aanvang adreshouding (10.30)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                   | waarde                    |
    | aanduiding in onderzoek (83.10)        | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)         | 20020701                  |
    | land adres buitenland (13.10)          | 6014                      |
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
    | land adres buitenland (13.10)   | 6014                      |
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
