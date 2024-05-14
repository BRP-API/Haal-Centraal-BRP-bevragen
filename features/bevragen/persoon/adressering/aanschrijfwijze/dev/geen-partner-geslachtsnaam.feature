# language: nl

Functionaliteit: Als gemeente wil ik alleen juiste partnergegevens gebruiken in de aanschrijfwijze van mijn burgers 

  Regel: Wanneer de geslachtsnaam van de partner leeg of onbekend is en de naam van de partner wordt gebruikt, wordt aanduiding naamgebruik "E" (eigen naam) gehanteerd

    Abstract Scenario: geslachtsnaam van de partner is onbekend bij aanduiding naamgebruik "<naamgebruik>" levert aanschrijfwijze met eigen naam
      Gegeven de persoon met burgerservicenummer '000000504' heeft de volgende gegevens
      | naam                           | waarde                   |
      | voornamen (02.10)              | Fred                     |
      | geslachtsnaam (02.40)          | Groenen                  |
      | aanduiding naamgebruik (61.10) | <aanduiding naamgebruik> |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | .      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000504                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                 | waarde     |
      | aanschrijfwijze.naam | F. Groenen |

      Voorbeelden:
      | aanduiding naamgebruik |
      | P                      |
      | V                      |
      | N                      |

    Abstract Scenario: geen geslachtsnaam van de partner bij aanduiding naamgebruik "<naamgebruik>" levert aanschrijfwijze met eigen naam
      Gegeven de persoon met burgerservicenummer '000000516' heeft de volgende gegevens
      | naam                           | waarde                   |
      | voornamen (02.10)              | Fred                     |
      | geslachtsnaam (02.40)          | Groenen                  |
      | aanduiding naamgebruik (61.10) | <aanduiding naamgebruik> |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam              | waarde           |
      | voornamen (02.10) | Ali bin Mohammed |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000516                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                 | waarde     |
      | aanschrijfwijze.naam | F. Groenen |

      Voorbeelden:
      | aanduiding naamgebruik |
      | P                      |
      | V                      |
      | N                      |

    Abstract Scenario: persoon heeft partner met onbekende naam en adellijkeTitelPredicaat "B"
      Gegeven de persoon met burgerservicenummer '000000528' heeft de volgende gegevens
      | naam                           | waarde    |
      | geslachtsaanduiding (04.10)    | V         |
      | voornamen (02.10)              | Jo Anne   |
      | voorvoegsel (02.30)            | de        |
      | geslachtsnaam (02.40)          | Boer      |
      | aanduiding naamgebruik (61.10) | P         |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                 | waarde |
      | adellijke titel of predicaat (02.20) | B      |
      | geslachtsnaam (02.40)                | .      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000528                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                 | waarde       |
      | aanschrijfwijze.naam | J.A. de Boer |

    Abstract Scenario: persoon zonder partner bij aanduiding naamgebruik "<naamgebruik>" levert aanschrijfwijze met eigen naam
      Gegeven de persoon met burgerservicenummer '000000541' heeft de volgende gegevens
      | naam                           | waarde                   |
      | voornamen (02.10)              | Fred                     |
      | geslachtsnaam (02.40)          | Groenen                  |
      | aanduiding naamgebruik (61.10) | <aanduiding naamgebruik> |
      En de persoon heeft nooit een actueel of ontbonden huwelijk of partnerschap gehad
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000541                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                 | waarde     |
      | aanschrijfwijze.naam | F. Groenen |

      Voorbeelden:
      | aanduiding naamgebruik |
      | P                      |
      | V                      |
      | N                      |
