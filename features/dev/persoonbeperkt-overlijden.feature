#language: nl

Functionaliteit: Persoon beperkt: overlijden

  Abstract Scenario: persoon heeft 'overlijden' datum veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
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
