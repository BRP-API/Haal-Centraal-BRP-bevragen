#language: nl

@post-assert
Functionaliteit: persoon velden in onderzoek

  Abstract Scenario: burgerservicenummer in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                                      | waarde         |
    | burgerservicenummer                       | 555550001      |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <in onderzoek> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | burgerservicenummer             |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                            | waarde    |
    | burgerservicenummer             | 555550001 |
    | inOnderzoek.burgerservicenummer | true      |

    Voorbeelden:
    | in onderzoek |
    | 010120       |
    | 010100       |

  Abstract Scenario: geslachtsaanduiding in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                                      | waarde         |
    | burgerservicenummer                       | 555550001      |
    | geslachtsaanduiding (04.10)               | M              |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <in onderzoek> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 555550001                               |
    | fields              | burgerservicenummer,geslachtsaanduiding |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                            | waarde    |
    | burgerservicenummer             | 555550001 |
    | geslachtsaanduiding.code        | M         |
    | inOnderzoek.geslachtsaanduiding | true      |

    Voorbeelden:
    | in onderzoek |
    | 010410       |
    | 010400       |

  Scenario: persoon categorie in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                                      | waarde    |
    | burgerservicenummer                       | 555550001 |
    | geslachtsaanduiding (04.10)               | M         |
    | inOnderzoek.aanduidingGegevensInOnderzoek | 010000    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 555550001                               |
    | fields              | burgerservicenummer,geslachtsaanduiding |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                            | waarde    |
    | burgerservicenummer             | 555550001 |
    | geslachtsaanduiding.code        | M         |
    | inOnderzoek.burgerservicenummer | true      |
    | inOnderzoek.geslachtsaanduiding | true      |

  Abstract Scenario: persoon in onderzoek. Omzetten datum veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                                      | waarde       |
    | burgerservicenummer                       | 555550001    |
    | inOnderzoek.aanduidingGegevensInOnderzoek | 010000       |
    | inOnderzoek.datumIngangOnderzoek          | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | burgerservicenummer             |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                            | waarde    |
    | burgerservicenummer             | 555550001 |
    | inOnderzoek.burgerservicenummer | true      |
    | inOnderzoek.<naam>.type         | Datum     |
    | inOnderzoek.<naam>.datum        | <waarde>  |

    Voorbeelden:
    | gba naam      | gba waarde | naam                 | waarde     |
    | datum (03.10) | 20020701   | datumIngangOnderzoek | 2002-07-01 |
