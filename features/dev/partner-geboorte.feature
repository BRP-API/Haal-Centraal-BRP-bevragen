# language: nl

Functionaliteit: Persoon: partner - geboorte

  Abstract Scenario: partner heeft 'geboorte' veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam       | waarde |
    | <gba naam> | <code> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.geboorte.<naam>        |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'geboorte' gegevens
    | naam                | waarde         |
    | <naam>.code         | <code>         |
    | <naam>.omschrijving | <omschrijving> |

    Voorbeelden:
    | gba naam               | naam   | code | omschrijving                 |
    | geboorteplaats (03.20) | plaats | 0518 | 's-Gravenhage                |
    | geboorteland (03.30)   | land   | 6014 | Verenigde Staten van Amerika |

  Abstract Scenario: partner heeft 'geboorte' datum veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.geboorte.datum         |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'geboorte' gegevens
    | naam              | waarde         |
    | datum.type        | Datum          |
    | datum.datum       | <waarde>       |
    | datum.langFormaat | <lang formaat> |

    Voorbeelden:
    | gba naam              | gba waarde | waarde     | lang formaat |
    | geboortedatum (03.10) | 20020701   | 2002-07-01 | 1 juli 2002  |

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

  Abstract Scenario: 'geboortedatum (03.10)' is in onderzoek
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

  Abstract Scenario: 'geboorteplaats (03.20)' is in onderzoek
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

  Abstract Scenario: 'geboorteland (03.30)' is in onderzoek
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

  Abstract Scenario: 'geboortedatum (03.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboortedatum (03.10)           | 19630405                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.geboorte.plaats        |
    Dan heeft de response een persoon met een 'partner' zonder 'geboorte' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050310                  |

  Abstract Scenario: 'geboorteplaats (03.20)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboorteplaats (03.20)          | 0518                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.geboorte.land        |
    Dan heeft de response een persoon met een 'partner' zonder 'geboorte' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050320                  |

  Abstract Scenario: 'geboorteland (03.30)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboorteland (03.30)            | 6014                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.geboorte.datum         |
    Dan heeft de response een persoon met een 'partner' zonder 'geboorte' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050330                  |
