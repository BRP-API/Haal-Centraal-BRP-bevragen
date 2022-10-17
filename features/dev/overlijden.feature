#language: nl

Functionaliteit: Overlijden velden van persoon

  Abstract Scenario: persoon heeft 'overlijden' datum veld: 'datum overlijden (08.10)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                     | waarde   |
    | datum overlijden (08.10) | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam               | waarde      |
    | indicatieOverleden | true        |
    | datum.type         | Datum       |
    | datum.datum        | 2002-07-01  |
    | datum.langFormaat  | 1 juli 2002 |

    Voorbeelden:
    | field                        |
    | overlijden.datum             |
    | overlijden.datum.type        |
    | overlijden.datum.datum       |
    | overlijden.datum.langFormaat |

  Abstract Scenario: persoon heeft 'overlijden' waardetabel veld: 'plaats overlijden (08.20)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                      | waarde |
    | plaats overlijden (08.20) | 0518   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                | waarde         |
    | indicatieOverleden  | true           |
    | plaats.code         | <code>         |
    | plaats.omschrijving | <omschrijving> |

    Voorbeelden:
    | field                          | code | omschrijving  |
    | overlijden.plaats              | 0518 | 's-Gravenhage |
    | overlijden.plaats.code         | 0518 |               |
    | overlijden.plaats.omschrijving |      | 's-Gravenhage |

  Abstract Scenario: persoon heeft 'overlijden' waardetabel veld: 'land overlijden (08.30)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                    | waarde |
    | land overlijden (08.30) | 6014   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam               | waarde         |
    | indicatieOverleden | true           |
    | land.code          | <code>         |
    | land.omschrijving  | <omschrijving> |

    Voorbeelden:
    | field                        | code | omschrijving                 |
    | overlijden.land              | 6014 | Verenigde Staten van Amerika |
    | overlijden.land.code         | 6014 |                              |
    | overlijden.land.omschrijving |      | Verenigde Staten van Amerika |

  Abstract Scenario: overlijden veld(en) van persoon is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | datum overlijden (08.10)        | 19630405                  |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden.inOnderzoek          |
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

  Abstract Scenario: datum overlijden is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | datum overlijden (08.10)        | 19630405                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden.datum                |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                         | waarde       |
    | datum.type                                   | Datum        |
    | datum.datum                                  | 1963-04-05   |
    | datum.langFormaat                            | 5 april 1963 |
    | inOnderzoek.datum                            | true         |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum        |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01   |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002  |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 060000                  |
    | 060800                  |
    | 060810                  |

  Abstract Scenario: plaats overlijden is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | plaats overlijden (08.20)       | 0518                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden.<field>              |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                         | waarde         |
    | plaats.code                                  | <code>         |
    | plaats.omschrijving                          | <omschrijving> |
    | inOnderzoek.plaats                           | true           |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum          |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01     |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002    |

    Voorbeelden:
    | gba in onderzoek waarde | field               | code | omschrijving  |
    | 060000                  | plaats              | 0518 | 's-Gravenhage |
    | 060800                  | plaats.code         | 0518 |               |
    | 060820                  | plaats.omschrijving |      | 's-Gravenhage |

  Abstract Scenario: land overlijden is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | land overlijden (08.30)         | 6014                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden.<field>              |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                         | waarde         |
    | land.code                                    | <code>         |
    | land.omschrijving                            | <omschrijving> |
    | inOnderzoek.land                             | true           |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum          |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01     |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002    |

    Voorbeelden:
    | gba in onderzoek waarde | field             | code | omschrijving                 |
    | 060000                  | land              | 6014 | Verenigde Staten van Amerika |
    | 060800                  | land.code         | 6014 |                              |
    | 060830                  | land.omschrijving |      | Verenigde Staten van Amerika |
