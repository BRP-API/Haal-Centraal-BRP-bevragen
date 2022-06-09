# language: nl

@proxy @post-assert
Functionaliteit: verblijfplaats buitenland beperkt

  Abstract Scenario: persoon heeft 'verblijfplaats' veld: 'land adres buitenland (13.10)' met waarde ongelijk aan '0000'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995078 |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                          | waarde |
    | land adres buitenland (13.10) | <land> |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | verblijfplaats                      |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                   |
    | type | VerblijfplaatsBuitenland |

    Voorbeelden:
    | land |
    | 6014 |
    | 9999 |
