# language: nl

Functionaliteit: Persoon: verblijfplaats buitenland in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en datumVan en datumIngangGeldigheid worden gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | land adres buitenland (13.10)   | 6014                      |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                       |
    | type                | RaadpleegMetBurgerservicenummer                              |
    | burgerservicenummer | 000000152                                                    |
    | fields              | verblijfplaats.datumVan,verblijfplaats.datumIngangGeldigheid |
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
    | 080000                  | true              | true                  | true                               |
    | 081000                  |                   | true                  |                                    |
    | 081030                  |                   | true                  |                                    |
    | 081300                  | true              | true                  |                                    |
    | 081310                  | true              |                       |                                    |
    | 081320                  |                   | true                  |                                    |
    | 088500                  |                   |                       | true                               |
    | 088510                  |                   |                       | true                               |

  Abstract Scenario: '<type>' is in onderzoek, maar 'datumVan' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | land adres buitenland (13.10)   | 6014                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000152                            |
    | fields              | verblijfplaats.datumIngangGeldigheid |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                   |
    | type | VerblijfplaatsBuitenland |

    Voorbeelden:
    | aanduiding in onderzoek | type |
    | 081000                  |      |
    | 081030                  |      |
    | 081300                  |      |
    | 081320                  |      |

  Abstract Scenario: '<type>' is in onderzoek, maar 'datumIngangGeldigheid' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | land adres buitenland (13.10)   | 6014                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.datumVan         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                   |
    | type | VerblijfplaatsBuitenland |

    Voorbeelden:
    | aanduiding in onderzoek | type |
    | 088500                  |      |
    | 088510                  |      |
