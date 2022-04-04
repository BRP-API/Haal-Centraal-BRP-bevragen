#language: nl

@post-assert
Functionaliteit: Overlijden

  Abstract Scenario: overlijden. Omzetten datum veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'overlijden' gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                |
    | type                | RaadpleegMetBurgerservicenummer       |
    | burgerservicenummer | 555550001                             |
    | fields              | burgerservicenummer,overlijden.<naam> |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En heeft de persoon de volgende 'overlijden' gegevens
    | naam         | waarde   |
    | <naam>.type  | Datum    |
    | <naam>.datum | <waarde> |

    Voorbeelden:
    | gba naam                 | gba waarde | naam  | waarde     |
    | datum overlijden (08.10) | 20020701   | datum | 2002-07-01 |

  Abstract Scenario: overlijden: overnemen waardetabel veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'overlijden' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | burgerservicenummer,<field>     |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En heeft de persoon de volgende 'overlijden' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                  | field                          | naam                | waarde                       |
    | plaats overlijden (08.20) | overlijden.plaats.code         | plaats.code         | 0518                         |
    | plaats.omschrijving       | overlijden.plaats.omschrijving | plaats.omschrijving | 's-Gravenhage                |
    | land overlijden (08.30)   | overlijden.land.code           | land.code           | 6014                         |
    | land.omschrijving         | overlijden.land.omschrijving   | land.omschrijving   | Verenigde Staten van Amerika |
