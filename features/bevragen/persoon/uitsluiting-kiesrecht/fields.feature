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

    Scenario: 'einddatum uitsluiting kiesrecht (38.20)' wordt gevraagd met field pad '<fields>'
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
