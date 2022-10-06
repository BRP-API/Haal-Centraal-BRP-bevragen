#language: nl

@post-assert
Functionaliteit: Naam velden van persoon

  Abstract Scenario: persoon heeft 'naam' veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.<naam>                     |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam              | naam          | waarde        |
    | voornamen (02.10)     | voornamen     | voornamen     |
    | voorvoegsel (02.30)   | voorvoegsel   | van de        |
    | geslachtsnaam (02.40) | geslachtsnaam | geslachtsnaam |

  Abstract Scenario: persoon heeft 'naam' veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.<naam>                     |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                             | naam                                 | gba waarde | waarde                        |
    | adellijke titel of predicaat (02.20) | adellijkeTitelPredicaat.code         | JH         | JH                            |
    | adellijke titel of predicaat (02.20) | adellijkeTitelPredicaat.omschrijving | JH         | Jonkheer                      |
    | aanduiding naamgebruik (61.10)       | aanduidingNaamgebruik.code           | E          | E                             |
    | aanduiding naamgebruik (61.10)       | aanduidingNaamgebruik.omschrijving   | E          | gebruik alleen de eigen naam. |
