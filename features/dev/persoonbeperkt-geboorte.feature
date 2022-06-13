#language: nl

@post-assert
Functionaliteit: PersoonBeperkt Geboorte

  Scenario: persoon heeft 'geboorte' datum veld: 'geboortedatum (03.10)'
    Gegeven het systeem heeft een persoon met de volgende 'naam' gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | geboorte                            |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam              | waarde      |
    | datum.type        | Datum       |
    | datum.datum       | 1983-05-26  |
    | datum.langFormaat | 26 mei 1983 |
