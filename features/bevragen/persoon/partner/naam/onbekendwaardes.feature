#language: nl

Functionaliteit: Persoon: partner naam velden met standaardwaarde vragen met fields

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
