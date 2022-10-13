#language: nl

Functionaliteit: Naam velden van persoon

  Abstract Scenario: persoon heeft 'naam' veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.<naam>                     |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam              | naam          | waarde        |
    | voornamen (02.10)     | voornamen     | voornamen     |
    | voorvoegsel (02.30)   | voorvoegsel   | van de        |
    | geslachtsnaam (02.40) | geslachtsnaam | geslachtsnaam |

  Abstract Scenario: persoon heeft 'naam' veld: 'adellijke titel of predicaat (02.20)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                                 | waarde |
    | adellijke titel of predicaat (02.20) | JH     |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                 | waarde         |
    | adellijkeTitelPredicaat.code         | <code>         |
    | adellijkeTitelPredicaat.omschrijving | <omschrijving> |
    | adellijkeTitelPredicaat.soort        | <soort>        |

    Voorbeelden:
    | field                                     | code | omschrijving | soort     |
    | naam.adellijkeTitelPredicaat              | JH   | Jonkheer     | predicaat |
    | naam.adellijkeTitelPredicaat.code         | JH   |              |           |
    | naam.adellijkeTitelPredicaat.omschrijving |      | Jonkheer     |           |
    | naam.adellijkeTitelPredicaat.soort        |      |              | predicaat |

  Abstract Scenario: persoon heeft 'naam' veld: 'aanduiding naamgebruik (61.10)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                           | waarde |
    | aanduiding naamgebruik (61.10) | E      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                               | waarde         |
    | aanduidingNaamgebruik.code         | <code>         |
    | aanduidingNaamgebruik.omschrijving | <omschrijving> |

    Voorbeelden:
    | field                                   | code | omschrijving                  |
    | naam.aanduidingNaamgebruik              | E    | gebruik alleen de eigen naam. |
    | naam.aanduidingNaamgebruik.code         | E    |                               |
    | naam.aanduidingNaamgebruik.omschrijving |      | gebruik alleen de eigen naam. |

  Abstract Scenario: naam veld(en) van persoon is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geslachtsnaam (02.40)           | Groen                     |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.inOnderzoek                |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                         | waarde                                      |
    | inOnderzoek.voornamen                        | <voornamen in onderzoek>                    |
    | inOnderzoek.adellijkeTitelPredicaat          | <adellijke titel of predicaat in onderzoek> |
    | inOnderzoek.voorvoegsel                      | <voorvoegsel in onderzoek>                  |
    | inOnderzoek.geslachtsnaam                    | <geslachtsnaam in onderzoek>                |
    | inOnderzoek.aanduidingNaamgebruik            | <aanduiding naamgebruik in onderzoek>       |
    | inOnderzoek.voorletters                      | <voorletters in onderzoek>                  |
    | inOnderzoek.volledigeNaam                    | <volledige naam in onderzoek>               |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                                       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                                  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                                 |

    Voorbeelden:
    | gba in onderzoek waarde | voornamen in onderzoek | adellijke titel of predicaat in onderzoek | voorvoegsel in onderzoek | geslachtsnaam in onderzoek | aanduiding naamgebruik in onderzoek | voorletters in onderzoek | volledige naam in onderzoek |
    | 010000                  | true                   | true                                      | true                     | true                       | true                                | true                     | true                        |
    | 010200                  | true                   | true                                      | true                     | true                       |                                     | true                     | true                        |
    | 010210                  | true                   |                                           |                          |                            |                                     | true                     | true                        |
    | 010220                  |                        | true                                      |                          |                            |                                     |                          | true                        |
    | 010230                  |                        |                                           | true                     |                            |                                     |                          | true                        |
    | 010240                  |                        |                                           |                          | true                       |                                     |                          | true                        |
    | 016100                  |                        |                                           |                          |                            | true                                |                          |                             |
    | 016110                  |                        |                                           |                          |                            | true                                |                          |                             |

  Abstract Scenario: voornamen is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voornamen (02.10)               | Jan                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.voornamen                  |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | voornamen                                    | Jan         |
    | inOnderzoek.voornamen                        | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 010000                  |
    | 010200                  |
    | 010210                  |

  Abstract Scenario: voorvoegsel is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voorvoegsel (02.30)             | van de                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.voorvoegsel                |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | voorvoegsel                                  | van de      |
    | inOnderzoek.voorvoegsel                      | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 010000                  |
    | 010200                  |
    | 010230                  |

  Abstract Scenario: geslachtsnaam is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geslachtsnaam (02.40)           | Jansen                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.geslachtsnaam              |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | geslachtsnaam                                | Jansen      |
    | inOnderzoek.geslachtsnaam                    | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 010000                  |
    | 010200                  |
    | 010240                  |

  Abstract Scenario: adellijke titel of predicaat is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                                 | waarde                    |
    | aanduiding in onderzoek (83.10)      | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)       | 20020701                  |
    | adellijke titel of predicaat (02.20) | JH                        |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.<field>                    |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                         | waarde         |
    | adellijkeTitelPredicaat.code                 | <code>         |
    | adellijkeTitelPredicaat.omschrijving         | <omschrijving> |
    | adellijkeTitelPredicaat.soort                | <soort>        |
    | inOnderzoek.adellijkeTitelPredicaat          | true           |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum          |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01     |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002    |

    Voorbeelden:
    | gba in onderzoek waarde | field                                | code | omschrijving | soort     |
    | 010000                  | adellijkeTitelPredicaat              | JH   | Jonkheer     | predicaat |
    | 010200                  | adellijkeTitelPredicaat.code         | JH   |              |           |
    | 010220                  | adellijkeTitelPredicaat.omschrijving |      | Jonkheer     |           |

  Abstract Scenario: aanduiding naamgebruik is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | aanduiding naamgebruik (61.10)  | V                         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.<field>                    |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                         | waarde         |
    | aanduidingNaamgebruik.code                   | <code>         |
    | aanduidingNaamgebruik.omschrijving           | <omschrijving> |
    | inOnderzoek.aanduidingNaamgebruik            | true           |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum          |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01     |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002    |

    Voorbeelden:
    | gba in onderzoek waarde | field                              | code | omschrijving                               |
    | 010000                  | aanduidingNaamgebruik              | V    | gebruik de partnernaam voor de eigen naam. |
    | 016100                  | aanduidingNaamgebruik.code         | V    |                                            |
    | 016110                  | aanduidingNaamgebruik.omschrijving |      | gebruik de partnernaam voor de eigen naam. |

  Abstract Scenario: voorletters is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voornamen (02.10)               | Jan                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.voorletters                |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | voorletters                                  | J.          |
    | inOnderzoek.voorletters                      | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 010000                  |
    | 010200                  |
    | 010210                  |

  Abstract Scenario: volledige naam is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voornamen (02.10)               | Jan                       |
    | geslachtsnaam (02.40)           | Jansen                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.volledigeNaam              |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | volledigeNaam                                | Jan Jansen  |
    | inOnderzoek.volledigeNaam                    | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 010000                  |
    | 010200                  |
    | 010210                  |
    | 010220                  |
    | 010230                  |
    | 010240                  |

  Abstract Scenario: <in onderzoek veld> is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | <in onderzoek veld>             | <waarde>                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.<field>                    |
    Dan heeft de response een persoon zonder 'naam' gegevens

    Voorbeelden:
    | gba in onderzoek waarde | in onderzoek veld                    | waarde | field         |
    | 010210                  | voornamen (02.10)                    | Jan    | geslachtsnaam |
    | 010220                  | adellijke titel of predicaat (02.20) | B      | geslachtsnaam |
    | 010230                  | voorvoegsel (02.30)                  | van    | geslachtsnaam |
    | 010240                  | geslachtsnaam (02.40)                | Jansen | voornamen     |
    | 016100                  | aanduiding naamgebruik (61.10)       | E      | geslachtsnaam |
    | 016110                  | aanduiding naamgebruik (61.10)       | P      | voornamen     |
