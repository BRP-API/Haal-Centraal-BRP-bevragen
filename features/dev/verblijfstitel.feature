#language: nl

@post-assert
Functionaliteit: Verblijfstitel

  Abstract Scenario: persoon heeft 'verblijfstitel' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfstitel' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | verblijfstitel                  |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                          | naam                    | waarde                         |
    | aanduiding verblijfstitel (39.10) | aanduiding.code         | 09                             |
    | aanduiding.omschrijving           | aanduiding.omschrijving | Art. 9 van de Vreemdelingenwet |

  Abstract Scenario: persoon heeft 'verblijfstitel' datum veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde       |
    | burgerservicenummer | 555550001    |
    | <gba naam>          | <gba waarde> |
    En de persoon heeft de volgende 'verblijfstitel' gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | verblijfstitel                  |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam               | waarde         |
    | <naam>.type        | Datum          |
    | <naam>.datum       | <waarde>       |
    | <naam>.langFormaat | <lang formaat> |

    Voorbeelden:
    | gba naam                            | gba waarde | naam        | waarde     | lang formaat    |
    | datum einde verblijfstitel (39.20)  | 20020701   | datumEinde  | 2002-07-01 | 1 juli 2002     |
    | datum ingang verblijfstitel (39.30) | 19980201   | datumIngang | 1998-02-01 | 1 februari 1998 |

  Abstract Scenario: persoon's verblijfstitel velden is in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfstitel' gegevens
    | naam                                     | waarde                    |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | verblijfstitel                  |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam                                         | waarde                      |
    | inOnderzoek.aanduiding                       | <aanduiding in onderzoek>   |
    | inOnderzoek.datumEinde                       | <datum einde in onderzoek>  |
    | inOnderzoek.datumIngang                      | <datum ingang in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                 |

    Voorbeelden:
    | gba in onderzoek waarde | aanduiding in onderzoek | datum ingang in onderzoek | datum einde in onderzoek |
    | 100000                  | true                    | true                      | true                     |
    | 103900                  | true                    | true                      | true                     |
    | 103910                  | true                    |                           |                          |
    | 103920                  |                         |                           | true                     |
    | 103930                  |                         | true                      |                          |
