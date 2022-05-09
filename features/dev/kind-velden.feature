#language: nl

@post-assert
Functionaliteit: Kind

  Abstract Scenario: kind heeft veld: '<gba naam>''
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'kind' met alleen de volgende gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | kinderen                        |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende gegevens
    | naam   | waarde   |
    | type   | Kind     |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam            | naam                | waarde    |
    | burgerservicenummer | burgerservicenummer | 123456789 |

  Abstract Scenario: kind heeft '<gegevensgroep>' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'kind' met alleen de volgende '<gegevensgroep>' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | kinderen                        |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende gegevens
    | naam | waarde |
    | type | Kind   |
    En heeft het 'kind' alleen de volgende '<gegevensgroep>' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gegevensgroep | gba naam                             | naam                                 | waarde                       |
    | naam          | voornamen (02.10)                    | voornamen                            | Piet                         |
    | naam          | voorvoegsel (02.30)                  | voorvoegsel                          | in den                       |
    | naam          | geslachtsnaam (02.40)                | geslachtsnaam                        | Jansen                       |
    | naam          | adellijke titel of predicaat (02.20) | adellijkeTitelPredicaat.code         | JH                           |
    | naam          | adellijkeTitelPredicaat.omschrijving | adellijkeTitelPredicaat.omschrijving | jonkheer                     |
    | geboorte      | geboorteplaats (03.20)               | plaats.code                          | 0518                         |
    | geboorte      | plaats.omschrijving                  | plaats.omschrijving                  | 's-Gravenhage                |
    | geboorte      | geboorteland (03.30)                 | land.code                            | 6014                         |
    | geboorte      | land.omschrijving                    | land.omschrijving                    | Verenigde Staten van Amerika |

  Abstract Scenario: kind heeft '<gegevensgroep>' datum veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'kind' met alleen de volgende '<gegevensgroep>' gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | kinderen                        |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende gegevens
    | naam | waarde |
    | type | Kind   |
    En heeft het 'kind' alleen de volgende '<gegevensgroep>' gegevens
    | naam         | waarde   |
    | <naam>.type  | Datum    |
    | <naam>.datum | <waarde> |

    Voorbeelden:
    | gegevensgroep | gba naam              | gba waarde | naam  | waarde     |
    | geboorte      | geboortedatum (03.10) | 20020701   | datum | 2002-07-01 |

  Abstract Scenario: kind velden is in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'kind' met de volgende gegevens
    | naam                                     | waarde                    |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | kinderen                        |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende gegevens
    | naam                                   | waarde                             |
    | type                                   | Kind                               |
    | inOnderzoek.burgerservicenummer        | <burgerservicenummer in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek.type  | Datum                              |
    | inOnderzoek.datumIngangOnderzoek.datum | 2002-07-01                         |

    Voorbeelden:
    | gba in onderzoek waarde | burgerservicenummer in onderzoek |
    | 090000                  | true                             |
    | 090100                  | true                             |
    | 090120                  | true                             |

  Abstract Scenario: naam velden van kind is/zijn in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'kind' met de volgende gegevens
    | naam                                     | waarde                    |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    En de 'kind' heeft de volgende 'naam' gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Groen  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | kinderen.naam                   |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende gegevens
    | naam | waarde |
    | type | Kind   |
    En heeft de 'kind' alleen de volgende 'naam' gegevens
    | naam                                   | waarde                                 |
    | geslachtsnaam                          | Groen                                  |
    | inOnderzoek.voornamen                  | <voornamen in onderzoek>               |
    | inOnderzoek.adellijkeTitelPredicaat    | <adellijkeTitelPredicaat in onderzoek> |
    | inOnderzoek.voorvoegsel                | <voorvoegsel in onderzoek>             |
    | inOnderzoek.geslachtsnaam              | <geslachtsnaam in onderzoek>           |
    | inOnderzoek.voorletters                | <voorletters in onderzoek>             |
    | inOnderzoek.datumIngangOnderzoek.type  | Datum                                  |
    | inOnderzoek.datumIngangOnderzoek.datum | 2002-07-01                             |

    Voorbeelden:
    | gba in onderzoek waarde | voornamen in onderzoek | adellijkeTitelPredicaat in onderzoek | voorvoegsel in onderzoek | geslachtsnaam in onderzoek | voorletters in onderzoek |
    | 090000                  | true                   | true                                 | true                     | true                       | true                     |
    | 090200                  | true                   | true                                 | true                     | true                       | true                     |
    | 090210                  | true                   |                                      |                          |                            | true                     |
    | 090220                  |                        | true                                 |                          |                            |                          |
    | 090230                  |                        |                                      | true                     |                            |                          |
    | 090240                  |                        |                                      |                          | true                       |                          |

    Abstract Scenario: 'geboorte' velden van kind is/zijn in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'kind' met de volgende gegevens
    | naam                                     | waarde                    |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    En de 'kind' heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19630405 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | kinderen.geboorte               |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende gegevens
    | naam | waarde |
    | type | Kind   |
    En heeft de 'kind' alleen de volgende 'geboorte' gegevens
    | naam                                   | waarde                |
    | datum.type                             | Datum                 |
    | datum.datum                            | 1963-04-05            |
    | inOnderzoek.datum                      | <datum in onderzoek>  |
    | inOnderzoek.plaats                     | <plaats in onderzoek> |
    | inOnderzoek.land                       | <land in onderzoek>   |
    | inOnderzoek.datumIngangOnderzoek.type  | Datum                 |
    | inOnderzoek.datumIngangOnderzoek.datum | 2002-07-01            |

    Voorbeelden:
    | gba in onderzoek waarde | datum in onderzoek | plaats in onderzoek | land in onderzoek |
    | 090000                  | true               | true                | true              |
    | 090300                  | true               | true                | true              |
    | 090310                  | true               |                     |                   |
    | 090320                  |                    | true                |                   |
    | 090330                  |                    |                     | true              |
