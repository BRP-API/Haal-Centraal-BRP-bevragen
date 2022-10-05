# language: nl

@post-assert
Functionaliteit: Europees kiesrecht

  Abstract Scenario: persoon heeft 'Europees kiesrecht' veld: <gba naam>
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | europeesKiesrecht.<naam>        |
    Dan heeft de response een persoon met alleen de volgende 'europeesKiesrecht' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                   | naam                    | gba waarde | waarde                 |
    | Europees kiesrecht (31.10) | aanduiding.code         | 1          | 1                      |
    | Europees kiesrecht (31.10) | aanduiding.omschrijving | 1          | persoon is uitgesloten |

  Abstract Scenario: persoon heeft 'Europees kiesrecht' datum veld: <gba naam>
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam                       | waarde       |
    | Europees kiesrecht (31.10) | 1            |
    | <gba naam>                 | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | europeesKiesrecht.<naam>        |
    Dan heeft de response een persoon met alleen de volgende 'europeesKiesrecht' gegevens
    | naam               | waarde         |
    | <naam>.type        | <type>         |
    | <naam>.datum       | <waarde>       |
    | <naam>.langFormaat | <lang formaat> |

    Voorbeelden:
    | gba naam                                         | gba waarde | naam                 | type  | waarde     | lang formaat   |
    | einddatum uitsluiting Europees kiesrecht (31.30) | 20230101   | einddatumUitsluiting | Datum | 2023-01-01 | 1 januari 2023 |
