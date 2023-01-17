#language: nl

Functionaliteit: Persoon: partner velden met standaardwaarde vragen met fields

  Abstract Scenario: 'soort verbintenis (15.10)' met standaardwaarde wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                      | waarde |
    | soort verbintenis (15.10) | .      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>       |
    Dan heeft de response een persoon met een 'partner' zonder gegevens

    Voorbeelden:
    | fields                                 |
    | partners.soortVerbintenis              |
    | partners.soortVerbintenis.code         |
    | partners.soortVerbintenis.omschrijving |
