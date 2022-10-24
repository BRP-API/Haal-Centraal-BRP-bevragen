#language: nl

Functionaliteit: Persoon: opschorting bijhouding

  Abstract Scenario: Persoon heeft veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | opschortingBijhouding.<naam>    |
    Dan heeft de response een persoon met de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde         |
    | <naam>.type        | Datum          |
    | <naam>.datum       | <waarde>       |
    | <naam>.langFormaat | <lang formaat> |

    Voorbeelden:
    | gba naam                             | gba waarde | naam  | waarde     | lang formaat |
    | datum opschorting bijhouding (67.10) | 20020701   | datum | 2002-07-01 | 1 juli 2002  |

  Scenario: Persoon heeft veld: 'reden opschorting bijhouding (67.20)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam                                 | waarde |
    | reden opschorting bijhouding (67.20) | O      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | opschortingBijhouding.<naam>    |
    Dan heeft de response een persoon met de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde     |
    | reden.code         | O          |
    | reden.omschrijving | overlijden |

    Voorbeelden:
    | naam               |
    | reden              |
    | reden.code         |
    | reden.omschrijving |
