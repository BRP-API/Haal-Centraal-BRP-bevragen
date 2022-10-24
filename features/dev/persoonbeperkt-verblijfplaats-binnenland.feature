# language: nl

Functionaliteit: Persoon beperkt: verblijfplaats binnenland

  Abstract Scenario: persoon heeft 'verblijfplaats binnenland' veld: 'functie adres (10.10)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    | functie adres (10.10)              | W        |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam               | waarde |
    | gemeente_code      | 0518   |
    | straatnaam (11.10) | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <field>                             |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                      | waarde    |
    | type                      | Adres     |
    | functieAdres.code         | W         |
    | functieAdres.omschrijving | woonadres |

    Voorbeelden:
    | field                                    |
    | functieAdres                             |
    | verblijfplaats.functieAdres              |
    | functieAdres.code                        |
    | verblijfplaats.functieAdres.omschrijving |

  Scenario: persoon geen woonplaats en gemeente van inschrijving omschrijving velden (komt niet meer voor)
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                              | waarde |
    | gemeente van inschrijving (09.10) | 0518   |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam               | waarde |
    | gemeente_code      | 0518   |
    | straatnaam (11.10) | Spui   |
    | huisnummer (11.20) | 123    |
    | postcode (11.60)   | 1234AA |
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | 1234AA                      |
    | huisnummer | 123                         |
    | fields     | adresregel2                 |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000152 |
