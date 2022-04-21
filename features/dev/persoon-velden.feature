#language: nl

@post-assert
Functionaliteit: Persoon

  Abstract Scenario: overnemen veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    | <gba naam>          | <waarde>  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | burgerservicenummer,<naam>      |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    | <naam>              | <waarde>  |

    Voorbeelden:
    | gba naam        | naam    | waarde     |
    | anummer (01.10) | aNummer | 1234567890 |

  Abstract Scenario: omzetten veld : indicatie geheim
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                     | waarde       |
    | burgerservicenummer      | 555550001    |
    | indicatie geheim (70.10) | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                            |
    | type                | RaadpleegMetBurgerservicenummer                   |
    | burgerservicenummer | 555550001                                         |
    | fields              | burgerservicenummer,geheimhoudingPersoonsgegevens |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                          | waarde    |
    | burgerservicenummer           | 555550001 |
    | geheimhoudingPersoonsgegevens | <waarde>  |

    Voorbeelden:
    | gba waarde | waarde |
    | 0          |        |
    | 1          | true   |
    | 2          | true   |
    | 3          | true   |
    | 4          | true   |
    | 5          | true   |
    | 6          | true   |
    | 7          | true   |

  Abstract Scenario: omzetten datum veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde       |
    | burgerservicenummer | 555550001    |
    | <gba naam>          | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | burgerservicenummer,<naam>      |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    | <naam>.type         | Datum     |
    | <naam>.datum        | <waarde>  |

    Voorbeelden:
    | gba naam                              | gba waarde | naam                       | waarde     |
    | datum eerste inschrijving GBA (68.10) | 20020701   | datumEersteInschrijvingGBA | 2002-07-01 |

  Abstract Scenario: persoon. Overnemen waardetabel veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    | <gba naam>          | <waarde>  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | burgerservicenummer,<field>     |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    | <naam>              | <waarde>  |

    Voorbeelden:
    | gba naam                         | field                            | naam                             | waarde |
    | geslachtsaanduiding (04.10)      | geslachtsaanduiding.code         | geslachtsaanduiding.code         | M      |
    | geslachtsaanduiding.omschrijving | geslachtsaanduiding.omschrijving | geslachtsaanduiding.omschrijving | man    |

