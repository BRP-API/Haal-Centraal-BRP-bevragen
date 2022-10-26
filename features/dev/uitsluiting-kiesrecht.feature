# language: nl

Functionaliteit: Persoon: uitsluiting kiesrecht

    Abstract Scenario: persoon heeft 'uitsluiting kiesrecht' veld: <gba naam>
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
      | naam       | waarde       |
      | <gba naam> | <gba waarde> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | uitsluitingKiesrecht            |
      Dan heeft de response een persoon met alleen de volgende 'uitsluitingKiesrecht' gegevens
      | naam   | waarde   |
      | <naam> | <waarde> |

      Voorbeelden:
      | gba naam                                 | naam                    | gba waarde | waarde |
      | aanduiding uitgesloten kiesrecht (38.10) | uitgeslotenVanKiesrecht | A          | true   |

    Abstract Scenario: persoon heeft 'kiesrecht' datum veld: <gba naam>
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
      | naam                                     | waarde       |
      | aanduiding uitgesloten kiesrecht (38.10) | A            |
      | <gba naam>                               | <gba waarde> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | uitsluitingKiesrecht.<naam>     |
      Dan heeft de response een persoon met alleen de volgende 'uitsluitingKiesrecht' gegevens
      | naam               | waarde         |
      | <naam>.type        | <type>         |
      | <naam>.datum       | <waarde>       |
      | <naam>.langFormaat | <lang formaat> |

      Voorbeelden:
      | gba naam                                | gba waarde | naam      | type  | waarde     | lang formaat   |
      | einddatum uitsluiting kiesrecht (38.20) | 20230101   | einddatum | Datum | 2023-01-01 | 1 januari 2023 |
