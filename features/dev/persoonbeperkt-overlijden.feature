#language: nl

@post-assert
Functionaliteit: OverlijdenBeperkt

  Abstract Scenario: persoon heeft 'overlijden' datum veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995078 |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'overlijden' gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                              |
    | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam              | Maassen                             |
    | geboortedatum              | 1983-05-26                          |
    | inclusiefOverledenPersonen | true                                |
    | fields                     | overlijden                          |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam               | waarde |
    | indicatieOverleden | true   |

    Voorbeelden:
    | gba naam                 | gba waarde |
    | datum overlijden (08.10) | 20020701   |
