# language: nl

Functionaliteit: Persoon: uitsluiting kiesrecht velden vragen met fields

  Scenario: 'aanduiding uitgesloten kiesrecht (38.10)' wordt gevraagd met field pad 'uitsluitingKiesrecht.uitgeslotenVanKiesrecht'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'kiesrecht' gegevens
    | naam                                     | waarde |
    | aanduiding uitgesloten kiesrecht (38.10) | A      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                       |
    | type                | RaadpleegMetBurgerservicenummer              |
    | burgerservicenummer | 000000152                                    |
    | fields              | uitsluitingKiesrecht.uitgeslotenVanKiesrecht |
    Dan heeft de response een persoon met alleen de volgende 'uitsluitingKiesrecht' gegevens
    | naam                    | waarde |
    | uitgeslotenVanKiesrecht | true   |

  Abstract Scenario: 'einddatum uitsluiting kiesrecht (38.20)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'kiesrecht' gegevens
    | naam                                     | waarde   |
    | aanduiding uitgesloten kiesrecht (38.10) | A        |
    | einddatum uitsluiting kiesrecht (38.20)  | 20270101 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met alleen de volgende 'uitsluitingKiesrecht' gegevens
    | naam                  | waarde         |
    | einddatum.type        | Datum          |
    | einddatum.datum       | 2027-01-01     |
    | einddatum.langFormaat | 1 januari 2027 |

    Voorbeelden:
    | fields                                     |
    | uitsluitingKiesrecht.einddatum             |
    | uitsluitingKiesrecht.einddatum.type        |
    | uitsluitingKiesrecht.einddatum.datum       |
    | uitsluitingKiesrecht.einddatum.langFormaat |
    | uitsluitingKiesrecht.einddatum.jaar        |
    | uitsluitingKiesrecht.einddatum.maand       |
    | uitsluitingKiesrecht.einddatum.onbekend    |

  Abstract Scenario: 'einddatum uitsluiting kiesrecht (38.20)' van het type '<type>' wordt gevraagd met field pad 'uitsluitingKiesrecht.einddatum'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam                                     | waarde     |
    | aanduiding uitgesloten kiesrecht (38.10) | A          |
    | einddatum uitsluiting kiesrecht (38.20)  | <GbaDatum> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | uitsluitingKiesrecht.einddatum  |
    Dan heeft de response een persoon met de volgende 'uitsluitingKiesrecht' gegevens
    | naam                  | waarde        |
    | einddatum.type        | <type>        |
    | einddatum.datum       | <datum>       |
    | einddatum.jaar        | <jaar>        |
    | einddatum.maand       | <maand>       |
    | einddatum.onbekend    | <onbekend>    |
    | einddatum.langFormaat | <langFormaat> |

    Voorbeelden:
    | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat |
    | Datum          | 20300701 | 2030-07-01 |      |       |          | 1 juli 2030 |
    | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend    |
    | JaarDatum      | 20300000 |            | 2030 |       |          | 2030        |
    | JaarMaandDatum | 20300700 |            | 2030 | 7     |          | juli 2030   |
