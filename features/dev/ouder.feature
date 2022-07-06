# language: nl

@post-assert
Functionaliteit: Ouder

  Abstract Scenario: ouder heeft veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'ouder' met alleen de volgende gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | ouders                          |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                    | naam                | waarde    |
    | burgerservicenummer         | burgerservicenummer | 123456789 |
    | geslachtsaanduiding (04.10) | geslacht.code       | M         |
    | ouderAanduiding             | ouderAanduiding     | 1         |

  Abstract Scenario: ouder heeft '<gegevensgroep>' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'ouder' met alleen de volgende '<gegevensgroep>' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | ouders.<gegevensgroep>.<naam>   |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende '<gegevensgroep>' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gegevensgroep | gba naam                             | naam                                 | waarde                       |
    | naam          | voornamen (02.10)                    | voornamen                            | Jan                          |
    | naam          | voorvoegsel (02.30)                  | voorvoegsel                          | de                           |
    | naam          | geslachtsnaam (02.40)                | geslachtsnaam                        | Groen                        |
    | naam          | adellijke titel of predicaat (02.20) | adellijkeTitelPredicaat.code         | JH                           |
    | naam          | adellijkeTitelPredicaat.omschrijving | adellijkeTitelPredicaat.omschrijving | ridder                       |
    | geboorte      | geboorteplaats (03.20)               | plaats.code                          | 0518                         |
    | geboorte      | plaats.omschrijving                  | plaats.omschrijving                  | 's-Gravenhage                |
    | geboorte      | geboorteland (03.30)                 | land.code                            | 6014                         |
    | geboorte      | land.omschrijving                    | land.omschrijving                    | Verenigde Staten van Amerika |

  Abstract Scenario: ouder heeft 'naam' veld: 'voorletters'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'ouder' met alleen de volgende 'naam' gegevens
    | naam              | waarde         |
    | voornamen (02.10) | Angelina Jolie |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | ouders.naam.voorletters         |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'naam' gegevens
    | naam        | waarde |
    | voorletters | A.J.   |

  Abstract Scenario: ouder heeft '<gegevensgroep>' veld met onbekend waarde: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'ouder' met alleen de volgende '<gegevensgroep>' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | ouders.<gegevensgroep>          |
    Dan heeft de response een persoon met een 'ouder' met een leeg 'naam' object

    Voorbeelden:
    | gegevensgroep | gba naam              | naam          | waarde |
    | naam          | geslachtsnaam (02.40) | geslachtsnaam | .      |

  Abstract Scenario: ouder heeft datum veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'ouder' met alleen de volgende gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | ouders                          |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam               | waarde         |
    | <naam>.type        | Datum          |
    | <naam>.datum       | <waarde>       |
    | <naam>.langFormaat | <lang formaat> |

    Voorbeelden:
    | gba naam                                           | gba waarde | naam                                    | waarde     | lang formaat |
    | datum ingang familierechtelijke betrekking (62.10) | 20020701   | datumIngangFamilierechtelijkeBetrekking | 2002-07-01 | 1 juli 2002  |

  Abstract Scenario: ouder heeft '<gegevensgroep>' datum veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'ouder' met alleen de volgende '<gegevensgroep>' gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | ouders.<gegevensgroep>          |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende '<gegevensgroep>' gegevens
    | naam               | waarde         |
    | <naam>.type        | Datum          |
    | <naam>.datum       | <waarde>       |
    | <naam>.langFormaat | <lang formaat> |

    Voorbeelden:
    | gegevensgroep | gba naam              | gba waarde | naam  | waarde     | lang formaat |
    | geboorte      | geboortedatum (03.10) | 20020701   | datum | 2002-07-01 | 1 juli 2002  |

  Abstract Scenario: ouder <ouder aanduiding> velden is in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'ouder' met alleen de volgende gegevens
    | naam                                     | waarde                    |
    | ouderAanduiding                          | <ouder aanduiding>        |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | ouders                          |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam                                                | waarde                                                    |
    | ouderAanduiding                                     | <ouder aanduiding>                                        |
    | inOnderzoek.burgerservicenummer                     | <burgerservicenummer in onderzoek>                        |
    | inOnderzoek.geslacht                                | <geslacht in onderzoek>                                   |
    | inOnderzoek.datumIngangFamilierechtelijkeBetrekking | <datum ingang familierechtelijke betrekking in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek.type               | Datum                                                     |
    | inOnderzoek.datumIngangOnderzoek.datum              | 2002-07-01                                                |
    | inOnderzoek.datumIngangOnderzoek.langFormaat        | 1 juli 2002                                               |

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde | burgerservicenummer in onderzoek | geslacht in onderzoek | datum ingang familierechtelijke betrekking in onderzoek |
    | 1                | 020000                  | true                             | true                  | true                                                    |
    | 1                | 020100                  | true                             |                       |                                                         |
    | 1                | 020120                  | true                             |                       |                                                         |
    | 1                | 020400                  |                                  | true                  |                                                         |
    | 1                | 020410                  |                                  | true                  |                                                         |
    | 1                | 026200                  |                                  |                       | true                                                    |
    | 1                | 026210                  |                                  |                       | true                                                    |
    | 2                | 030000                  | true                             | true                  | true                                                    |
    | 2                | 030100                  | true                             |                       |                                                         |
    | 2                | 030120                  | true                             |                       |                                                         |
    | 2                | 030400                  |                                  | true                  |                                                         |
    | 2                | 030410                  |                                  | true                  |                                                         |
    | 2                | 036200                  |                                  |                       | true                                                    |
    | 2                | 036210                  |                                  |                       | true                                                    |

  Abstract Scenario: ouder <ouder aanduiding> naam velden is in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'ouder' met alleen de volgende gegevens
    | naam                                     | waarde                    |
    | ouderAanduiding                          | <ouder aanduiding>        |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    En de 'ouder' heeft de volgende 'naam' gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Groen  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | ouders.naam                     |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde                                      |
    | geslachtsnaam                                | Groen                                       |
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

  Abstract Scenario: ouder <ouder aanduiding> geboorte velden is in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'ouder' met alleen de volgende gegevens
    | naam                                     | waarde                    |
    | ouderAanduiding                          | <ouder aanduiding>        |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    En de 'ouder' heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19630405 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | ouders.geboorte                 |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'geboorte' gegevens
    | naam                                         | waarde                |
    | datum.type                                   | Datum                 |
    | datum.datum                                  | 1963-04-05            |
    | datum.langFormaat                            | 5 april 1963          |
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
