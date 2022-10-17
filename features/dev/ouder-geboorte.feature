# language: nl

Functionaliteit: Geboorte velden van ouder

  Abstract Scenario: ouder heeft 'geboorte' veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam       | waarde |
    | <gba naam> | <code> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                        |
    | type                | RaadpleegMetBurgerservicenummer               |
    | burgerservicenummer | 000000012                                     |
    | fields              | ouders.ouderAanduiding,ouders.geboorte.<naam> |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam            | waarde             |
    | ouderAanduiding | <ouder aanduiding> |
    En heeft de 'ouder' de volgende 'geboorte' gegevens
    | naam                | waarde         |
    | <naam>.code         | <code>         |
    | <naam>.omschrijving | <omschrijving> |

    Voorbeelden:
    | ouder aanduiding | gba naam               | naam   | code | omschrijving                 |
    | 1                | geboorteplaats (03.20) | plaats | 0518 | 's-Gravenhage                |
    | 2                | geboorteland (03.30)   | land   | 6014 | Verenigde Staten van Amerika |

  Abstract Scenario: ouder heeft 'geboorte' datum veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.geboorte.<naam>          |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'geboorte' gegevens
    | naam               | waarde         |
    | <naam>.type        | Datum          |
    | <naam>.datum       | <waarde>       |
    | <naam>.langFormaat | <lang formaat> |

    Voorbeelden:
    | gba naam              | gba waarde | naam  | waarde     | lang formaat |
    | geboortedatum (03.10) | 20020701   | datum | 2002-07-01 | 1 juli 2002  |

  Abstract Scenario: geboorte veld(en) van ouder <ouder aanduiding> is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.geboorte.inOnderzoek     |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'geboorte' gegevens
    | naam                                         | waarde                |
    | inOnderzoek.datum                            | <datum in onderzoek>  |
    | inOnderzoek.plaats                           | <plaats in onderzoek> |
    | inOnderzoek.land                             | <land in onderzoek>   |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                 |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01            |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002           |

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde | datum in onderzoek | plaats in onderzoek | land in onderzoek |
    | 1                | 020000                  | true               | true                | true              |
    | 1                | 020300                  | true               | true                | true              |
    | 1                | 020310                  | true               |                     |                   |
    | 1                | 020320                  |                    | true                |                   |
    | 1                | 020330                  |                    |                     | true              |
    | 2                | 030000                  | true               | true                | true              |
    | 2                | 030300                  | true               | true                | true              |
    | 2                | 030310                  | true               |                     |                   |
    | 2                | 030320                  |                    | true                |                   |
    | 2                | 030330                  |                    |                     | true              |

  Abstract Scenario: 'geboortedatum (03.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboortedatum (03.10)           | 19630405                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.geboorte.datum           |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'geboorte' gegevens
    | naam                                         | waarde       |
    | datum.type                                   | Datum        |
    | datum.datum                                  | 1963-04-05   |
    | datum.langFormaat                            | 5 april 1963 |
    | inOnderzoek.datum                            | true         |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum        |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01   |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002  |

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde |
    | 1                | 020000                  |
    | 1                | 020300                  |
    | 1                | 020310                  |
    | 2                | 030000                  |
    | 2                | 030300                  |
    | 2                | 030310                  |

  Abstract Scenario: 'geboorteplaats (03.20)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboorteplaats (03.20)          | 0363                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.geboorte.plaats          |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'geboorte' gegevens
    | naam                                         | waarde      |
    | plaats.code                                  | 0363        |
    | plaats.omschrijving                          | Amsterdam   |
    | inOnderzoek.plaats                           | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde |
    | 1                | 020000                  |
    | 1                | 020300                  |
    | 1                | 020320                  |
    | 2                | 030000                  |
    | 2                | 030300                  |
    | 2                | 030320                  |

  Abstract Scenario: 'geboorteland (03.30)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboorteland (03.30)            | 6014                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.geboorte.land            |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'geboorte' gegevens
    | naam                                         | waarde                       |
    | land.code                                    | 6014                         |
    | land.omschrijving                            | Verenigde Staten van Amerika |
    | inOnderzoek.land                             | true                         |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                        |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                   |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                  |

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde |
    | 1                | 020000                  |
    | 1                | 020300                  |
    | 1                | 020330                  |
    | 2                | 030000                  |
    | 2                | 030300                  |
    | 2                | 030330                  |

  Abstract Scenario: 'geboortedatum (03.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboortedatum (03.10)           | 19630405                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.geboorte.plaats          |
    Dan heeft de response een persoon met een 'ouder' zonder 'geboorte' gegevens

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde |
    | 1                | 020310                  |
    | 2                | 030310                  |

  Abstract Scenario: 'geboorteplaats (03.20)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboorteplaats (03.20)          | 0363                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.geboorte.datum           |
    Dan heeft de response een persoon met een 'ouder' zonder 'geboorte' gegevens

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde |
    | 1                | 020320                  |
    | 2                | 030320                  |

  Abstract Scenario: 'geboorteland (03.30)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboorteland (03.30)            | 6014                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.geboorte.plaats          |
    Dan heeft de response een persoon met een 'ouder' zonder 'geboorte' gegevens

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde |
    | 1                | 020330                  |
    | 2                | 030330                  |
