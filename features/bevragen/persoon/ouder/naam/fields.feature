#language: nl

Functionaliteit: Persoon: ouder naam velden vragen met fields

  Abstract Scenario: '<gba naam>' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'naam' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | ouder aanduiding | gba naam              | fields                    | naam          | waarde |
    | 1                | voornamen (02.10)     | ouders.naam.voornamen     | voornamen     | Jan    |
    | 2                | voorvoegsel (02.30)   | ouders.naam.voorvoegsel   | voorvoegsel   | de     |
    | 1                | geslachtsnaam (02.40) | ouders.naam.geslachtsnaam | geslachtsnaam | Groen  |

  Abstract Scenario: 'geslachtsnaam (02.40)' met standaardwaarde wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | .      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'ouder' zonder 'naam' gegevens

    Voorbeelden:
    | fields                    |
    | ouders.naam.geslachtsnaam |

  Abstract Scenario: 'adellijke titel of predicaat (02.20)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                                 | waarde |
    | adellijke titel of predicaat (02.20) | <code> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'naam' gegevens
    | naam                                 | waarde         |
    | adellijkeTitelPredicaat.code         | <code>         |
    | adellijkeTitelPredicaat.omschrijving | <omschrijving> |
    | adellijkeTitelPredicaat.soort        | <soort>        |

    Voorbeelden:
    | ouder aanduiding | fields                                           | code | omschrijving | soort     |
    | 1                | ouders.naam.adellijkeTitelPredicaat              | P    | prins        | titel     |
    | 2                | ouders.naam.adellijkeTitelPredicaat.code         | JV   | jonkvrouw    | predicaat |
    | 1                | ouders.naam.adellijkeTitelPredicaat.soort        | BS   | barones      | titel     |
    | 2                | ouders.naam.adellijkeTitelPredicaat.omschrijving | R    | ridder       | titel     |

  Scenario: 'voorletters' wordt gevraagd met field pad 'ouders.naam.voorletters'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
    | naam              | waarde         |
    | voornamen (02.10) | Angelina Jolie |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.naam.voorletters         |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'naam' gegevens
    | naam        | waarde |
    | voorletters | A.J.   |
