# language: nl

Functionaliteit: Persoon: Europees kiesrecht velden vragen met fields

  Abstract Scenario: 'Europees kiesrecht (31.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'kiesrecht' gegevens
    | naam                       | waarde |
    | Europees kiesrecht (31.10) | 1      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met alleen de volgende 'europeesKiesrecht' gegevens
    | naam                    | waarde                 |
    | aanduiding.code         | 1                      |
    | aanduiding.omschrijving | persoon is uitgesloten |

    Voorbeelden:
    | fields                                    |
    | europeesKiesrecht.aanduiding              |
    | europeesKiesrecht.aanduiding.code         |
    | europeesKiesrecht.aanduiding.omschrijving |

  Abstract Scenario: 'einddatum uitsluiting Europees kiesrecht (31.30)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam                                             | waarde   |
    | Europees kiesrecht (31.10)                       | 1        |
    | einddatum uitsluiting Europees kiesrecht (31.30) | 20230101 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met alleen de volgende 'europeesKiesrecht' gegevens
    | naam                             | waarde         |
    | einddatumUitsluiting.type        | Datum          |
    | einddatumUitsluiting.datum       | 2023-01-01     |
    | einddatumUitsluiting.langFormaat | 1 januari 2023 |

    Voorbeelden:
    | fields                                             |
    | europeesKiesrecht.einddatumUitsluiting             |
    | europeesKiesrecht.einddatumUitsluiting.type        |
    | europeesKiesrecht.einddatumUitsluiting.datum       |
    | europeesKiesrecht.einddatumUitsluiting.langFormaat |
    | europeesKiesrecht.einddatumUitsluiting.jaar        |
    | europeesKiesrecht.einddatumUitsluiting.maand       |
    | europeesKiesrecht.einddatumUitsluiting.onbekend    |

  Scenario: persoon heeft geen 'Europees kiesrecht' gegevens
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam                     | waarde |
    | indicatie geheim (70.10) | 0      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | europeesKiesrecht               |
    Dan heeft de response een persoon zonder gegevens
