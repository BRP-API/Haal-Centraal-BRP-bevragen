#language: nl

Functionaliteit: Geboorte velden van persoon

  Abstract Scenario: persoon heeft 'geboorte' datum veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam              | waarde      |
    | datum.type        | Datum       |
    | datum.datum       | 2002-07-01  |
    | datum.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | field                      |
    | geboorte.datum             |
    | geboorte.datum.type        |
    | geboorte.datum.datum       |
    | geboorte.datum.langFormaat |

  Abstract Scenario: persoon heeft 'geboorte' veld: 'geboorteplaats (03.20)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                   | waarde |
    | geboorteplaats (03.20) | 0518   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam                | waarde         |
    | plaats.code         | <code>         |
    | plaats.omschrijving | <omschrijving> |

    Voorbeelden:
    | field                        | code | omschrijving  |
    | geboorte.plaats              | 0518 | 's-Gravenhage |
    | geboorte.plaats.code         | 0518 |               |
    | geboorte.plaats.omschrijving |      | 's-Gravenhage |

  Abstract Scenario: persoon heeft 'geboorte' veld: 'geboorteland (03.30)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                 | waarde |
    | geboorteland (03.30) | 6014   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam              | waarde         |
    | land.code         | <code>         |
    | land.omschrijving | <omschrijving> |

    Voorbeelden:
    | field                      | code | omschrijving                 |
    | geboorte.land              | 6014 | Verenigde Staten van Amerika |
    | geboorte.land.code         | 6014 |                              |
    | geboorte.land.omschrijving |      | Verenigde Staten van Amerika |

  Abstract Scenario: geboorte veld(en) van persoon is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboortedatum (03.10)           | 19630405                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | geboorte.inOnderzoek            |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam                                         | waarde                |
    | inOnderzoek.datum                            | <datum in onderzoek>  |
    | inOnderzoek.plaats                           | <plaats in onderzoek> |
    | inOnderzoek.land                             | <land in onderzoek>   |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                 |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01            |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002           |

    Voorbeelden:
    | gba in onderzoek waarde | datum in onderzoek | plaats in onderzoek | land in onderzoek |
    | 010000                  | true               | true                | true              |
    | 010300                  | true               | true                | true              |
    | 010310                  | true               |                     |                   |
    | 010320                  |                    | true                |                   |
    | 010330                  |                    |                     | true              |

  Abstract Scenario: geboorte datum is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboortedatum (03.10)           | 19630405                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | geboorte.datum                  |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
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
    | 010000                  |
    | 010300                  |
    | 010310                  |

  Abstract Scenario: geboorte plaats is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboorteplaats (03.20)          | 0518                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | geboorte.<field>                |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam                                         | waarde         |
    | plaats.code                                  | <code>         |
    | plaats.omschrijving                          | <omschrijving> |
    | inOnderzoek.plaats                           | true           |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum          |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01     |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002    |

    Voorbeelden:
    | gba in onderzoek waarde | field               | code | omschrijving  |
    | 010000                  | plaats              | 0518 | 's-Gravenhage |
    | 010300                  | plaats.code         | 0518 |               |
    | 010320                  | plaats.omschrijving |      | 's-Gravenhage |

  Abstract Scenario: geboorte land is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboorteland (03.30)            | 6014                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | geboorte.<field>                |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam                                         | waarde         |
    | land.code                                    | <code>         |
    | land.omschrijving                            | <omschrijving> |
    | inOnderzoek.land                             | true           |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum          |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01     |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002    |

    Voorbeelden:
    | gba in onderzoek waarde | field             | code | omschrijving                 |
    | 010000                  | land              | 6014 | Verenigde Staten van Amerika |
    | 010300                  | land.code         | 6014 |                              |
    | 010330                  | land.omschrijving |      | Verenigde Staten van Amerika |
