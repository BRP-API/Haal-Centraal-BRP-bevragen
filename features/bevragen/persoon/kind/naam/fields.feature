#language: nl

Functionaliteit: Persoon: kind naam velden vragen met fields

  Abstract Scenario: '<gba naam>' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'naam' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam              | fields                      | naam          | waarde |
    | voornamen (02.10)     | kinderen.naam.voornamen     | voornamen     | Piet   |
    | voorvoegsel (02.30)   | kinderen.naam.voorvoegsel   | voorvoegsel   | in den |
    | geslachtsnaam (02.40) | kinderen.naam.geslachtsnaam | geslachtsnaam | Jansen |

  Abstract Scenario: 'geslachtsnaam (02.40)' met standaardwaarde wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | .      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'kind' zonder 'naam' gegevens

    Voorbeelden:
    | fields                      |
    | kinderen.naam.geslachtsnaam |

  Abstract Scenario: 'adellijke titel of predicaat (02.20)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                                 | waarde |
    | adellijke titel of predicaat (02.20) | JH     |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'naam' gegevens
    | naam                                 | waarde    |
    | adellijkeTitelPredicaat.code         | JH        |
    | adellijkeTitelPredicaat.omschrijving | jonkheer  |
    | adellijkeTitelPredicaat.soort        | predicaat |

    Voorbeelden:
    | fields                                             |
    | kinderen.naam.adellijkeTitelPredicaat              |
    | kinderen.naam.adellijkeTitelPredicaat.code         |
    | kinderen.naam.adellijkeTitelPredicaat.soort        |
    | kinderen.naam.adellijkeTitelPredicaat.omschrijving |

  Scenario: 'voorletters' wordt gevraagd met field pad 'kinderen.naam.voorletters'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam              | waarde    |
    | voornamen (02.10) | Peter Jan |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.naam.voorletters       |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'naam' gegevens
    | naam        | waarde |
    | voorletters | P.J.   |
