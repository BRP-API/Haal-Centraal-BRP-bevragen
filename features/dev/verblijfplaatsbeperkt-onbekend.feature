# language: nl

@proxy @post-assert
Functionaliteit: verblijfplaats onbekend

  Abstract Scenario: persoon heeft 'verblijfplaats onbekend' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende 'naam' gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | verblijfplaats.<naam>               |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam   | waarde                 |
    | type   | VerblijfplaatsOnbekend |
    | <naam> | <waarde>               |

    Voorbeelden:
    | gba naam              | naam              | waarde |
    | functie adres (10.10) | functieAdres.code | W      |
