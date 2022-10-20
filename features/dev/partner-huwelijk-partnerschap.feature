# language: nl

Functionaliteit: Persoon: partner - huwelijk/geregistreerd partnerschap

  Abstract Scenario: partner heeft 'aangaanHuwelijkPartnerschap' veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam       | waarde |
    | <gba naam> | <code> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                      |
    | type                | RaadpleegMetBurgerservicenummer             |
    | burgerservicenummer | 000000012                                   |
    | fields              | partners.aangaanHuwelijkPartnerschap.<naam> |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'aangaanHuwelijkPartnerschap' gegevens
    | naam                | waarde         |
    | <naam>.code         | <code>         |
    | <naam>.omschrijving | <omschrijving> |

    Voorbeelden:
    | gba naam                                                            | naam   | code | omschrijving                 |
    | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | plaats | 0599 | Rotterdam                    |
    | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)   | land   | 6014 | Verenigde Staten van Amerika |

  Abstract Scenario: partner heeft 'huwelijkssluiting/aangaan geregistreerd partnerschap' datum veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                     |
    | type                | RaadpleegMetBurgerservicenummer            |
    | burgerservicenummer | 000000012                                  |
    | fields              | partners.aangaanHuwelijkPartnerschap.datum |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'aangaanHuwelijkPartnerschap' gegevens
    | naam              | waarde         |
    | datum.type        | Datum          |
    | datum.datum       | <waarde>       |
    | datum.langFormaat | <lang formaat> |

    Voorbeelden:
    | gba naam                                                           | gba waarde | waarde     | lang formaat    |
    | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 20180808   | 2018-08-08 | 8 augustus 2018 |

  Abstract Scenario: partner heeft 'ontbinding huwelijk/geregistreerd partnerschap' datum veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                        |
    | type                | RaadpleegMetBurgerservicenummer               |
    | burgerservicenummer | 000000012                                     |
    | fields              | partners.ontbindingHuwelijkPartnerschap.datum |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'ontbindingHuwelijkPartnerschap' gegevens
    | naam              | waarde         |
    | datum.type        | Datum          |
    | datum.datum       | <waarde>       |
    | datum.langFormaat | <lang formaat> |

    Voorbeelden:
    | gba naam                                                     | gba waarde | waarde     | lang formaat   |
    | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20201001   | 2020-10-01 | 1 oktober 2020 |

  Abstract Scenario: partner heeft 'huwelijkssluiting/aangaan geregistreerd partnerschap' veld met onbekend waarde: 'datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)'
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

  Abstract Scenario: partner heeft 'huwelijkssluiting/aangaan geregistreerd partnerschap' veld met onbekend waarde: 'plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)'
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

  Abstract Scenario: partner heeft 'huwelijkssluiting/aangaan geregistreerd partnerschap' veld met onbekend waarde: 'land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)'
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

  Abstract Scenario: partner heeft 'ontbinding huwelijkssluiting/geregistreerd partnerschap' veld met onbekend waarde: 'datum ontbinding huwelijkssluiting/geregistreerd partnerschap (07.10)'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                         | waarde   |
    | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 00000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met een 'partner' met de volgende 'ontbindingHuwelijkPartnerschap' gegevens
    | naam              | waarde        |
    | datum.type        | DatumOnbekend |
    | datum.onbekend    | true          |
    | datum.langFormaat | onbekend      |

    Voorbeelden:
    | field                                         |
    | partners                                      |
    | partners.ontbindingHuwelijkPartnerschap       |
    | partners.ontbindingHuwelijkPartnerschap.datum |

  Abstract Scenario: huwelijkssluiting/aangaan geregistreerd partnerschap veld(en) is/zijn in onderzoek
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

  Abstract Scenario: 'datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)' is in onderzoek
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

  Abstract Scenario: 'plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)' is in onderzoek
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

  Abstract Scenario: 'land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)' is in onderzoek
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

  Abstract Scenario: 'datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                               | waarde                    |
    | aanduiding in onderzoek (83.10)                                    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)                                     | 20020701                  |
    | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19630405                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                      |
    | type                | RaadpleegMetBurgerservicenummer             |
    | burgerservicenummer | 000000012                                   |
    | fields              | partners.aangaanHuwelijkPartnerschap.plaats |
    Dan heeft de response een persoon met een 'partner' zonder 'aangaanHuwelijkPartnerschap' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050610                  |

  Abstract Scenario: 'plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                                | waarde                    |
    | aanduiding in onderzoek (83.10)                                     | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)                                      | 20020701                  |
    | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | 0518                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                    |
    | type                | RaadpleegMetBurgerservicenummer           |
    | burgerservicenummer | 000000012                                 |
    | fields              | partners.aangaanHuwelijkPartnerschap.land |
    Dan heeft de response een persoon met een 'partner' zonder 'aangaanHuwelijkPartnerschap' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050620                  |

  Abstract Scenario: 'land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                              | waarde                    |
    | aanduiding in onderzoek (83.10)                                   | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)                                    | 20020701                  |
    | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30) | 6014                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                     |
    | type                | RaadpleegMetBurgerservicenummer            |
    | burgerservicenummer | 000000012                                  |
    | fields              | partners.aangaanHuwelijkPartnerschap.datum |
    Dan heeft de response een persoon met een 'partner' zonder 'aangaanHuwelijkPartnerschap' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050630                  |

  Abstract Scenario: ontbinding huwelijk/geregistreerd partnerschap veld(en) is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                              |
    | type                | RaadpleegMetBurgerservicenummer                     |
    | burgerservicenummer | 000000012                                           |
    | fields              | partners.ontbindingHuwelijkPartnerschap.inOnderzoek |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'ontbindingHuwelijkPartnerschap' gegevens
    | naam                                         | waarde               |
    | inOnderzoek.datum                            | <datum in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01           |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002          |

    Voorbeelden:
    | gba in onderzoek waarde | datum in onderzoek |
    | 050000                  | true               |
    | 050700                  | true               |
    | 050710                  | true               |

  Abstract Scenario: 'datum ontbinding huwelijkssluiting/geregistreerd partnerschap (07.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                         | waarde                    |
    | aanduiding in onderzoek (83.10)                              | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)                               | 20020701                  |
    | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20020101                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                        |
    | type                | RaadpleegMetBurgerservicenummer               |
    | burgerservicenummer | 000000012                                     |
    | fields              | partners.ontbindingHuwelijkPartnerschap.datum |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'ontbindingHuwelijkPartnerschap' gegevens
    | naam                                         | waarde         |
    | datum.type                                   | Datum          |
    | datum.datum                                  | 2002-01-01     |
    | datum.langFormaat                            | 1 januari 2002 |
    | inOnderzoek.datum                            | true           |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum          |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01     |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002    |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050710                  |

  Abstract Scenario: 'datum ontbinding huwelijkssluiting/geregistreerd partnerschap (07.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                         | waarde                    |
    | aanduiding in onderzoek (83.10)                              | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)                               | 20020701                  |
    | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20020101                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000012                            |
    | fields              | partners.aangaanHuwelijkPartnerschap |
    Dan heeft de response een persoon met een 'partner' zonder gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050710                  |
