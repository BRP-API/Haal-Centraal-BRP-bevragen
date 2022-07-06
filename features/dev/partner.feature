# language: nl

@post-assert
Functionaliteit: Partner

  Abstract Scenario: partner heeft veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'partner' met alleen de volgende gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | partners                        |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                      | naam                          | waarde                     |
    | burgerservicenummer           | burgerservicenummer           | 123456789                  |
    | geslachtsaanduiding (04.10)   | geslacht.code                 | O                          |
    | soort verbintenis (15.10)     | soortVerbintenis.code         | H                          |
    | soortVerbintenis.omschrijving | soortVerbintenis.omschrijving | Geregistreerd partnerschap |

  Abstract Scenario: partner heeft '<gegevensgroep>' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'partner' met alleen de volgende '<gegevensgroep>' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | partners.<gegevensgroep>.<naam> |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende '<gegevensgroep>' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gegevensgroep               | gba naam                                                            | naam                                 | waarde                       |
    | naam                        | voornamen (02.10)                                                   | voornamen                            | Jan                          |
    | naam                        | voorvoegsel (02.30)                                                 | voorvoegsel                          | de                           |
    | naam                        | geslachtsnaam (02.40)                                               | geslachtsnaam                        | Groen                        |
    | naam                        | adellijke titel of predicaat (02.20)                                | adellijkeTitelPredicaat.code         | JH                           |
    | naam                        | adellijkeTitelPredicaat.omschrijving                                | adellijkeTitelPredicaat.omschrijving | ridder                       |
    | geboorte                    | geboorteplaats (03.20)                                              | plaats.code                          | 0518                         |
    | geboorte                    | plaats.omschrijving                                                 | plaats.omschrijving                  | 's-Gravenhage                |
    | geboorte                    | geboorteland (03.30)                                                | land.code                            | 6014                         |
    | geboorte                    | land.omschrijving                                                   | land.omschrijving                    | Verenigde Staten van Amerika |
    | aangaanHuwelijkPartnerschap | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | plaats.code                          | 0599                         |
    | aangaanHuwelijkPartnerschap | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)   | land.code                            | 6014                         |

  Scenario: partner heeft 'naam' veld: 'voorletters'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'partner' met alleen de volgende 'naam' gegevens
    | naam              | waarde    |
    | voornamen (02.10) | Klaas Jan |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | partners.naam.voorletters       |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'naam' gegevens
    | naam        | waarde |
    | voorletters | K.J.   |

  Abstract Scenario: partner heeft '<gegevensgroep>' veld met onbekend waarde: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'partner' met alleen de volgende '<gegevensgroep>' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | partners.<gegevensgroep>        |
    Dan heeft de response een persoon met een 'partner' met een leeg 'naam' object

    Voorbeelden:
    | gegevensgroep | gba naam              | naam          | waarde |
    | naam          | geslachtsnaam (02.40) | geslachtsnaam | .      |

  Abstract Scenario: partner heeft '<gegevensgroep>' datum veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'partner' met alleen de volgende '<gegevensgroep>' gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | partners.<gegevensgroep>        |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende '<gegevensgroep>' gegevens
    | naam               | waarde         |
    | <naam>.type        | Datum          |
    | <naam>.datum       | <waarde>       |
    | <naam>.langFormaat | <lang formaat> |

    Voorbeelden:
    | gegevensgroep                  | gba naam                                                           | gba waarde | naam  | waarde     | lang formaat    |
    | geboorte                       | geboortedatum (03.10)                                              | 20020701   | datum | 2002-07-01 | 1 juli 2002     |
    | aangaanHuwelijkPartnerschap    | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 20180808   | datum | 2018-08-08 | 8 augustus 2018 |
    | ontbindingHuwelijkPartnerschap | datum ontbinding huwelijk/geregistreerd partnerschap (07.10)       | 20201001   | datum | 2020-10-01 | 1 oktober 2020  |

  Abstract Scenario: veld(en) van partner is/zijn in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'partner' met de volgende gegevens
    | naam                                     | waarde                    |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | partners                        |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                                         | waarde                             |
    | inOnderzoek.burgerservicenummer              | <burgerservicenummer in onderzoek> |
    | inOnderzoek.soortVerbintenis                 | <soort verbintenis in onderzoek>   |
    | inOnderzoek.geslacht                         | <geslacht in onderzoek>            |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                              |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                         |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                        |

    Voorbeelden:
    | gba in onderzoek waarde | burgerservicenummer in onderzoek | soort verbintenis in onderzoek | geslacht in onderzoek |
    | 050000                  | true                             | true                           | true                  |
    | 050100                  | true                             |                                |                       |
    | 050120                  | true                             |                                |                       |
    | 050400                  |                                  |                                | true                  |
    | 050410                  |                                  |                                | true                  |
    | 051500                  |                                  | true                           |                       |
    | 051510                  |                                  | true                           |                       |

  Abstract Scenario: naam veld(en) van partner is/zijn in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'partner' met de volgende gegevens
    | naam                                     | waarde                    |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    En de 'partner' heeft de volgende 'naam' gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Groen  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | partners.naam                   |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde                                 |
    | geslachtsnaam                                | Groen                                  |
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

    Abstract Scenario: geboorte veld(en) van partner is/zijn in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'partner' met de volgende gegevens
    | naam                                     | waarde                    |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    En de 'partner' heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19630405 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | partners.geboorte               |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'geboorte' gegevens
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
    | gba in onderzoek waarde | datum in onderzoek | plaats in onderzoek | land in onderzoek |
    | 050000                  | true               | true                | true              |
    | 050300                  | true               | true                | true              |
    | 050310                  | true               |                     |                   |
    | 050320                  |                    | true                |                   |
    | 050330                  |                    |                     | true              |

    Abstract Scenario: partner's huwelijkssluiting/aangaan geregistreerd partnerschap velden is in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'partner' met de volgende gegevens
    | naam                                     | waarde                    |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    En de 'partner' heeft de volgende 'aangaanHuwelijkPartnerschap' gegevens
    | naam                                                               | waarde   |
    | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19630405 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 555550001                            |
    | fields              | partners.aangaanHuwelijkPartnerschap |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'aangaanHuwelijkPartnerschap' gegevens
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
    | gba in onderzoek waarde | datum in onderzoek | plaats in onderzoek | land in onderzoek |
    | 050000                  | true               | true                | true              |
    | 050600                  | true               | true                | true              |
    | 050610                  | true               |                     |                   |
    | 050620                  |                    | true                |                   |
    | 050630                  |                    |                     | true              |

    # Scenario: alleen geslachtsnaam is gevuld en bevat standaardwaarde
    #   Gegeven het systeem heeft een persoon met de volgende gegevens
    #   | naam                | waarde    |
    #   | burgerservicenummer | 555550001 |
    #   En de persoon heeft een 'partner' met de volgende 'naam' gegevens
    #   | naam                  | waarde |
    #   | geslachtsnaam (02.40) | .      |
    #   Als personen wordt gezocht met de volgende parameters
    #   | naam                | waarde                          |
    #   | type                | RaadpleegMetBurgerservicenummer |
    #   | burgerservicenummer | 555550001                       |
    #   | fields              | partners                        |
    #   Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    #   | naam              | waarde          |
    #   | type              | PartnerOnbekend |
    #   | indicatieOnbekend | true            |

    # Abstract Scenario: alleen geboorte is gevuld en bevat alleen standaardwaarde
    #   Gegeven het systeem heeft een persoon met de volgende gegevens
    #   | naam                | waarde    |
    #   | burgerservicenummer | 555550001 |
    #   En de persoon heeft een 'partner' met de volgende 'geboorte' gegevens
    #   | naam                   | waarde   |
    #   | geboortedatum (03.10)  | <datum>  |
    #   | geboorteplaats (03.20) | <plaats> |
    #   | geboorteland (03.30)   | <land>   |
    #   Als personen wordt gezocht met de volgende parameters
    #   | naam                | waarde                          |
    #   | type                | RaadpleegMetBurgerservicenummer |
    #   | burgerservicenummer | 555550001                       |
    #   | fields              | partners                        |
    #   Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    #   | naam              | waarde          |
    #   | type              | PartnerOnbekend |
    #   | indicatieOnbekend | true            |

    #   Voorbeelden:
    #     | datum    | plaats | land |
    #     | 00000000 |        |      |
    #     |          | 0000   |      |
    #     |          |        | 0000 |
    #     | 00000000 | 0000   |      |
    #     | 00000000 |        | 0000 |
    #     |          | 0000   | 0000 |
    #     | 00000000 | 0000   | 0000 |
      
    # Scenario: alleen verbintenis is gevuld en bevat standaardwaarde
    #   Gegeven het systeem heeft een persoon met de volgende gegevens
    #   | naam                | waarde    |
    #   | burgerservicenummer | 555550001 |
    #   En de persoon heeft een 'partner' met de volgende gegevens
    #   | naam                      | waarde |
    #   | soort verbintenis (15.10) | .      |
    #   Als personen wordt gezocht met de volgende parameters
    #   | naam                | waarde                          |
    #   | type                | RaadpleegMetBurgerservicenummer |
    #   | burgerservicenummer | 555550001                       |
    #   | fields              | partners                        |
    #   Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    #   | naam              | waarde          |
    #   | type              | PartnerOnbekend |
    #   | indicatieOnbekend | true            |

    # Abstract Scenario: alleen aangaan huwelijk partnerschap is gevuld en bevat alleen standaardwaarde
    #   Gegeven het systeem heeft een persoon met de volgende gegevens
    #   | naam                | waarde    |
    #   | burgerservicenummer | 555550001 |
    #   En de persoon heeft een 'partner' met de volgende 'aangaanHuwelijkPartnerschap' gegevens
    #   | naam                                                                | waarde   |
    #   | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)  | <datum>  |
    #   | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | <plaats> |
    #   | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)   | <land>   |
    #   Als personen wordt gezocht met de volgende parameters
    #   | naam                | waarde                          |
    #   | type                | RaadpleegMetBurgerservicenummer |
    #   | burgerservicenummer | 555550001                       |
    #   | fields              | partners                        |
    #   Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    #   | naam              | waarde          |
    #   | type              | PartnerOnbekend |
    #   | indicatieOnbekend | true            |

    #   Voorbeelden:
    #     | datum    | plaats | land |
    #     | 00000000 |        |      |
    #     |          | 0000   |      |
    #     |          |        | 0000 |
    #     | 00000000 | 0000   |      |
    #     | 00000000 |        | 0000 |
    #     |          | 0000   | 0000 |
    #     | 00000000 | 0000   | 0000 |

    # Scenario: alleen velden die een standaardwaarde kunnen bevatten zijn gevuld met hun standaardwaarde
    #   Gegeven het systeem heeft een persoon met de volgende gegevens
    #   | naam                | waarde    |
    #   | burgerservicenummer | 555550001 |
    #   En de persoon heeft een 'partner' met de volgende gegevens
    #   | naam                      | waarde |
    #   | soort verbintenis (15.10) | .      |
    #   En de 'partner' heeft de volgende 'naam' gegevens
    #   | naam                  | waarde |
    #   | geslachtsnaam (02.40) | .      |
    #   En de 'partner' heeft de volgende 'geboorte' gegevens
    #   | naam                   | waarde   |
    #   | geboortedatum (03.10)  | 00000000 |
    #   | geboorteplaats (03.20) | 0000     |
    #   | geboorteland (03.30)   | 0000     |
    #   En de 'partner' heeft de volgende 'aangaanHuwelijkPartnerschap' gegevens
    #   | naam                                                                | waarde   |
    #   | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)  | 00000000 |
    #   | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | 0000     |
    #   | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)   | 0000     |
    #   Als personen wordt gezocht met de volgende parameters
    #   | naam                | waarde                          |
    #   | type                | RaadpleegMetBurgerservicenummer |
    #   | burgerservicenummer | 555550001                       |
    #   | fields              | partners                        |
    #   Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    #   | naam              | waarde          |
    #   | type              | PartnerOnbekend |
    #   | indicatieOnbekend | true            |

    # Abstract Scenario: alleen in onderzoek is gevuld
    #   Gegeven het systeem heeft een persoon met de volgende gegevens
    #   | naam                | waarde    |
    #   | burgerservicenummer | 555550001 |
    #   En de persoon heeft een 'partner' met de volgende gegevens
    #   | naam                                     | waarde            |
    #   | aanduiding gegevens in onderzoek (83.10) | <onderzoek>       |
    #   | datum ingang onderzoek (83.20)           | <datum onderzoek> |
    #   Als personen wordt gezocht met de volgende parameters
    #   | naam                | waarde                          |
    #   | type                | RaadpleegMetBurgerservicenummer |
    #   | burgerservicenummer | 555550001                       |
    #   | fields              | partners                        |
    #   Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    #   | naam              | waarde          |
    #   | type              | PartnerOnbekend |
    #   | indicatieOnbekend | true            |

    #   Voorbeelden:
    #   | onderzoek | datum onderzoek |
    #   | 050000    | 20220311        |
    #   | 050200    | 20220311        |
      