#language: nl

@post-assert
Functionaliteit: Overlijden

  Abstract Scenario: persoon heeft 'overlijden' datum veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'overlijden' gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | overlijden                      |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam               | waarde   |
    | indicatieOverleden | true     |
    | <naam>.type        | Datum    |
    | <naam>.datum       | <waarde> |

    Voorbeelden:
    | gba naam                 | gba waarde | naam  | waarde     |
    | datum overlijden (08.10) | 20020701   | datum | 2002-07-01 |

  Abstract Scenario: persoon heeft 'overlijden' waardetabel veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'overlijden' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | overlijden                      |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam               | waarde   |
    | indicatieOverleden | true     |
    | <naam>             | <waarde> |

    Voorbeelden:
    | gba naam                  | naam                | waarde                       |
    | plaats overlijden (08.20) | plaats.code         | 0518                         |
    | plaats.omschrijving       | plaats.omschrijving | 's-Gravenhage                |
    | land overlijden (08.30)   | land.code           | 6014                         |
    | land.omschrijving         | land.omschrijving   | Verenigde Staten van Amerika |

  Abstract Scenario: persoon's overlijden velden is in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'overlijden' gegevens
    | naam                                     | waarde                    |
    | datum overlijden (08.10)                 | 19630405                  |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | overlijden                      |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                   | waarde                             |
    | indicatieOverleden                     | true                               |
    | datum.type                             | Datum                              |
    | datum.datum                            | 1963-04-05                         |
    | inOnderzoek.datum                      | <datum in onderzoek>               |
    | inOnderzoek.plaats                     | <plaats in onderzoek>              |
    | inOnderzoek.land                       | <land in onderzoek>                |
    | inOnderzoek.indicatieOverleden         | <indicatie overleden in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek.type  | Datum                              |
    | inOnderzoek.datumIngangOnderzoek.datum | 2002-07-01                         |

    Voorbeelden:
    | gba in onderzoek waarde | datum in onderzoek | plaats in onderzoek | land in onderzoek | indicatie overleden in onderzoek |
    | 060000                  | true               | true                | true              | true                             |
    | 060800                  | true               | true                | true              | true                             |
    | 060810                  | true               |                     |                   | true                             |
    | 060820                  |                    | true                |                   |                                  |
    | 060830                  |                    |                     | true              |                                  |
