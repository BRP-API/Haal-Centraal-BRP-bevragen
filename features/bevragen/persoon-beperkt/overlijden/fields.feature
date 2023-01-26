#language: nl

Functionaliteit: Persoon beperkt: overlijden velden vragen met fields

  Abstract Scenario: indicatieOverlijden wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'overlijden' gegevens
    | naam                     | waarde   |
    | datum overlijden (08.10) | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                              |
    | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam              | Maassen                             |
    | geboortedatum              | 1983-05-26                          |
    | inclusiefOverledenPersonen | true                                |
    | fields                     | <fields>                            |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam               | waarde |
    | indicatieOverleden | true   |

    Voorbeelden:
    | fields                        |
    | overlijden                    |
    | overlijden.indicatieOverleden |
