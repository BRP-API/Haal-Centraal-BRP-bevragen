#language: nl

Functionaliteit: Adresregels adressering locatie vullen

  Rule: Voor een binnenlandse locatie wordt adresregel1 gevuld met de locatiebeschrijving

    Scenario: adresregel1 voor locatie
    Gegeven de persoon met burgerservicenummer '000000309' heeft de volgende 'verblijfplaats' gegevens
      | naam                  | waarde     |
      | functie adres (10.10) | W          |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                        | waarde                            |
      | locatiebeschrijving (12.10) | Woonboot tegenover de Grote Sloot |
      | gemeente_code               | 0518                              |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000309                       |
      | fields              | adressering.adresregel1         |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam        | waarde                            |
      | adresregel1 | Woonboot tegenover de Grote Sloot |

  Rule: Voor een locatie wordt adresregel2 samengesteld conform NEN 5825:2002.
    - Veld adresregel2 wordt samengesteld uit postcode + woonplaats
    - Tussen postcode numeriek deel en postcode alfabetisch deel wordt een spatie geplaatst
    - Tussen postcode alfabetisch deel en woonplaatsnaam worden twee spaties geplaatst
    - De woonplaatsnaam wordt in hoofdletters geschreven
    - Wanneer de woonplaats geen waarde heeft, wordt de omschrijving van de gemeente van inschrijving als woonplaats gebruikt

    Scenario: adresregel2 zonder postcode voor locatie
    Gegeven de persoon met burgerservicenummer '000000334' heeft de volgende 'verblijfplaats' gegevens
      | naam                                 | waarde        |
      | gemeente van inschrijving (09.10)    | 0518          |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                        | waarde                     |
      | locatiebeschrijving (12.10) | Woonboot tegenover de Grote Sloot |
      | gemeente_code               | 0518                              |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000334                       |
      | fields              | adressering.adresregel2         |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam        | waarde        |
      | adresregel2 | 'S-GRAVENHAGE |

    Scenario: adresregel2 voor locatie
    Gegeven de persoon met burgerservicenummer '000000334' heeft de volgende 'verblijfplaats' gegevens
      | naam                                 | waarde        |
      | gemeente van inschrijving (09.10)    | 0518          |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                        | waarde                     |
      | locatiebeschrijving (12.10) | Woonboot tegenover de Grote Sloot |
      | postcode (11.60)            | 2584BZ                            | 
      | gemeente_code               | 0518                              |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000334                       |
      | fields              | adressering.adresregel2         |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam        | waarde                 |
      | adresregel2 | 2584 BZ  'S-GRAVENHAGE |