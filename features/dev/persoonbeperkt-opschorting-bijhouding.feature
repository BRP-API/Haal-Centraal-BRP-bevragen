#language: nl

Functionaliteit: Persoon beperkt: opschorting bijhouding

  Abstract Scenario: persoon heeft veld: 'reden opschorting bijhouding (67.20)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | naam                                 | waarde |
    | reden opschorting bijhouding (67.20) | O      |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <field>                             |
    Dan heeft de response een persoon met de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde     |
    | reden.code         | O          |
    | reden.omschrijving | overlijden |

    Voorbeelden:
    | field                                    |
    | opschortingBijhouding                    |
    | opschortingBijhouding.reden              |
    | opschortingBijhouding.reden.code         |
    | opschortingBijhouding.reden.omschrijving |
