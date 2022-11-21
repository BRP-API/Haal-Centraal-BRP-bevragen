# language: nl

Functionaliteit: Persoon: ouder - naam

  Abstract Scenario: ouder heeft 'naam' veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                    |
    | type                | RaadpleegMetBurgerservicenummer           |
    | burgerservicenummer | 000000012                                 |
    | fields              | ouders.ouderAanduiding,ouders.naam.<naam> |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam            | waarde             |
    | ouderAanduiding | <ouder aanduiding> |
    En heeft de 'ouder' de volgende 'naam' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | ouder aanduiding | gba naam              | naam          | waarde |
    | 1                | voornamen (02.10)     | voornamen     | Jan    |
    | 2                | voorvoegsel (02.30)   | voorvoegsel   | de     |
    | 1                | geslachtsnaam (02.40) | geslachtsnaam | Groen  |

  Abstract Scenario: ouder heeft 'naam' veld: 'adellijke titel of predicaat (02.20)'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                                 | waarde |
    | adellijke titel of predicaat (02.20) | <code> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                    |
    | type                | RaadpleegMetBurgerservicenummer           |
    | burgerservicenummer | 000000012                                 |
    | fields              | ouders.ouderAanduiding,ouders.naam.<naam> |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam            | waarde             |
    | ouderAanduiding | <ouder aanduiding> |
    En heeft de 'ouder' de volgende 'naam' gegevens
    | naam                                 | waarde         |
    | adellijkeTitelPredicaat.code         | <code>         |
    | adellijkeTitelPredicaat.omschrijving | <omschrijving> |
    | adellijkeTitelPredicaat.soort        | <soort>        |

    Voorbeelden:
    | ouder aanduiding | naam                                 | code | omschrijving | soort     |
    | 1                | adellijkeTitelPredicaat.code         | JV   | jonkvrouw    | predicaat |
    | 2                | adellijkeTitelPredicaat.omschrijving | R    | ridder       | titel     |

  Scenario: ouder heeft 'naam' veld: 'voorletters'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
    | naam              | waarde         |
    | voornamen (02.10) | Angelina Jolie |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.naam.voorletters         |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'naam' gegevens
    | naam        | waarde |
    | voorletters | A.J.   |

  Abstract Scenario: ouder heeft 'naam' veld met onbekend waarde: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.naam                     |
    Dan heeft de response een persoon met een 'ouder' met een leeg 'naam' object

    Voorbeelden:
    | gba naam              | naam          | waarde |
    | geslachtsnaam (02.40) | geslachtsnaam | .      |

  Abstract Scenario: ouder <ouder aanduiding> naam velden is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.naam.inOnderzoek         |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde                                      |
    | inOnderzoek.voornamen                        | <voornamen in onderzoek>                    |
    | inOnderzoek.adellijkeTitelPredicaat          | <adellijke titel of predicaat in onderzoek> |
    | inOnderzoek.voorvoegsel                      | <voorvoegsel in onderzoek>                  |
    | inOnderzoek.geslachtsnaam                    | <geslachtsnaam in onderzoek>                |
    | inOnderzoek.voorletters                      | <voorletters in onderzoek>                  |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                                       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                                  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                                 |

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde | voornamen in onderzoek | adellijke titel of predicaat in onderzoek | voorvoegsel in onderzoek | geslachtsnaam in onderzoek | voorletters in onderzoek |
    | 1                | 020000                  | true                   | true                                      | true                     | true                       | true                     |
    | 1                | 020200                  | true                   | true                                      | true                     | true                       | true                     |
    | 1                | 020210                  | true                   |                                           |                          |                            | true                     |
    | 1                | 020220                  |                        | true                                      |                          |                            |                          |
    | 1                | 020230                  |                        |                                           | true                     |                            |                          |
    | 1                | 020240                  |                        |                                           |                          | true                       |                          |
    | 2                | 030000                  | true                   | true                                      | true                     | true                       | true                     |
    | 2                | 030200                  | true                   | true                                      | true                     | true                       | true                     |
    | 2                | 030210                  | true                   |                                           |                          |                            | true                     |
    | 2                | 030220                  |                        | true                                      |                          |                            |                          |
    | 2                | 030230                  |                        |                                           | true                     |                            |                          |
    | 2                | 030240                  |                        |                                           |                          | true                       |                          |

  Abstract Scenario: 'voornamen (02.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voornamen (02.10)               | Jan                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.naam.voornamen           |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | voornamen                                    | Jan         |
    | inOnderzoek.voornamen                        | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde |
    | 1                | 020000                  |
    | 1                | 020200                  |
    | 1                | 020210                  |
    | 2                | 030000                  |
    | 2                | 030200                  |
    | 2                | 030210                  |

  Abstract Scenario: voorletters is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voornamen (02.10)               | Jan Peter                 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.naam.voorletters         |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | voorletters                                  | J.P.        |
    | inOnderzoek.voorletters                      | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde |
    | 1                | 020000                  |
    | 1                | 020200                  |
    | 1                | 020210                  |
    | 2                | 030000                  |
    | 2                | 030200                  |
    | 2                | 030210                  |

  Abstract Scenario: 'voorvoegsel (02.30)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voorvoegsel (02.30)             | van de                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.naam.voorvoegsel         |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | voorvoegsel                                  | van de      |
    | inOnderzoek.voorvoegsel                      | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde |
    | 1                | 020000                  |
    | 1                | 020200                  |
    | 1                | 020230                  |
    | 2                | 030000                  |
    | 2                | 030200                  |
    | 2                | 030230                  |

  Abstract Scenario: 'geslachtsnaam (02.40)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geslachtsnaam (02.40)           | Jansen                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.naam.geslachtsnaam       |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | geslachtsnaam                                | Jansen      |
    | inOnderzoek.geslachtsnaam                    | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde |
    | 1                | 020000                  |
    | 1                | 020200                  |
    | 1                | 020240                  |
    | 2                | 030000                  |
    | 2                | 030200                  |
    | 2                | 030240                  |

  Abstract Scenario: 'adellijke titel of predicaat (02.20)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                                 | waarde                    |
    | aanduiding in onderzoek (83.10)      | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)       | 20020701                  |
    | adellijke titel of predicaat (02.20) | PS                        |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000012                           |
    | fields              | ouders.naam.adellijkeTitelPredicaat |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | adellijkeTitelPredicaat.code                 | PS          |
    | adellijkeTitelPredicaat.omschrijving         | prinses     |
    | adellijkeTitelPredicaat.soort                | titel       |
    | inOnderzoek.adellijkeTitelPredicaat          | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde |
    | 1                | 020000                  |
    | 1                | 020200                  |
    | 1                | 020220                  |
    | 2                | 030000                  |
    | 2                | 030200                  |
    | 2                | 030220                  |

  Abstract Scenario: 'voornamen (02.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voornamen (02.10)               | Jan                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.naam.voorvoegsel         |
    Dan heeft de response een persoon met een 'ouder' zonder 'naam' gegevens

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde |
    | 1                | 020210                  |
    | 2                | 030210                  |

  Abstract Scenario: 'voorvoegsel (02.30)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voorvoegsel (02.30)             | van de                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.naam.geslachtsnaam       |
    Dan heeft de response een persoon met een 'ouder' zonder 'naam' gegevens

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde |
    | 1                | 020230                  |
    | 2                | 030230                  |

  Abstract Scenario: 'geslachtsnaam (02.40)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geslachtsnaam (02.40)           | Jansen                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000012                           |
    | fields              | ouders.naam.adellijkeTitelPredicaat |
    Dan heeft de response een persoon met een 'ouder' zonder 'naam' gegevens

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde |
    | 1                | 020240                  |
    | 2                | 030240                  |

  Abstract Scenario: 'adellijke titel of predicaat (02.20)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                                 | waarde                    |
    | aanduiding in onderzoek (83.10)      | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)       | 20020701                  |
    | adellijke titel of predicaat (02.20) | PS                        |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.naam.voornamen           |
    Dan heeft de response een persoon met een 'ouder' zonder 'naam' gegevens

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde |
    | 1                | 020220                  |
    | 2                | 030220                  |
