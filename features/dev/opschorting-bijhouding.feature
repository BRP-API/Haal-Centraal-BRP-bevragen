#language: nl

@post-assert
Functionaliteit: Opschorting bijhouding

  Abstract Scenario: opschorting bijhouding. Omzetten datum veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'opschortingBijhouding' gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
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
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'opschortingBijhouding' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | opschortingBijhouding.<naam>    |
    Dan heeft de response een persoon met de volgende 'opschortingBijhouding' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam           | field              | naam               | waarde     |
    | reden.code         | plaats.code        | reden.code         | O          |
    | reden.omschrijving | reden.omschrijving | reden.omschrijving | overlijden |
