# language: nl

Functionaliteit: Persoon beperkt: verblijfplaats locatie

  Abstract Scenario: persoon heeft 'locatie' veld: 'functie adres (10.10)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                     |
    | gemeente_code               | 0518                       |
    | locatiebeschrijving (12.10) | Woonboot op de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <field>                             |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                      | waarde    |
    | type                      | Locatie   |
    | functieAdres.code         | W         |
    | functieAdres.omschrijving | woonadres |

    Voorbeelden:
    | field                                    |
    | functieAdres                             |
    | verblijfplaats.functieAdres              |
    | functieAdres.code                        |
    | verblijfplaats.functieAdres.omschrijving |
