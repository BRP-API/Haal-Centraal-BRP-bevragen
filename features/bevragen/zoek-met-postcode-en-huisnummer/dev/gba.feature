#language: nl

@gba
Functionaliteit: Zoek met postcode en huisnummer

Regel: Postcode is niet hoofdlettergevoelig en mag zowel met als zonder spatie tussen het cijfer- en letterdeel worden verstrekt.

  Abstract Scenario: <titel> 
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0599                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeente_code | postcode (11.60) | huisnummer (11.20) |
    | 0599          | 2628HJ           | 2                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | <postcode>                  |
    | huisnummer | 2                           |
    | fields     | burgerservicenummer         |
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000024 |

    Voorbeelden:
    | titel                                                                       | postcode |
    | de opgegeven postcode is met kleine letters                                 | 2628hj   |
    | de opgegeven postcode is met een spatie tussen de cijfers en letters        | 2628 HJ  |
    | de opgegeven postcode is met een spatie tussen de cijfers en kleine letters | 2628 hj  |
