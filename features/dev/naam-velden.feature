#language: nl

@post-assert
Functionaliteit: Naam velden van persoon

  Abstract Scenario: persoon heeft 'naam' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'naam' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | naam.<naam>                     |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam              | naam          | waarde        |
    | voornamen (02.10)     | voornamen     | voornamen     |
    | voorvoegsel (02.30)   | voorvoegsel   | voorvoegsel   |
    | geslachtsnaam (02.40) | geslachtsnaam | geslachtsnaam |

  Abstract Scenario: persoon heeft 'naam' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'naam' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | naam.<naam>                     |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                             | naam                                 | waarde     |
    | adellijke titel of predicaat (02.20) | adellijkeTitelPredicaat.code         | JH         |
    | adellijkeTitelPredicaat.omschrijving | adellijkeTitelPredicaat.omschrijving | jonkheer   |
    | aanduiding naamgebruik (61.10)       | aanduidingNaamgebruik.code           | E          |
    | aanduidingNaamgebruik.omschrijving   | aanduidingNaamgebruik.omschrijving   | Eigen naam |
