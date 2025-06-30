# language: nl

Functionaliteit: Als gemeente wil ik de geen onjuiste aanschrijfwijze van mijn burgers 

  Regel: Wanneer de geslachtsnaam van de persoon leeg of onbekend is en de naam van de persoon wordt gebruikt, wordt aanschrijfwijze niet opgenomen

    Abstract Scenario: geslachtsnaam van de persoon is onbekend bij aanduiding naamgebruik "<naamgebruik>" levert geen aanschrijfwijze
      Gegeven de persoon met burgerservicenummer '000000401' heeft de volgende gegevens
      | naam                           | waarde                   |
      | voornamen (02.10)              | Ali bin Mohammed         |
      | geslachtsnaam (02.40)          | .                        |
      | aanduiding naamgebruik (61.10) | <aanduiding naamgebruik> |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   | de     |
      | geslachtsnaam (02.40) | Boer   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000401                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon zonder 'adressering' gegevens

      Voorbeelden:
      | aanduiding naamgebruik |
      | E                      |
      | V                      |
      | N                      |

    Abstract Scenario: geen geslachtsnaam van de persoon bij aanduiding naamgebruik "<naamgebruik>" levert geen aanschrijfwijze
      Gegeven de persoon met burgerservicenummer '000000401' heeft de volgende gegevens
      | naam                           | waarde                   |
      | voornamen (02.10)              | Ali bin Mohammed         |
      | aanduiding naamgebruik (61.10) | <aanduiding naamgebruik> |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   | de     |
      | geslachtsnaam (02.40) | Boer   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000401                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon zonder 'adressering' gegevens

      Voorbeelden:
      | aanduiding naamgebruik |
      | E                      |
      | V                      |
      | N                      |

    Scenario: naam van de persoon is onbekend bij aanduiding naamgebruik "P" levert wel aanschrijfwijze
      Gegeven de persoon met burgerservicenummer '000000401' heeft de volgende gegevens
      | naam                           | waarde           |
      | voornamen (02.10)              | Ali bin Mohammed |
      | geslachtsnaam (02.40)          | .                |
      | aanduiding naamgebruik (61.10) | P                |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   | de     |
      | geslachtsnaam (02.40) | Boer   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000401                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                 | waarde         |
      | aanschrijfwijze.naam | A.b.M. de Boer |