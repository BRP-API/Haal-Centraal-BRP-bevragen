# language: nl

@post-assert
Functionaliteit: Uitsluiting kiesrecht

    Abstract Scenario: persoon heeft 'uitsluiting kiesrecht' veld: <gba naam>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999990001 |
      En de persoon heeft de volgende 'uitsluitingKiesrecht' gegevens
      | naam       | waarde   |
      | <gba naam> | <waarde> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999990001                       |
      | fields              | uitsluitingKiesrecht            |
      Dan heeft de response een persoon met alleen de volgende 'uitsluitingKiesrecht' gegevens
      | naam   | waarde   |
      | <naam> | <waarde> |

      Voorbeelden:
      | gba naam                          | naam                    | waarde |
      | uitgesloten van kiesrecht (38.10) | uitgeslotenVanKiesrecht | true   |

    Abstract Scenario: persoon heeft 'kiesrecht' datum veld: <gba naam>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999990001 |
      En de persoon heeft de volgende 'uitsluitingKiesrecht' gegevens
      | naam       | waarde       |
      | <gba naam> | <gba waarde> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999990001                       |
      | fields              | uitsluitingKiesrecht            |
      Dan heeft de response een persoon met alleen de volgende 'uitsluitingKiesrecht' gegevens
      | naam               | waarde         |
      | <naam>.type        | <type>         |
      | <naam>.datum       | <waarde>       |
      | <naam>.langFormaat | <lang formaat> |

      Voorbeelden:
      | gba naam                                | gba waarde | naam      | type  | waarde     | lang formaat   |
      | einddatum uitsluiting kiesrecht (38.20) | 20230101   | einddatum | Datum | 2023-01-01 | 1 januari 2023 |
