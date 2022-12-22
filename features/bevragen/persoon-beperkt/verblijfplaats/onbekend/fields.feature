# language: nl

Functionaliteit: Persoon beperkt: verblijfplaats onbekend velden vragen met fields

  Abstract Scenario: 'functie adres (10.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                          | waarde |
    | functie adres (10.10)         | W      |
    | land adres buitenland (13.10) | 0000   |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                      | waarde                 |
    | type                      | VerblijfplaatsOnbekend |
    | functieAdres.code         | W                      |
    | functieAdres.omschrijving | woonadres              |

    Voorbeelden:
    | fields                                   |
    | verblijfplaats                           |
    | verblijfplaats.functieAdres              |
    | verblijfplaats.functieAdres.code         |
    | verblijfplaats.functieAdres.omschrijving |
