#language: nl

@post-assert
Functionaliteit: verblijfstitel

  Abstract Scenario: verblijfstitel. Overnemen waardetabel veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfstitel' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                    |
    | type                | RaadpleegMetBurgerservicenummer           |
    | burgerservicenummer | 555550001                                 |
    | fields              | burgerservicenummer,verblijfstitel.<naam> |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En heeft de persoon de volgende 'verblijfstitel' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                          | naam                    | waarde        |
    | aanduiding verblijfstitel (39.10) | aanduiding.code         | 01            |
    | aanduiding.omschrijving           | aanduiding.omschrijving | 's-Gravenhage |

  Abstract Scenario: verblijfstitel. Omzetten datum veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfstitel' gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                    |
    | type                | RaadpleegMetBurgerservicenummer           |
    | burgerservicenummer | 555550001                                 |
    | fields              | burgerservicenummer,verblijfstitel.<naam> |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En heeft de persoon de volgende 'verblijfstitel' gegevens
    | naam         | waarde   |
    | <naam>.type  | Datum    |
    | <naam>.datum | <waarde> |

    Voorbeelden:
    | gba naam                            | gba waarde | naam        | waarde     |
    | datum einde verblijfstitel (39.20)  | 20020701   | datumEinde  | 2002-07-01 |
    | datum ingang verblijfstitel (39.30) | 20200701   | datumIngang | 2020-07-01 |
