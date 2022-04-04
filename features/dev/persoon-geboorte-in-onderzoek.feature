#language: nl

@post-assert
Functionaliteit: persoon geboorte velden in onderzoek

  Abstract Scenario: persoon geboorte datum in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                                      | waarde         |
    | burgerservicenummer                       | 555550001      |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <in onderzoek> |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam  | waarde   |
    | datum | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 555550001                          |
    | fields              | burgerservicenummer,geboorte.datum |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En heeft de persoon de volgende 'geboorte' gegevens
    | naam              | waarde     |
    | datum.type        | Datum      |
    | datum.datum       | 2002-07-01 |
    | inOnderzoek.datum | true       |

    Voorbeelden:
    | in onderzoek |
    | 010310       |
    | 010300       |

  Abstract Scenario: persoon geboorte plaats in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                                      | waarde         |
    | burgerservicenummer                       | 555550001      |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <in onderzoek> |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam        | waarde |
    | plaats.code | 0518   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 555550001                           |
    | fields              | burgerservicenummer,geboorte.plaats |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En heeft de persoon de volgende 'geboorte' gegevens
    | naam               | waarde |
    | plaats.code        | 0518   |
    | inOnderzoek.plaats | true   |

    Voorbeelden:
    | in onderzoek |
    | 010320       |
    | 010300       |

  Abstract Scenario: persoon geboorte land in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                                      | waarde         |
    | burgerservicenummer                       | 555550001      |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <in onderzoek> |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam      | waarde |
    | land.code | 6030   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                            |
    | type                | RaadpleegMetBurgerservicenummer   |
    | burgerservicenummer | 555550001                         |
    | fields              | burgerservicenummer,geboorte.land |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En heeft de persoon de volgende 'geboorte' gegevens
    | naam             | waarde |
    | land.code        | 6030   |
    | inOnderzoek.land | true   |

    Voorbeelden:
    | in onderzoek |
    | 010330       |
    | 010300       |

  Scenario: persoon geboorte groep in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                                      | waarde    |
    | burgerservicenummer                       | 555550001 |
    | inOnderzoek.aanduidingGegevensInOnderzoek | 010300    |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam        | waarde   |
    | datum       | 20020701 |
    | plaats.code | 0518     |
    | land.code   | 6030     |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | burgerservicenummer,geboorte    |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En heeft de persoon de volgende 'geboorte' gegevens
    | naam               | waarde     |
    | datum.type         | Datum      |
    | datum.datum        | 2002-07-01 |
    | inOnderzoek.datum  | true       |
    | plaats.code        | 0518       |
    | inOnderzoek.plaats | true       |
    | land.code          | 6030       |
    | inOnderzoek.land   | true       |
