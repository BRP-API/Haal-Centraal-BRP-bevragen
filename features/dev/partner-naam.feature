# language: nl

Functionaliteit: Persoon: partner - naam

  Abstract Scenario: partner heeft 'naam' veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.naam.<naam>            |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'naam' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam              | naam          | waarde |
    | voornamen (02.10)     | voornamen     | Jan    |
    | voorvoegsel (02.30)   | voorvoegsel   | de     |
    | geslachtsnaam (02.40) | geslachtsnaam | Groen  |

  Scenario: partner heeft 'naam' veld: 'adellijke titel of predicaat (02.20)'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                 | waarde |
    | adellijke titel of predicaat (02.20) | R      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                |
    | type                | RaadpleegMetBurgerservicenummer       |
    | burgerservicenummer | 000000012                             |
    | fields              | partners.naam.adellijkeTitelPredicaat |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'naam' gegevens
    | naam                                 | waarde |
    | adellijkeTitelPredicaat.code         | R      |
    | adellijkeTitelPredicaat.omschrijving | Ridder |
    | adellijkeTitelPredicaat.soort        | titel  |

  Scenario: partner heeft 'naam' veld: 'voorletters'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam              | waarde    |
    | voornamen (02.10) | Klaas Jan |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.naam.voorletters       |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'naam' gegevens
    | naam        | waarde |
    | voorletters | K.J.   |

  Abstract Scenario: partner heeft 'naam' veld met onbekend waarde: 'geslachtsnaam (02.40)'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | .      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met een 'partner' zonder 'naam' gegevens

    Voorbeelden:
    | field                       |
    | partners                    |
    | partners.naam               |
    | partners.naam.geslachtsnaam |

  Abstract Scenario: naam veld(en) van partner is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.naam.inOnderzoek       |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'naam' gegevens
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
    | 050000                  | true                   | true                                 | true                     | true                       | true                     |
    | 050200                  | true                   | true                                 | true                     | true                       | true                     |
    | 050210                  | true                   |                                      |                          |                            | true                     |
    | 050220                  |                        | true                                 |                          |                            |                          |
    | 050230                  |                        |                                      | true                     |                            |                          |
    | 050240                  |                        |                                      |                          | true                       |                          |

  Abstract Scenario: 'voornamen (02.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voornamen (02.10)               | Jan                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.naam.voornamen         |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | voornamen                                    | Jan         |
    | inOnderzoek.voornamen                        | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050000                  |
    | 050200                  |
    | 050210                  |

  Abstract Scenario: voorletters is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voornamen (02.10)               | Jan Peter                 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.naam.voorletters       |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | voorletters                                  | J.P.        |
    | inOnderzoek.voorletters                      | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050000                  |
    | 050200                  |
    | 050210                  |

  Abstract Scenario: 'voorvoegsel (02.30)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voorvoegsel (02.30)             | van de                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.naam.voorvoegsel       |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | voorvoegsel                                  | van de      |
    | inOnderzoek.voorvoegsel                      | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050000                  |
    | 050200                  |
    | 050230                  |

  Abstract Scenario: 'geslachtsnaam (02.40)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geslachtsnaam (02.40)           | Jansen                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.naam.geslachtsnaam     |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | geslachtsnaam                                | Jansen      |
    | inOnderzoek.geslachtsnaam                    | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050000                  |
    | 050200                  |
    | 050240                  |

  Abstract Scenario: 'adellijke titel of predicaat (02.20)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                 | waarde                    |
    | aanduiding in onderzoek (83.10)      | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)       | 20020701                  |
    | adellijke titel of predicaat (02.20) | P                         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                |
    | type                | RaadpleegMetBurgerservicenummer       |
    | burgerservicenummer | 000000012                             |
    | fields              | partners.naam.adellijkeTitelPredicaat |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'naam' gegevens
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
    | 050000                  |
    | 050200                  |
    | 050220                  |

  Abstract Scenario: 'voornamen (02.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voornamen (02.10)               | Jan                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.naam.voorvoegsel       |
    Dan heeft de response een persoon met een 'partner' zonder 'naam' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050210                  |

  Abstract Scenario: 'voorvoegsel (02.30)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voorvoegsel (02.30)             | van de                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.naam.geslachtsnaam     |
    Dan heeft de response een persoon met een 'partner' zonder 'naam' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050230                  |

  Abstract Scenario: 'geslachtsnaam (02.40)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geslachtsnaam (02.40)           | Jansen                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                |
    | type                | RaadpleegMetBurgerservicenummer       |
    | burgerservicenummer | 000000012                             |
    | fields              | partners.naam.adellijkeTitelPredicaat |
    Dan heeft de response een persoon met een 'partner' zonder 'naam' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050240                  |

  Abstract Scenario: 'adellijke titel of predicaat (02.20)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                 | waarde                    |
    | aanduiding in onderzoek (83.10)      | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)       | 20020701                  |
    | adellijke titel of predicaat (02.20) | P                         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.naam.voornamen         |
    Dan heeft de response een persoon met een 'partner' zonder 'naam' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050220                  |
