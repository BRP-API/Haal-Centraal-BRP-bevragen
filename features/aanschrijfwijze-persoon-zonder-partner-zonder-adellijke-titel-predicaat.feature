#language: nl

Functionaliteit: Aanschrijfwijze voor persoon zonder (ex-)partner, zonder adellijke titel/predicaat

  Rule: Voor een persoon zonder (ex-)partner, zonder adellijke titel of predicaat,
        wordt de naam in aanschrijfwijze als volgt samengesteld: VL VV GN

    Scenario: persoon heeft geen voorvoegsel
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En die persoon heeft alleen de volgende 'naam' gegevens
      | naam                  | waarde   |
      | geslachtsnaam (02.40) | Groenen  |
      | voornamen (02.10)     | Franklin |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde     |
      | aanschrijfwijze.naam | F. Groenen |

    Scenario: persoon heeft een naamketen (alleen geslachtsnaam)
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En die persoon heeft alleen de volgende 'naam' gegevens
      | naam                  | waarde           |
      | geslachtsnaam (02.40) | Ali bin Mohammed |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde           |
      | aanschrijfwijze.naam | Ali bin Mohammed |

  Rule: voorvoegsel wordt gebruikt zoals het is geregistreerd

    Abstract Scenario: persoon heeft voorvoegsel
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En die persoon heeft alleen de volgende 'naam' gegevens
      | naam                  | waarde        |
      | voorvoegsel (02.30)   | <voorvoegsel> |
      | geslachtsnaam (02.40) | Groenen       |
      | voornamen (02.10)     | Franklin      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde                   |
      | aanschrijfwijze.naam | F. <voorvoegsel> Groenen |

      Voorbeelden:
      | voorvoegsel |
      | van         |
      | Van         |
      | in het      |
      | In Den      |

  Rule: de eerste naamcomponent in de naam in aanschrijfwijze begint met een hoofdletter

    Scenario: persoon heeft geen voorvoegsel en geen voornamen
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft alleen de volgende 'naam' gegevens
      | naam                  | waarde  |
      | geslachtsnaam (02.40) | Groenen |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde  |
      | aanschrijfwijze.naam | Groenen |

    Abstract Scenario: persoon met voorvoegsel, heeft geen voornamen
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft alleen de volgende 'naam' gegevens
      | naam                  | waarde        |
      | voorvoegsel (02.30)   | <voorvoegsel> |
      | geslachtsnaam (02.40) | Groenen       |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | voorvoegsel | naam in aanschrijfwijze |
      | van         | Van Groenen             |
      | Van         | Van Groenen             |
      | in het      | In het Groenen          |
      | In Den      | In Den Groenen          |

  Rule: er is geen aanschrijfwijze als de geslachtsnaam van de persoon gelijk is aan de standaardwaarde

    Scenario: persoon heeft een geslachtsnaam met standaardwaarde
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                  | waarde          |
      | voornamen (02.10)     | Franklin |
      | geslachtsnaam (02.40) | . |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze            |
      Dan heeft de response een persoon met een leeg 'adressering' object

    Scenario: persoon heeft geen geslachtsnaam
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                  | waarde          |
      | voornamen (02.10)     | Franklin |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze            |
      Dan heeft de response een persoon met een leeg 'adressering' object
