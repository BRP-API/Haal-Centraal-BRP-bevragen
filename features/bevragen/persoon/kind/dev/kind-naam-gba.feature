# language: nl

@gba
Functionaliteit: kind - naam

    Abstract Scenario: Kind voorvoegsel naam is leeg
      Gegeven de persoon met burgerservicenummer '000000152' heeft een 'kind' met de volgende gegevens
      | naam                  | waarde  |
      | voornamen (02.10)     | William |
      | geslachtsnaam (02.40) | Postma  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | <fields>                        |
      Dan heeft de response een persoon met een 'kind' met de volgende 'naam' gegevens
      | naam          | waarde  |
      | voornamen     | William |
      | geslachtsnaam | Postma  |

      Voorbeelden:
      | fields                                                                        |
      | kinderen.naam                                                                 |
      | kinderen.naam.voornamen,kinderen.naam.geslachtsnaam                           |
      | kinderen.naam.voornamen,kinderen.naam.voorvoegsel,kinderen.naam.geslachtsnaam |

    Scenario: Kind voorletters gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft een 'kind' met de volgende gegevens
      | naam                  | waarde  |
      | voornamen (02.10)     | William |
      | geslachtsnaam (02.40) | Postma  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | kinderen.naam.voorletters       |
      Dan heeft de response een persoon met een 'kind' met de volgende 'naam' gegevens
      | naam          | waarde  |
      | voornamen     | William |
