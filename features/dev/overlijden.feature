#language: nl

Functionaliteit: Persoon: overlijden

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

  Scenario: persoon heeft 'overlijden' datum veld: 'datum overlijden (08.10)' en overlijdensgegevens worden niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
    | naam                     | waarde               |
    | voornamen (02.10)        | Fransiscus Albertus |
    En de persoon heeft de volgende 'overlijden' gegevens
    | naam                     | waarde   |
    | datum overlijden (08.10) | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | naam.voornamen                  |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                | waarde                          |
    | voornamen           | Fransiscus Albertus             |
    En heeft de persoon de volgende 'overlijden' gegevens
    | naam               | waarde      |
    | indicatieOverleden | true        |


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
    | naam                | waarde        |
    | indicatieOverleden  | true          |
    | plaats.code         | 0518          |
    | plaats.omschrijving | 's-Gravenhage |

    Voorbeelden:
    | field                          |
    | overlijden.plaats              |
    | overlijden.plaats.code         |
    | overlijden.plaats.omschrijving |

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
    | naam               | waarde                       |
    | indicatieOverleden | true                         |
    | land.code          | 6014                         |
    | land.omschrijving  | Verenigde Staten van Amerika |

    Voorbeelden:
    | field                        |
    | overlijden.land              |
    | overlijden.land.code         |
    | overlijden.land.omschrijving |

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
    | naam                                         | waarde                |
    | indicatieOverleden                           | true                  |
    | inOnderzoek.datum                            | <datum in onderzoek>  |
    | inOnderzoek.plaats                           | <plaats in onderzoek> |
    | inOnderzoek.land                             | <land in onderzoek>   |
    | inOnderzoek.indicatieOverleden               | true                  |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                 |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01            |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002           |

    Voorbeelden:
    | gba in onderzoek waarde | datum in onderzoek | plaats in onderzoek | land in onderzoek |
    | 060000                  | true               | true                | true              |
    | 060800                  | true               | true                | true              |
    | 060810                  | true               |                     |                   |
    | 060820                  |                    | true                |                   |
    | 060830                  |                    |                     | true              |

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
    | indicatieOverleden                           | true         |
    | datum.type                                   | Datum        |
    | datum.datum                                  | 1963-04-05   |
    | datum.langFormaat                            | 5 april 1963 |
    | inOnderzoek.indicatieOverleden               | true         |
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
    | fields              | overlijden.plaats               |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                         | waarde        |
    | indicatieOverleden                           | true          |
    | plaats.code                                  | 0518          |
    | plaats.omschrijving                          | 's-Gravenhage |
    | inOnderzoek.indicatieOverleden               | true          |
    | inOnderzoek.plaats                           | true          |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum         |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01    |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002   |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 060000                  |
    | 060800                  |
    | 060820                  |

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
    | fields              | overlijden.land                 |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                         | waarde                       |
    | indicatieOverleden                           | true                         |
    | land.code                                    | 6014                         |
    | land.omschrijving                            | Verenigde Staten van Amerika |
    | inOnderzoek.indicatieOverleden               | true                         |
    | inOnderzoek.land                             | true                         |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                        |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                   |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                  |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 060000                  |
    | 060800                  |
    | 060830                  |

  Abstract Scenario: datum overlijden is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | datum overlijden (08.10)        | 19630405                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden.plaats               |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                         | waarde      |
    | indicatieOverleden                           | true        |
    | inOnderzoek.indicatieOverleden               | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 060810                  |

  Abstract Scenario: plaats overlijden is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | plaats overlijden (08.20)       | 0518                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden.datum                |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                         | waarde      |
    | indicatieOverleden                           | true        |
    | inOnderzoek.indicatieOverleden               | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 060820                  |

  Abstract Scenario: land overlijden is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | land overlijden (08.30)         | 6014                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden.plaats               |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                         | waarde      |
    | indicatieOverleden                           | true        |
    | inOnderzoek.indicatieOverleden               | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 060830                  |
