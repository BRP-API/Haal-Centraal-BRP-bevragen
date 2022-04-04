#language: nl

@post-assert
Functionaliteit: Naam velden van persoon

  Abstract Scenario: naam. Overnemen veld: <gba naam>
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
    | fields              | burgerservicenummer,<field>     |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En heeft de persoon de volgende 'naam' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam              | field              | naam          | waarde        |
    | voornamen (02.10)     | naam.voornamen     | voornamen     | voornamen     |
    | voorvoegsel (02.30)   | naam.voorvoegsel   | voorvoegsel   | voorvoegsel   |
    | geslachtsnaam (02.40) | naam.geslachtsnaam | geslachtsnaam | geslachtsnaam |

  Abstract Scenario: naam. Overnemen waardetabel veld: <gba naam>
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
    | fields              | burgerservicenummer,<field>     |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En heeft de persoon de volgende 'naam' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                             | field                                     | naam                                 | waarde     |
    | adellijke titel of predicaat (02.20) | naam.adellijkeTitelPredicaat.code         | adellijkeTitelPredicaat.code         | JH         |
    | adellijkeTitelPredicaat.omschrijving | naam.adellijkeTitelPredicaat.omschrijving | adellijkeTitelPredicaat.omschrijving | jonkheer   |
    | aanduiding naamgebruik (61.10)       | naam.aanduidingNaamgebruik.code           | aanduidingNaamgebruik.code           | E          |
    | aanduidingNaamgebruik.omschrijving   | naam.aanduidingNaamgebruik.omschrijving   | aanduidingNaamgebruik.omschrijving   | Eigen naam |

