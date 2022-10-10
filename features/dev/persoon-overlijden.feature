#language: nl

@post-assert
Functionaliteit: Overlijden

  Abstract Scenario: persoon heeft 'overlijden' datum veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden                      |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam               | waarde         |
    | indicatieOverleden | true           |
    | <naam>.type        | Datum          |
    | <naam>.datum       | <waarde>       |
    | <naam>.langFormaat | <lang formaat> |

    Voorbeelden:
    | gba naam                 | gba waarde | naam  | waarde     | lang formaat |
    | datum overlijden (08.10) | 20020701   | datum | 2002-07-01 | 1 juli 2002  |

  Abstract Scenario: persoon heeft 'overlijden' waardetabel veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden.<naam>               |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                  | naam                | gba waarde | waarde                       |
    | plaats overlijden (08.20) | plaats.code         | 0518       | 0518                         |
    | plaats overlijden (08.20) | plaats.omschrijving | 0518       | 's-Gravenhage                |
    | land overlijden (08.30)   | land.code           | 6014       | 6014                         |
    | land overlijden (08.30)   | land.omschrijving   | 6014       | Verenigde Staten van Amerika |

  Abstract Scenario: persoon's overlijden velden is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | datum overlijden (08.10)        | 19630405                  |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden                      |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                         | waarde                             |
    | indicatieOverleden                           | true                               |
    | datum.type                                   | Datum                              |
    | datum.datum                                  | 1963-04-05                         |
    | datum.langFormaat                            | 5 april 1963                       |
    | inOnderzoek.datum                            | <datum in onderzoek>               |
    | inOnderzoek.plaats                           | <plaats in onderzoek>              |
    | inOnderzoek.land                             | <land in onderzoek>                |
    | inOnderzoek.indicatieOverleden               | <indicatie overleden in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                              |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                         |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                        |

    Voorbeelden:
    | gba in onderzoek waarde | datum in onderzoek | plaats in onderzoek | land in onderzoek | indicatie overleden in onderzoek |
    | 060000                  | true               | true                | true              | true                             |
    | 060800                  | true               | true                | true              | true                             |
    | 060810                  | true               |                     |                   | true                             |
    | 060820                  |                    | true                |                   |                                  |
    | 060830                  |                    |                     | true              |                                  |
