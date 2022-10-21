# language: nl

Functionaliteit: Persoon: Europees kiesrecht

  Abstract Scenario: persoon heeft 'Europees kiesrecht' veld: 'Europees kiesrecht (31.10)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam                       | waarde |
    | Europees kiesrecht (31.10) | 1      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | europeesKiesrecht.<naam>        |
    Dan heeft de response een persoon met alleen de volgende 'europeesKiesrecht' gegevens
    | naam                    | waarde                 |
    | aanduiding.code         | 1                      |
    | aanduiding.omschrijving | persoon is uitgesloten |

    Voorbeelden:
    | naam                    |
    | aanduiding              |
    | aanduiding.code         |
    | aanduiding.omschrijving |

  Abstract Scenario: persoon heeft 'Europees kiesrecht' datum veld: 'einddatum uitsluiting Europees kiesrecht (31.30)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam                                             | waarde   |
    | Europees kiesrecht (31.10)                       | 1        |
    | einddatum uitsluiting Europees kiesrecht (31.30) | 20230101 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | europeesKiesrecht.<naam>        |
    Dan heeft de response een persoon met alleen de volgende 'europeesKiesrecht' gegevens
    | naam                             | waarde         |
    | einddatumUitsluiting.type        | Datum          |
    | einddatumUitsluiting.datum       | 2023-01-01     |
    | einddatumUitsluiting.langFormaat | 1 januari 2023 |

    Voorbeelden:
    | naam                 |
    | einddatumUitsluiting |
