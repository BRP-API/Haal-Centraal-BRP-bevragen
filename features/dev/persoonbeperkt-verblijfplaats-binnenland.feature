# language: nl

Functionaliteit: Persoon beperkt: verblijfplaats binnenland

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
    | naam       | waarde                                       |
    | type       | ZoekMetPostcodeEnHuisnummer                  |
    | postcode   | 1234AA                                       |
    | huisnummer | 123                                          |
    | fields     | burgerservicenummer,adressering.adresregel2  |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000152 |
