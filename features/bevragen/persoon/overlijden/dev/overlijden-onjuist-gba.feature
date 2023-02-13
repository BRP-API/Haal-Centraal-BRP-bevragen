#language: nl

@gba
Functionaliteit: overlijden onjuist (persoon)

  Rule: Onjuiste gegevens worden niet geleverd

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
