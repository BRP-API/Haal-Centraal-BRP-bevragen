#language: nl

Functionaliteit: Opschorting bijhouding

  Abstract Scenario: opschorting bijhouding. Omzetten datum veld: <gba naam>
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

  Abstract Scenario: opschorting bijhouding: overnemen waardetabel veld: <gba naam>
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | opschortingBijhouding.<naam>    |
    Dan heeft de response een persoon met de volgende 'opschortingBijhouding' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                             | naam               | gba waarde | waarde     |
    | reden opschorting bijhouding (67.20) | reden.code         | O          | O          |
    | reden opschorting bijhouding (67.20) | reden.omschrijving | O          | overlijden |
