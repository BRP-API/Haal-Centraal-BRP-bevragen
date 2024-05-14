#language: nl

Functionaliteit: Persoon: leeftijd

Regel: leeftijd wordt geleverd bij een volledig bekende geboortedatum

  Abstract Scenario: geboortedatum is een volledig datum
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde  |
    | geboortedatum (03.10) | <datum> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | leeftijd                        |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam     | waarde     |
    | leeftijd | <leeftijd> |

    Voorbeelden:
    | datum              | leeftijd |
    | vandaag - 10 jaar  | 10       |
    | gisteren - 15 jaar | 15       |
    | morgen - 20 jaar   | 19       |

  @skip-verify
  Abstract Scenario: geboortedatum valt op 29 februari in een schrikkeljaar
    Gegeven de persoon met burgerservicenummer '000000231' heeft de volgende gegevens
      | naam                  | waarde   |
      | geboortedatum (03.10) | 19960229 |
      Als personen op '<raadpleeg datum>' wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000231                       |
      | fields              | burgerservicenummer,leeftijd    |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde     |
      | burgerservicenummer | 000000231  |
      | leeftijd            | <leeftijd> |

      Voorbeelden:
      | raadpleeg datum  | leeftijd |
      | 28 februari 2016 | 19       |
      | 29 februari 2016 | 20       |
      | 28 februari 2017 | 20       |
      | 01 maart 2017    | 21       |

Regel: leeftijd wordt niet geleverd bij een volledig onbekende geboortedatum

  Scenario: geboortedatum is een onbekend datum
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 00000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | leeftijd                        |
    Dan heeft de response een persoon zonder gegevens

Regel: leeftijd wordt niet geleverd bij een geboortedatum waarvan alleen het jaar bekend is

  Scenario: maand en dag van geboortedatum is onbekend
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 20000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | leeftijd                        |
    Dan heeft de response een persoon zonder gegevens

Regel: leeftijd wordt niet geleverd bij een geboortedatum waarvan alleen de dag onbekend is als de geboortemaand gelijk is aan de huidige maand

  Abstract Scenario: dag van geboortedatum is onbekend en geboortemaand is niet de huidige maand
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde          |
    | geboortedatum (03.10) | <geboortedatum> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | leeftijd                        |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam     | waarde     |
    | leeftijd | <leeftijd> |

    Voorbeelden:
    | geboortedatum            | leeftijd |
    | volgende maand - 10 jaar | 9        |
    | vorige maand - 10 jaar   | 10       |

  Scenario: dag van geboortedatum is onbekend en geboortemaand is de huidige maand
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde               |
    | geboortedatum (03.10) | deze maand - 10 jaar |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | leeftijd                        |
    Dan heeft de response een persoon zonder gegevens

Regel: leeftijd wordt niet geleverd voor een overleden persoon

  Scenario: persoon is overleden
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'overlijden' gegevens
    | datum overlijden (08.10) | plaats overlijden (08.20) | land overlijden (08.30) |
    | 20020701                 | 0518                      | 6030                    |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | naam                                 | waarde |
    | reden opschorting bijhouding (67.20) | O      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | leeftijd                        |
    Dan heeft de response een persoon met alleen de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde     |
    | reden.code         | O          |
    | reden.omschrijving | overlijden |
