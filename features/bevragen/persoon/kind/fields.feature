# language: nl

Functionaliteit: Persoon: kind velden vragen met fields

  Abstract Scenario: 'burgerservicenummer (01.20)' wordt gevraagd met field pad 'kinderen.burgerservicenummer'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam       | waarde   |
    | burgerservicenummer (01.20) | 123456789 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.burgerservicenummer    |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende gegevens
    | naam   | waarde   |
    | burgerservicenummer | 123456789 |
