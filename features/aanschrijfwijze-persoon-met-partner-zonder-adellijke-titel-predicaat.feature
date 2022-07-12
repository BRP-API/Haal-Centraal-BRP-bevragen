#language: nl

Functionaliteit: Aanschrijfwijze voor persoon met (ex-)partner, zonder adellijke titel/predicaat

  Rule: Voor een persoon zonder adellijke titel of predicaat, met een (ex-)partner zonder adellijke titel of predicaat,
        wordt de naam in aanschrijfwijze als volgt samengesteld:
        | aanduiding naamgebruik | omschrijving                 | naam in aanschrijfwijze |
        | E                      | eigen naam                   | VL VV GN                |
        | P                      | partner naam                 | VL VP GP                |
        | V                      | partner naam voor eigen naam | VL VP GP-VV GN          |
        | N                      | partner naam na eigen naam   | VL VV GN-VP GP          |

    Abstract Scenario: persoon zonder voorvoegsel heeft (ex-)partner zonder voorvoegsel, en heeft aanduiding naamgebruik "<naamgebruik>"
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En die persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | voornamen (02.10)              | Franklin      |
      | geslachtsnaam (02.40)          | Groenen       |
      | aanduiding naamgebruik (61.10) | <naamgebruik> |
      En die persoon heeft een 'partner' met de volgende 'naam' gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Aedel  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | naamgebruik | naam in aanschrijfwijze |
      | E           | F. Groenen              |
      | P           | F. Aedel                |
      | V           | F. Aedel-Groenen        |
      | N           | F. Groenen-Aedel        |

    Abstract Scenario: persoon met voorvoegsel heeft (ex-)partner zonder voorvoegsel, en heeft aanduiding naamgebruik "<naamgebruik>"
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En die persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | voornamen (02.10)              | Franklin      |
      | voorvoegsel (02.30)            | <voorvoegsel> |
      | geslachtsnaam (02.40)          | Groenen       |
      | aanduiding naamgebruik (61.10) | <naamgebruik> |
      En die persoon heeft een 'partner' met de volgende 'naam' gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Aedel  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | naamgebruik | voorvoegsel | naam in aanschrijfwijze |
      | E           | van         | F. van Groenen          |
      | P           | Van         | F. Aedel                |
      | V           | in het      | F. Aedel-in het Groenen |
      | N           | In Den      | F. In Den Groenen-Aedel |

    Abstract Scenario: persoon zonder voorvoegsel, met (ex-)partner met voorvoegsel, heeft aanduiding naamgebruik "<naamgebruik>"
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En die persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | voornamen (02.10)              | Franklin      |
      | geslachtsnaam (02.40)          | Groenen       |
      | aanduiding naamgebruik (61.10) | <naamgebruik> |
      En die persoon heeft een 'partner' met de volgende 'naam' gegevens
      | naam                  | waarde                |
      | voorvoegsel (02.30)   | <voorvoegsel partner> |
      | geslachtsnaam (02.40) | Aedel                 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | naamgebruik | voorvoegsel partner | naam in aanschrijfwijze |
      | E           | van                 | F. Groenen              |
      | P           | Van                 | F. Van Aedel            |
      | V           | in het              | F. in het Aedel-Groenen |
      | N           | In Den              | F. Groenen-In Den Aedel |

    Abstract Scenario: persoon met voorvoegsel, met (ex-)partner met voorvoegsel, heeft aanduiding naamgebruik "<naamgebruik>"
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En die persoon heeft alleen de volgende 'naam' gegevens
      | naam                           | waarde        |
      | voornamen (02.10)              | Franklin      |
      | voorvoegsel (02.30)            | <voorvoegsel> |
      | geslachtsnaam (02.40)          | Groenen       |
      | aanduiding naamgebruik (61.10) | <naamgebruik> |
      En die persoon heeft een 'partner' met de volgende relevante 'naam' gegevens
      | naam                  | waarde                |
      | voorvoegsel (02.30)   | <voorvoegsel partner> |
      | geslachtsnaam (02.40) | Aedel                 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | naamgebruik | voorvoegsel | voorvoegsel partner | naam in aanschrijfwijze          |
      | E           | in het      | Van                 | F. in het Groenen                |
      | P           | Van         | van den             | F. van den Aedel                 |
      | V           | In Het      | van                 | F. van Aedel-In Het Groenen      |
      | N           | van den     | Van Den             | F. van den Groenen-Van Den Aedel |

    Abstract Scenario: persoon met (ex-)partner, heeft een naamketen en aanduiding naamgebruik "<naamgebruik>"
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En die persoon heeft de alleen volgende 'naam' gegevens
      | naam                           | waarde          |
      | geslachtsnaam (02.40)          | <geslachtsnaam> |
      | aanduiding naamgebruik (61.10) | <naamgebruik>   |
      En die persoon heeft een 'partner' met de volgende relevante 'naam' gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   | van    |
      | geslachtsnaam (02.40) | Velzen |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | geslachtsnaam     | naamgebruik | naam in aanschrijfwijze      |
      | Ali bin Mohammed  | E           | Ali bin Mohammed             |
      | Ali bin Mohammed  | P           | Van Velzen                   |
      | Ibin binti Yalniz | V           | Van Velzen-Ibin binti Yalniz |
      | Ibin binti Yalniz | N           | Ibin binti Yalniz-van Velzen |

  Rule: er is geen aanschrijfwijze als de geslachtsnaam van de persoon gelijk is aan de standaardwaarde en aanduiding naamgebruik is ongelijk aan "P"

    Abstract Scenario: persoon met (ex-)partner, heeft een geslachtsnaam met standaardwaarde, en heeft aanduiding naamgebruik "<naamgebruik>"
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | geslachtsnaam (02.40)          | .             |
      | voornamen (02.10)              | Franklin      |
      | aanduiding naamgebruik (61.10) | <naamgebruik> |
      En de persoon heeft een 'partner' met de volgende 'naam' gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Aedel  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.naam            |
      Dan heeft de response een persoon met een leeg 'adressering' object

      Voorbeelden:
      | naamgebruik |
      | E           |
      | V           |
      | N           |

    Abstract Scenario: persoon met (ex-)partner, heeft geen geslachtsnaam, en heeft aanduiding naamgebruik "<naamgebruik>"
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | voornamen (02.10)              | Franklin      |
      | aanduiding naamgebruik (61.10) | <naamgebruik> |
      En de persoon heeft een 'partner' met de volgende 'naam' gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Aedel  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.naam            |
      Dan heeft de response een persoon met een leeg 'adressering' object

      Voorbeelden:
      | naamgebruik |
      | E           |
      | V           |
      | N           |

    Scenario: persoon met (ex-)partner, heeft een geslachtsnaam met standaardwaarde, en heeft aanduiding naamgebruik "P"
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde   |
      | geslachtsnaam (02.40)          | .        |
      | voornamen (02.10)              | Franklin |
      | aanduiding naamgebruik (61.10) | P        |
      En de persoon heeft een 'partner' met de volgende 'naam' gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Aedel  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.naam            |
      Dan heeft de response een persoon met de volgende 'adressering' naam
      | naam                 | waarde   |
      | aanschrijfwijze.naam | F. Aedel |

    Scenario: persoon met (ex-)partner, heeft geen geslachtsnaam met standaardwaarde, en heeft aanduiding naamgebruik "P"
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde   |
      | voornamen (02.10)              | Franklin |
      | aanduiding naamgebruik (61.10) | P        |
      En de persoon heeft een 'partner' met de volgende 'naam' gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Aedel  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.naam            |
      Dan heeft de response een persoon met de volgende 'adressering' naam
      | naam                 | waarde   |
      | aanschrijfwijze.naam | F. Aedel |

  Rule: er is geen aanschrijfwijze als de geslachtsnaam van de partner gelijk is aan de standaardwaard en aanduiding naamgebruik is ongelijk aan "E"

    Abstract Scenario: persoon met aanduiding naamgebruik "<naamgebruik>", heeft een partner met geslachtsnaam gelijk aan standaardwaarde
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | voornamen (02.10)              | Franklin      |
      | geslachtsnaam (02.40)          | Groenen       |
      | aanduiding naamgebruik (61.10) | <naamgebruik> |
      En de persoon heeft een 'partner' met de volgende 'naam' gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | .      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met een leeg 'adressering' object

      Voorbeelden:
      | naamgebruik |
      | P           |
      | V           |
      | N           |

    Scenario: persoon met aanduiding naamgebruik "E", heeft een partner met geslachtsnaam gelijk aan standaardwaarde
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde   |
      | voornamen (02.10)              | Franklin |
      | geslachtsnaam (02.40)          | Groenen  |
      | aanduiding naamgebruik (61.10) | E        |
      En de persoon heeft een 'partner' met de volgende 'naam' gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | .      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                 | waarde     |
      | aanschrijfwijze.naam | F. Groenen |

    Abstract Scenario: persoon met aanduiding naamgebruik "<naamgebruik>", heeft een partner zonder geslachtsnaam
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | voornamen (02.10)              | Franklin      |
      | geslachtsnaam (02.40)          | Groenen       |
      | aanduiding naamgebruik (61.10) | <naamgebruik> |
      En de persoon heeft een 'partner' met de volgende 'naam' gegevens
      | naam              | waarde  |
      | voornamen (02.10) | Jantine |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met een leeg 'adressering' object

      Voorbeelden:
      | naamgebruik |
      | P           |
      | V           |
      | N           |

    Scenario: persoon met aanduiding naamgebruik "E", heeft een partner met geslachtsnaam gelijk aan standaardwaarde
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde   |
      | voornamen (02.10)              | Franklin |
      | geslachtsnaam (02.40)          | Groenen  |
      | aanduiding naamgebruik (61.10) | E        |
      En de persoon heeft een 'partner' met de volgende 'naam' gegevens
      | naam              | waarde  |
      | voornamen (02.10) | Jantine |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                 | waarde     |
      | aanschrijfwijze.naam | F. Groenen |
