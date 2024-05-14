#language: nl

@gba
Functionaliteit: overlijden onjuist (persoon)

  Regel: Onjuiste gegevens worden niet geleverd

  Scenario: land overlijden is onjuist en gecorrigeerd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | plaats overlijden (08.20)       | 0344                      |
    | datum overlijden (08.10)        | 20020701                  |
    | land overlijden (08.30)         | 5018                      |
    En het 'overlijden' is gecorrigeerd naar de volgende gegevens
    | naam                            | waarde                    |
    | plaats overlijden (08.20)       | 0344                      |
    | datum overlijden (08.10)        | 20020701                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden                      |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                | waarde                       |
    | datum               | 20020701                     |
    | plaats.code         | 0344                         |
    | plaats.omschrijving | Utrecht                      |

  Scenario: overlijden is onjuist (persoon is niet overleden)
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | plaats overlijden (08.20)       | 0344                      |
    | datum overlijden (08.10)        | 20020701                  |
    | land overlijden (08.30)         | 5018                      |
    En het 'overlijden' is gecorrigeerd naar de volgende gegevens
    | naam                            | waarde           |
    | gemeente document (82.10)       | 0518             |
    | datum document (82.20)          | 20040105         |
    | beschrijving document (82.30)   | D27894-2004-A782 |
    | ingangsdatum geldigheid (85.10) | 20031107         |
    | datum van opneming (86.10)      | 20040112         |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden                      |
    Dan heeft de response een persoon zonder gegevens

  Scenario: persoon is niet overleden
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Vries  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden                      |
    Dan heeft de response een persoon zonder gegevens