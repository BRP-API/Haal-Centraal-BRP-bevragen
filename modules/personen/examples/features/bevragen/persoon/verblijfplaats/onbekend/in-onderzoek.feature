# language: nl

Functionaliteit: Persoon: verblijfplaats onbekend velden zijn in onderzoek

Regel: Het in onderzoek zijn van een veld en bijbehorende datumIngangOnderzoek worden geleverd als het betreffende veld wordt gevraagd

  Abstract Scenario: '<type>' is in onderzoek en alle verblijfplaats onbekend velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | land adres buitenland (13.10)   | 0000                      |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                       |
    | type                | RaadpleegMetBurgerservicenummer                              |
    | burgerservicenummer | 000000152                                                    |
    | fields              | verblijfplaats.datumVan,verblijfplaats.datumIngangGeldigheid |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde                     |
    | type                                         | VerblijfplaatsOnbekend     |
    | inOnderzoek.type                             | <type io>                  |
    | inOnderzoek.datumVan                         | <datumVan io>              |
    | inOnderzoek.datumIngangGeldigheid            | <datumIngangGeldigheid io> |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                      |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                 |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                |

    Voorbeelden:
    | aanduiding in onderzoek | type io | datumVan io | datumIngangGeldigheid io | type                           |
    | 080000                  | true    | true        | true                     | hele categorie verblijfplaats  |
    | 081300                  | true    | true        |                          | hele groep adres buitenland    |
    | 081310                  | true    |             |                          | land adres buitenland          |
    | 081320                  |         | true        |                          | datum aanvang adres buitenland |
    | 088500                  |         |             | true                     | hele groep geldigheid          |
    | 088510                  |         |             | true                     | datum ingang geldigheid        |

  Scenario: 'datum aanvang adres buitenland' is in onderzoek, maar 'datumVan' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde   |
    | land adres buitenland (13.10)   | 0000     |
    | aanduiding in onderzoek (83.10) | 081320   |
    | datum ingang onderzoek (83.20)  | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000152                            |
    | fields              | verblijfplaats.datumIngangGeldigheid |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                 |
    | type | VerblijfplaatsOnbekend |

  Abstract Scenario: '<type>' is in onderzoek, maar 'datumIngangGeldigheid' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | land adres buitenland (13.10)   | 0000                      |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.datumVan         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                 |
    | type | VerblijfplaatsOnbekend |

    Voorbeelden:
    | aanduiding in onderzoek | type                    |
    | 088500                  | hele groep geldigheid   |
    | 088510                  | datum ingang geldigheid |

Regel: 'type' veld van 'verblijfplaats onbekend' is in onderzoek als het identificerende gegeven van verblijfplaats onbekend ('land adres buitenland (13.10) met waarde 0000') in onderzoek is

  Abstract Scenario: '<type>' veld is in onderzoek en datumVan wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | land adres buitenland (13.10)   | 0000                      |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.datumVan         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                 |
    | type | VerblijfplaatsOnbekend |
    En heeft de 'verblijfplaats' de volgende 'inOnderzoek' gegevens
    | naam                             | waarde        |
    | type                             | true          |
    | datumVan                         | <datumVan io> |
    | datumIngangOnderzoek.type        | Datum         |
    | datumIngangOnderzoek.datum       | 2002-07-01    |
    | datumIngangOnderzoek.langFormaat | 1 juli 2002   |

    Voorbeelden:
    | aanduiding in onderzoek | datumVan io | type                          |
    | 080000                  | true        | hele categorie verblijfplaats |
    | 081300                  | true        | hele groep adres buitenland   |
    | 081310                  |             | land adres buitenland         |
