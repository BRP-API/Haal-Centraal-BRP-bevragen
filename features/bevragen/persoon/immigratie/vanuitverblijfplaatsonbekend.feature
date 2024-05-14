#language: nl

Functionaliteit: Persoon: immigratie veld 'vanuitVerblijfplaatsOnbekend' vragen met fields

Regel: vanuitVerblijfplaatsOnbekend krijgt de waarde true wanneer land van waar ingeschreven de waarde '0000' (onbekend) heeft

  Scenario: 'land vanwaar ingeschreven (14.10)' met waarde 0000 wordt gevraagd met field pad 'immigratie.vanuitVerblijfplaatsOnbekend'
    Gegeven de persoon met burgerservicenummer '000000395' heeft de volgende 'verblijfplaats' gegevens 
    | naam                              | waarde |
    | land vanwaar ingeschreven (14.10) | 0000   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000395                               |
    | fields              | immigratie.vanuitVerblijfplaatsOnbekend |
    Dan heeft de response een persoon met alleen de volgende 'immigratie' gegevens
    | naam                         | waarde |
    | vanuitVerblijfplaatsOnbekend | true   |
