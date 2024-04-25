#language: nl

@protocollering
Functionaliteit: Protocollering zoekrubrieken ZoekMetPostcodeEnHuisnummer

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | anummer (01.10) |
      | 2683754153      |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                         | waarde          |
      | gemeentecode (92.10)         | 0599            |
      | straatnaam (11.10)           | Borgesiusstraat |
      | huisnummer (11.20)           | 103             |
      | huisletter (11.30)           | b               |
      | huisnummertoevoeging (11.40) | 2               |
      | postcode (11.60)             | 2497BV          |

  Regel: Gebruikte parameters worden vertaald naar elementnummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_zoek_rubrieken'.

    Scenario: Zoek persoon met alleen de verplichte parameters
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                      |
      | type                    | ZoekMetPostcodeEnHuisnummer |
      | postcode                | 2497BV                      |
      | huisnummer              | 103                         |
      | fields                  | burgerservicenummer         |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | 081120, 081160         |

    Abstract Scenario: Zoek persoon met parameter <optionele parameter>
      Als personen wordt gezocht met de volgende parameters
      | naam                  | waarde                      |
      | type                  | ZoekMetPostcodeEnHuisnummer |
      | postcode              | 2497BV                      |
      | huisnummer            | 103                         |
      | <optionele parameter> | <waarde>                    |
      | fields                | burgerservicenummer         |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | <zoek_rubrieken>       |

      Voorbeelden:
      | optionele parameter     | waarde | zoek_rubrieken         |
      | huisletter              | b      | 081120, 081130, 081160 |
      | huisnummertoevoeging    | 2      | 081120, 081140, 081160 |
      | gemeenteVanInschrijving | 0599   | 080910, 081120, 081160 |


  Regel: Gebruik van de parameter inclusiefOverledenPersonen wordt niet vastgelegd in veld 'request_zoek_rubrieken'.

    Scenario: Zoek persoon met inclusiefOverledenPersonen
      Als personen wordt gezocht met de volgende parameters
      | naam                       | waarde                      |
      | type                       | ZoekMetPostcodeEnHuisnummer |
      | postcode                   | 2497BV                      |
      | huisnummer                 | 103                         |
      | fields                     | burgerservicenummer         |
      | inclusiefOverledenPersonen | true                        |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | 081120, 081160         |
