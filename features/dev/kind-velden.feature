#language: nl

@post-assert
Functionaliteit: kind

  Abstract Scenario: kind. Overnemen veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'kind' met alleen de volgende gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 555550001                           |
    | fields              | burgerservicenummer,kinderen.<naam> |
    Dan heeft de persoon met burgerservicenummer '555550001' een 'kind' met de volgende gegevens
    | naam   | waarde   |
    | type   | Kind     |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam            | naam                | waarde    |
    | burgerservicenummer | burgerservicenummer | 123456789 |

  Abstract Scenario: naam kind. Overnemen veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'kind' met alleen de volgende gegevens
    | naam | waarde |
    En het 'kind' heeft alleen de volgende 'naam' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 555550001                            |
    | fields              | burgerservicenummer,kinderen.<field> |
    Dan heeft de persoon met burgerservicenummer '555550001' een 'kind' met alleen de volgende gegevens
    | naam | waarde |
    | type | Kind   |
    En heeft het 'kind' alleen de volgende 'naam' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                             | field                                     | naam                                 | waarde   |
    | geslachtsnaam                        | naam.geslachtsnaam                        | geslachtsnaam                        | Jansen   |
    | voornamen                            | naam.voornamen                            | voornamen                            | Piet     |
    | voorvoegsel                          | naam.voorvoegsel                          | voorvoegsel                          | in den   |
    | adellijkeTitelPredicaat.code         | naam.adellijkeTitelPredicaat.code         | adellijkeTitelPredicaat.code         | JH       |
    | adellijkeTitelPredicaat.omschrijving | naam.adellijkeTitelPredicaat.omschrijving | adellijkeTitelPredicaat.omschrijving | jonkheer |

  Abstract Scenario: geboorte kind. Omzetten datum veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'kind' met alleen de volgende gegevens
    | naam | waarde |
    En het 'kind' heeft alleen de volgende 'geboorte' gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 555550001                           |
    | fields              | burgerservicenummer,kinderen.geboorte.<naam> |
    Dan heeft de persoon met burgerservicenummer '555550001' een 'kind' met alleen de volgende gegevens
    | naam | waarde |
    | type | Kind   |
    En heeft het 'kind' alleen de volgende 'geboorte' gegevens
    | naam         | waarde   |
    | <naam>.type  | Datum    |
    | <naam>.datum | <waarde> |

    Voorbeelden:
    | gba naam      | gba waarde | naam  | waarde     |
    | datum (03.10) | 20020701   | datum | 2002-07-01 |

  Abstract Scenario: geboorte kind. Overnemen waardetabel veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'kind' met alleen de volgende gegevens
    | naam | waarde |
    En het 'kind' heeft alleen de volgende 'geboorte' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | burgerservicenummer,kinderen.<field>     |
    Dan heeft de persoon met burgerservicenummer '555550001' een 'kind' met alleen de volgende gegevens
    | naam | waarde |
    | type | Kind   |
    En heeft het 'kind' alleen de volgende 'geboorte' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam               | field                        | naam                | waarde                       |
    | geboorteplaats (03.20) | geboorte.plaats.code         | plaats.code         | 0518                         |
    | plaats.omschrijving    | geboorte.plaats.omschrijving | plaats.omschrijving | 's-Gravenhage                |
    | geboorteland (03.30)   | geboorte.land.code           | land.code           | 6014                         |
    | land.omschrijving      | geboorte.land.omschrijving   | land.omschrijving   | Verenigde Staten van Amerika |
