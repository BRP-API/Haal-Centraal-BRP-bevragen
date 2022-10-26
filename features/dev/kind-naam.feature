#language: nl

Functionaliteit: Persoon: kind - naam

  Abstract Scenario: kind heeft 'naam' veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.naam.<naam>            |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'naam' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam              | naam          | waarde |
    | voornamen (02.10)     | voornamen     | Piet   |
    | voorvoegsel (02.30)   | voorvoegsel   | in den |
    | geslachtsnaam (02.40) | geslachtsnaam | Jansen |

  Scenario: kind heeft 'naam' veld: 'adellijke titel of predicaat (02.20)'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                                 | waarde |
    | adellijke titel of predicaat (02.20) | JH     |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                |
    | type                | RaadpleegMetBurgerservicenummer       |
    | burgerservicenummer | 000000012                             |
    | fields              | kinderen.naam.adellijkeTitelPredicaat |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'naam' gegevens
    | naam                                 | waarde    |
    | adellijkeTitelPredicaat.code         | JH        |
    | adellijkeTitelPredicaat.omschrijving | Jonkheer  |
    | adellijkeTitelPredicaat.soort        | predicaat |

  Scenario: kind heeft 'naam' veld: 'voorletters'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam              | waarde    |
    | voornamen (02.10) | Peter Jan |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.naam.voorletters       |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'naam' gegevens
    | naam        | waarde |
    | voorletters | P.J.   |

  Abstract Scenario: kind heeft 'naam' veld met onbekend waarde: 'geslachtsnaam (02.40)'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | .      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met een 'kind' met een leeg 'naam' object

    Voorbeelden:
    | field                       |
    | kinderen                    |
    | kinderen.naam               |
    | kinderen.naam.geslachtsnaam |

  Abstract Scenario: naam velden van kind is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.naam.inOnderzoek                   |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde                                 |
    | inOnderzoek.voornamen                        | <voornamen in onderzoek>               |
    | inOnderzoek.adellijkeTitelPredicaat          | <adellijkeTitelPredicaat in onderzoek> |
    | inOnderzoek.voorvoegsel                      | <voorvoegsel in onderzoek>             |
    | inOnderzoek.geslachtsnaam                    | <geslachtsnaam in onderzoek>           |
    | inOnderzoek.voorletters                      | <voorletters in onderzoek>             |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                                  |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                             |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                            |

    Voorbeelden:
    | gba in onderzoek waarde | voornamen in onderzoek | adellijkeTitelPredicaat in onderzoek | voorvoegsel in onderzoek | geslachtsnaam in onderzoek | voorletters in onderzoek |
    | 090000                  | true                   | true                                 | true                     | true                       | true                     |
    | 090200                  | true                   | true                                 | true                     | true                       | true                     |
    | 090210                  | true                   |                                      |                          |                            | true                     |
    | 090220                  |                        | true                                 |                          |                            |                          |
    | 090230                  |                        |                                      | true                     |                            |                          |
    | 090240                  |                        |                                      |                          | true                       |                          |

  Abstract Scenario: 'voornamen (02.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voornamen (02.10)               | Jan                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.naam.voornamen         |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | voornamen                                    | Jan         |
    | inOnderzoek.voornamen                        | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 090000                  |
    | 090200                  |
    | 090210                  |

  Abstract Scenario: voorletters is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voornamen (02.10)               | Jan Peter                 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.naam.voorletters       |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | voorletters                                  | J.P.        |
    | inOnderzoek.voorletters                      | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 090000                  |
    | 090200                  |
    | 090210                  |

  Abstract Scenario: 'voorvoegsel (02.30)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voorvoegsel (02.30)             | van de                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.naam.voorvoegsel       |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | voorvoegsel                                  | van de      |
    | inOnderzoek.voorvoegsel                      | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 090000                  |
    | 090200                  |
    | 090230                  |

  Abstract Scenario: 'geslachtsnaam (02.40)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geslachtsnaam (02.40)           | Jansen                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.naam.geslachtsnaam     |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | geslachtsnaam                                | Jansen      |
    | inOnderzoek.geslachtsnaam                    | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 090000                  |
    | 090200                  |
    | 090240                  |

  Abstract Scenario: 'adellijke titel of predicaat (02.20)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                                 | waarde                    |
    | aanduiding in onderzoek (83.10)      | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)       | 20020701                  |
    | adellijke titel of predicaat (02.20) | P                         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                |
    | type                | RaadpleegMetBurgerservicenummer       |
    | burgerservicenummer | 000000012                             |
    | fields              | kinderen.naam.adellijkeTitelPredicaat |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | adellijkeTitelPredicaat.code                 | P           |
    | adellijkeTitelPredicaat.omschrijving         | Prins       |
    | adellijkeTitelPredicaat.soort                | titel       |
    | inOnderzoek.adellijkeTitelPredicaat          | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 090000                  |
    | 090200                  |
    | 090220                  |

  Abstract Scenario: 'voornamen (02.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voornamen (02.10)               | Jan                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.naam.voorvoegsel       |
    Dan heeft de response een persoon met een 'kind' zonder 'naam' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 090210                  |

  Abstract Scenario: 'voorvoegsel (02.30)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voorvoegsel (02.30)             | van de                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.naam.geslachtsnaam     |
    Dan heeft de response een persoon met een 'kind' zonder 'naam' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 090230                  |

  Abstract Scenario: 'geslachtsnaam (02.40)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geslachtsnaam (02.40)           | Jansen                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                |
    | type                | RaadpleegMetBurgerservicenummer       |
    | burgerservicenummer | 000000012                             |
    | fields              | kinderen.naam.adellijkeTitelPredicaat |
    Dan heeft de response een persoon met een 'kind' zonder 'naam' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 090240                  |

  Abstract Scenario: 'adellijke titel of predicaat (02.20)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                                 | waarde                    |
    | aanduiding in onderzoek (83.10)      | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)       | 20020701                  |
    | adellijke titel of predicaat (02.20) | P                         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.naam.voornamen         |
    Dan heeft de response een persoon met een 'kind' zonder 'naam' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 090220                  |
