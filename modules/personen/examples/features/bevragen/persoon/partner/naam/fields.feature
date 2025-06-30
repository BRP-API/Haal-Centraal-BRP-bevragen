#language: nl

Functionaliteit: Persoon: partner naam velden vragen met fields

  Abstract Scenario: '<gba naam>' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'naam' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam              | fields                      | naam          | waarde |
    | voornamen (02.10)     | partners.naam.voornamen     | voornamen     | Jan    |
    | voorvoegsel (02.30)   | partners.naam.voorvoegsel   | voorvoegsel   | de     |
    | geslachtsnaam (02.40) | partners.naam.geslachtsnaam | geslachtsnaam | Groen  |

  Abstract Scenario: 'geslachtsnaam (02.40)' met standaardwaarde wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | .      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'partner' zonder 'naam' gegevens

    Voorbeelden:
    | fields                      |
    | partners.naam.geslachtsnaam |

  Abstract Scenario: 'adellijke titel of predicaat (02.20)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                 | waarde |
    | adellijke titel of predicaat (02.20) | R      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'naam' gegevens
    | naam                                 | waarde |
    | adellijkeTitelPredicaat.code         | R      |
    | adellijkeTitelPredicaat.omschrijving | ridder |
    | adellijkeTitelPredicaat.soort        | titel  |

    Voorbeelden:
    | fields                                             |
    | partners.naam.adellijkeTitelPredicaat              |
    | partners.naam.adellijkeTitelPredicaat.code         |
    | partners.naam.adellijkeTitelPredicaat.soort        |
    | partners.naam.adellijkeTitelPredicaat.omschrijving |

  Scenario: 'voorletters' wordt gevraagd met field pad 'partners.naam.voorletters'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam              | waarde    |
    | voornamen (02.10) | Klaas Jan |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.naam.voorletters       |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'naam' gegevens
    | naam        | waarde |
    | voorletters | K.J.   |
