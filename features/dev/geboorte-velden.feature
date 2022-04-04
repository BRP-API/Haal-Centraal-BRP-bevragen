#language: nl

@post-assert
Functionaliteit: Geboorte

  Abstract Scenario: geboorte. Omzetten datum veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 555550001                           |
    | fields              | burgerservicenummer,geboorte.<naam> |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En heeft de persoon de volgende 'geboorte' gegevens
    | naam         | waarde   |
    | <naam>.type  | Datum    |
    | <naam>.datum | <waarde> |

    Voorbeelden:
    | gba naam      | gba waarde | naam  | waarde     |
    | datum (03.10) | 20020701   | datum | 2002-07-01 |

  Abstract Scenario: geboorte. Overnemen waardetabel veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'geboorte' gegevens
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
    En heeft de persoon de volgende 'geboorte' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam               | field                        | naam                | waarde                       |
    | geboorteplaats (03.20) | geboorte.plaats.code         | plaats.code         | 0518                         |
    | plaats.omschrijving    | geboorte.plaats.omschrijving | plaats.omschrijving | 's-Gravenhage                |
    | geboorteland (03.30)   | geboorte.land.code           | land.code           | 6014                         |
    | land.omschrijving      | geboorte.land.omschrijving   | land.omschrijving   | Verenigde Staten van Amerika |
