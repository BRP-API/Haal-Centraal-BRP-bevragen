#language: nl

@post-assert
Functionaliteit: Opschorting bijhouding beperkt

  Abstract Scenario: opschorting bijhouding: overnemen waardetabel veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995078 |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'opschortingBijhouding' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | opschortingBijhouding.<naam>        |
    Dan heeft de response een persoon met de volgende 'opschortingBijhouding' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam           | field              | naam               | waarde     |
    | reden.code         | plaats.code        | reden.code         | O          |
    | reden.omschrijving | reden.omschrijving | reden.omschrijving | overlijden |
