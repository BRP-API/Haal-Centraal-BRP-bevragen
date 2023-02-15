#language: nl

Functionaliteit: naam velden vragen met fields

  Abstract Scenario: 'voornamen (02.10)' wordt gevraagd met field pad 'naam.voornamen'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam              | waarde |
    | voornamen (02.10) | Peter  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.voornamen                  |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam      | waarde |
    | voornamen | Peter  |

  Abstract Scenario: 'voorvoegsel (02.30)' wordt gevraagd met field pad 'naam.voorvoegsel'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                | waarde |
    | voorvoegsel (02.30) | van    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.voorvoegsel                |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam        | waarde |
    | voorvoegsel | van    |

  Abstract Scenario: 'geslachtsnaam (02.40)' wordt gevraagd met field pad 'naam.geslachtsnaam'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Naersen |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.geslachtsnaam              |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam          | waarde  |
    | geslachtsnaam | Naersen |

  Scenario: 'geslachtsnaam (02.40)' met standaardwaarde wordt gevraagd met field pad 'naam.geslachtsnaam'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | .      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.geslachtsnaam              |
    Dan heeft de response een persoon zonder 'naam' gegevens

  Abstract Scenario: 'adellijke titel of predicaat (02.20)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                                 | waarde |
    | adellijke titel of predicaat (02.20) | JH     |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                 | waarde    |
    | adellijkeTitelPredicaat.code         | JH        |
    | adellijkeTitelPredicaat.omschrijving | jonkheer  |
    | adellijkeTitelPredicaat.soort        | predicaat |

    Voorbeelden:
    | fields                                    |
    | naam.adellijkeTitelPredicaat              |
    | naam.adellijkeTitelPredicaat.code         |
    | naam.adellijkeTitelPredicaat.omschrijving |
    | naam.adellijkeTitelPredicaat.soort        |

  Abstract Scenario: 'aanduiding naamgebruik (61.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                           | waarde |
    | aanduiding naamgebruik (61.10) | E      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                               | waarde              |
    | aanduidingNaamgebruik.code         | E                   |
    | aanduidingNaamgebruik.omschrijving | eigen geslachtsnaam |

    Voorbeelden:
    | fields                                  |
    | naam.aanduidingNaamgebruik              |
    | naam.aanduidingNaamgebruik.code         |
    | naam.aanduidingNaamgebruik.omschrijving |
