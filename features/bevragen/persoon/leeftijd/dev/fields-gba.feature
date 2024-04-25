#language: nl

@gba
Functionaliteit: leeftijd veld vragen met fields (persoon)

Regel: geboortedatum wordt geleverd voor een niet-overleden persoon bij field pad 'leeftijd'

  Scenario: persoon is niet overleden
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19500304 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | leeftijd                        |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam           | waarde   |
    | geboorte.datum | 19500304 |

Regel: geboortedatum en reden opschorting bijhouding wordt geleverd voor een overleden persoon bij field pad 'leeftijd'

  Scenario: persoon is overleden
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19500304 |
    En de persoon heeft de volgende 'overlijden' gegevens
    | datum overlijden (08.10) | plaats overlijden (08.20) | land overlijden (08.30) |
    | 20020701                 | 0518                      | 6030                    |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | naam                                 | waarde |
    | reden opschorting bijhouding (67.20) | O      |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | leeftijd                        |
    Dan heeft de response een persoon met alleen de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde     |
    | reden.code         | O          |
    | reden.omschrijving | overlijden |
    En heeft de persoon de volgende 'geboorte' gegevens
    | naam  | waarde   |
    | datum | 19500304 |
