# language: nl

Functionaliteit: Partner

  Abstract Scenario: partner heeft veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.<naam>                 |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                    | naam                | gba waarde | waarde    |
    | burgerservicenummer (01.20) | burgerservicenummer | 123456789  | 123456789 |

  Abstract Scenario: partner heeft veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam       | waarde |
    | <gba naam> | <code> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.<naam>                 |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                | waarde         |
    | <naam>.code         | <code>         |
    | <naam>.omschrijving | <omschrijving> |

    Voorbeelden:
    | gba naam                    | naam             | code | omschrijving               |
    | geslachtsaanduiding (04.10) | geslacht         | O    | onbekend                   |
    | soort verbintenis (15.10)   | soortVerbintenis | P    | geregistreerd partnerschap |

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

  Abstract Scenario: partner heeft '<gegevensgroep>' veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam       | waarde |
    | <gba naam> | <code> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.<gegevensgroep>.<naam> |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende '<gegevensgroep>' gegevens
    | naam                | waarde         |
    | <naam>.code         | <code>         |
    | <naam>.omschrijving | <omschrijving> |

    Voorbeelden:
    | gegevensgroep               | gba naam                                                            | naam   | code | omschrijving                 |
    | geboorte                    | geboorteplaats (03.20)                                              | plaats | 0518 | 's-Gravenhage                |
    | geboorte                    | geboorteland (03.30)                                                | land   | 6014 | Verenigde Staten van Amerika |
    | aangaanHuwelijkPartnerschap | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | plaats | 0599 | Rotterdam                    |
    | aangaanHuwelijkPartnerschap | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)   | land   | 6014 | Verenigde Staten van Amerika |

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

  Abstract Scenario: partner heeft 'soort verbintenis (15.10)' veld met onbekend waarde
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                      | waarde |
    | soort verbintenis (15.10) | .      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.soortVerbintenis       |
    Dan heeft de response een persoon met een 'partner' zonder gegevens

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

  Abstract Scenario: partner heeft '<gegevensgroep>' datum veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.<gegevensgroep>.datum  |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende '<gegevensgroep>' gegevens
    | naam              | waarde         |
    | datum.type        | Datum          |
    | datum.datum       | <waarde>       |
    | datum.langFormaat | <lang formaat> |

    Voorbeelden:
    | gegevensgroep                  | gba naam                                                           | gba waarde | waarde     | lang formaat    |
    | geboorte                       | geboortedatum (03.10)                                              | 20020701   | 2002-07-01 | 1 juli 2002     |
    | aangaanHuwelijkPartnerschap    | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 20180808   | 2018-08-08 | 8 augustus 2018 |
    | ontbindingHuwelijkPartnerschap | datum ontbinding huwelijk/geregistreerd partnerschap (07.10)       | 20201001   | 2020-10-01 | 1 oktober 2020  |

  Abstract Scenario: partner heeft 'geboorte' veld met onbekend waarde: 'geboortedatum (03.10)'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 00000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met een 'partner' met de volgende 'geboorte' gegevens
    | naam              | waarde        |
    | datum.type        | DatumOnbekend |
    | datum.onbekend    | true          |
    | datum.langFormaat | onbekend      |

    Voorbeelden:
    | field                   |
    | partners                |
    | partners.geboorte       |
    | partners.geboorte.datum |

  Abstract Scenario: partner heeft 'geboorte' veld met onbekend waarde: 'geboorteplaats (03.20)'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                   | waarde |
    | geboorteplaats (03.20) | 0000   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met een 'partner' zonder 'geboorte' gegevens

    Voorbeelden:
    | field                    |
    | partners                 |
    | partners.geboorte        |
    | partners.geboorte.plaats |

  Abstract Scenario: partner heeft 'geboorte' veld met onbekend waarde: 'geboorteland (03.30)'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                 | waarde |
    | geboorteland (03.30) | 0000   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met een 'partner' zonder 'geboorte' gegevens

    Voorbeelden:
    | field                  |
    | partners               |
    | partners.geboorte      |
    | partners.geboorte.land |

  Abstract Scenario: partner heeft 'datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)' veld met onbekend waarde
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                               | waarde   |
    | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 00000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met een 'partner' met de volgende 'aangaanHuwelijkPartnerschap' gegevens
    | naam              | waarde        |
    | datum.type        | DatumOnbekend |
    | datum.onbekend    | true          |
    | datum.langFormaat | onbekend      |

    Voorbeelden:
    | field                                      |
    | partners                                   |
    | partners.aangaanHuwelijkPartnerschap       |
    | partners.aangaanHuwelijkPartnerschap.datum |

  Abstract Scenario: partner heeft 'plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)' veld met onbekend waarde
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                                | waarde |
    | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | 0000   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met een 'partner' zonder 'aangaanHuwelijkPartnerschap' gegevens

    Voorbeelden:
    | field                                       |
    | partners                                    |
    | partners.aangaanHuwelijkPartnerschap        |
    | partners.aangaanHuwelijkPartnerschap.plaats |

  Abstract Scenario: partner heeft 'land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)' veld met onbekend waarde
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                              | waarde |
    | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30) | 0000   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met een 'partner' zonder 'aangaanHuwelijkPartnerschap' gegevens

    Voorbeelden:
    | field                                     |
    | partners                                  |
    | partners.aangaanHuwelijkPartnerschap      |
    | partners.aangaanHuwelijkPartnerschap.land |

  Abstract Scenario: veld(en) van partner is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.inOnderzoek            |
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

  Abstract Scenario: burgerservicenummer is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | burgerservicenummer (01.20)     | 000000013                 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.burgerservicenummer    |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                                         | waarde      |
    | burgerservicenummer                          | 000000013   |
    | inOnderzoek.burgerservicenummer              | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050000                  |
    | 050100                  |
    | 050120                  |

  Abstract Scenario: soort verbintenis is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | soort verbintenis (15.10)       | H                         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.soortVerbintenis       |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                                         | waarde      |
    | soortVerbintenis.code                        | H           |
    | soortVerbintenis.omschrijving                | huwelijk    |
    | inOnderzoek.burgerservicenummer              | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050000                  |
    | 051500                  |
    | 051510                  |

  Abstract Scenario: geslachtsaanduiding is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geslachtsaanduiding (04.10)     | V                         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.geslacht               |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                                         | waarde      |
    | geslacht.code                                | V           |
    | geslacht.omschrijving                        | vrouw       |
    | inOnderzoek.burgerservicenummer              | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050000                  |
    | 050400                  |
    | 050410                  |

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

  Abstract Scenario: voornamen is in onderzoek
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

  Abstract Scenario: voorvoegsel is in onderzoek
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

  Abstract Scenario: geslachtsnaam is in onderzoek
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

  Abstract Scenario: adellijke titel of predicaat is in onderzoek
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
    | inOnderzoek.geslachtsnaam                    | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050000                  |
    | 050200                  |
    | 050220                  |

  Abstract Scenario: geboorte veld(en) van partner is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.geboorte.inOnderzoek   |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'geboorte' gegevens
    | naam                                         | waarde                |
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

  Abstract Scenario: geboortedatum is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboortedatum (03.10)           | 19630405                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.geboorte.datum         |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'geboorte' gegevens
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
    | 050000                  |
    | 050300                  |
    | 050310                  |

  Abstract Scenario: geboorteplaats is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboorteplaats (03.20)          | 0518                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.geboorte.plaats        |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'geboorte' gegevens
    | naam                                         | waarde        |
    | plaats.code                                  | 0518          |
    | plaats.omschrijving                          | 's-Gravenhage |
    | inOnderzoek.plaats                           | true          |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum         |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01    |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002   |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050000                  |
    | 050300                  |
    | 050320                  |

  Abstract Scenario: geboorteland is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboorteland (03.30)            | 6014                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.geboorte.land          |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'geboorte' gegevens
    | naam                                         | waarde                       |
    | land.code                                    | 6014                         |
    | land.omschrijving                            | Verenigde Staten van Amerika |
    | inOnderzoek.land                             | true                         |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                        |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                   |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                  |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050000                  |
    | 050300                  |
    | 050330                  |

  Abstract Scenario: huwelijkssluiting/aangaan geregistreerd partnerschap velden is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                           |
    | type                | RaadpleegMetBurgerservicenummer                  |
    | burgerservicenummer | 000000012                                        |
    | fields              | partners.aangaanHuwelijkPartnerschap.inOnderzoek |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'aangaanHuwelijkPartnerschap' gegevens
    | naam                                         | waarde                |
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

  Abstract Scenario: datum huwelijkssluiting/aangaan geregistreerd partnerschap is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                               | waarde                    |
    | aanduiding in onderzoek (83.10)                                    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)                                     | 20020701                  |
    | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19630405                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                     |
    | type                | RaadpleegMetBurgerservicenummer            |
    | burgerservicenummer | 000000012                                  |
    | fields              | partners.aangaanHuwelijkPartnerschap.datum |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'aangaanHuwelijkPartnerschap' gegevens
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
    | 050000                  |
    | 050600                  |
    | 050610                  |

  Abstract Scenario: plaats huwelijkssluiting/aangaan geregistreerd partnerschap is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                                | waarde                    |
    | aanduiding in onderzoek (83.10)                                     | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)                                      | 20020701                  |
    | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | 0518                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                      |
    | type                | RaadpleegMetBurgerservicenummer             |
    | burgerservicenummer | 000000012                                   |
    | fields              | partners.aangaanHuwelijkPartnerschap.plaats |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'aangaanHuwelijkPartnerschap' gegevens
    | naam                                         | waarde        |
    | plaats.code                                  | 0518          |
    | plaats.omschrijving                          | 's-Gravenhage |
    | inOnderzoek.plaats                           | true          |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum         |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01    |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002   |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050000                  |
    | 050600                  |
    | 050620                  |

  Abstract Scenario: land huwelijkssluiting/aangaan geregistreerd partnerschap is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                              | waarde                    |
    | aanduiding in onderzoek (83.10)                                   | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)                                    | 20020701                  |
    | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30) | 6014                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                    |
    | type                | RaadpleegMetBurgerservicenummer           |
    | burgerservicenummer | 000000012                                 |
    | fields              | partners.aangaanHuwelijkPartnerschap.land |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'aangaanHuwelijkPartnerschap' gegevens
    | naam                                         | waarde                       |
    | land.code                                    | 6014                         |
    | land.omschrijving                            | Verenigde Staten van Amerika |
    | inOnderzoek.land                             | true                         |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                        |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                   |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                  |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050000                  |
    | 050600                  |
    | 050630                  |
