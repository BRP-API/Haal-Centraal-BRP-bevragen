# language: nl

@proxy @post-assert
Functionaliteit: verblijfplaats beperkt binnenland

  Abstract Scenario: persoon heeft 'verblijfplaats binnenland' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende 'naam' gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam               | waarde   |
    | straatnaam (11.10) | Spui     |
    | <gba naam>         | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | verblijfplaats.<naam>               |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam   | waarde   |
    | type   | Adres    |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam              | naam              | waarde |
    | functie adres (10.10) | functieAdres.code | W      |

  Scenario: persoon geen woonplaats en gemeente van inschrijving omschrijving velden 
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                              | waarde    |
    | burgerservicenummer               | 555550001 |
    | gemeente van inschrijving (09.10) | 0518      |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam               | waarde |
    | straatnaam (11.10) | Spui   |
    | huisnummer (11.20) | 123    |
    | postcode (11.60)   | 1234AA |
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | 1234AA                      |
    | huisnummer | 123                         |
    | fields     | burgerservicenummer,naam    |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
