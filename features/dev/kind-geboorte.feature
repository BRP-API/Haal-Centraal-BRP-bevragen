#language: nl

Functionaliteit: Kind: geboorte velden

  Abstract Scenario: kind heeft 'geboorte' veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam       | waarde |
    | <gba naam> | <code> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.geboorte.<naam>        |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'geboorte' gegevens
    | naam                | waarde         |
    | <naam>.code         | <code>         |
    | <naam>.omschrijving | <omschrijving> |

    Voorbeelden:
    | gba naam               | naam   | code | omschrijving                 |
    | geboorteplaats (03.20) | plaats | 0518 | 's-Gravenhage                |
    | geboorteland (03.30)   | land   | 6014 | Verenigde Staten van Amerika |

  Scenario: kind heeft 'geboorte' datum veld: 'geboortedatum (03.10)'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.geboorte.datum         |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'geboorte' gegevens
    | naam              | waarde      |
    | datum.type        | Datum       |
    | datum.datum       | 2002-07-01  |
    | datum.langFormaat | 1 juli 2002 |

  Abstract Scenario: kind heeft 'geboorte' veld met onbekend waarde: 'geboortedatum (03.10)'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 00000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met een 'kind' met de volgende 'geboorte' gegevens
    | naam              | waarde        |
    | datum.type        | DatumOnbekend |
    | datum.onbekend    | true          |
    | datum.langFormaat | onbekend      |

    Voorbeelden:
    | field                   |
    | kinderen                |
    | kinderen.geboorte       |
    | kinderen.geboorte.datum |

  Abstract Scenario: kind heeft 'geboorte' veld met onbekend waarde: 'geboorteplaats (03.20)'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                   | waarde |
    | geboorteplaats (03.20) | 0000   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met een 'kind' zonder 'geboorte' gegevens

    Voorbeelden:
    | field                    |
    | kinderen                 |
    | kinderen.geboorte        |
    | kinderen.geboorte.plaats |

  Abstract Scenario: kind heeft 'geboorte' veld met onbekend waarde: 'geboorteland (03.30)'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                 | waarde |
    | geboorteland (03.30) | 0000   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met een 'kind' zonder 'geboorte' gegevens

    Voorbeelden:
    | field                  |
    | kinderen               |
    | kinderen.geboorte      |
    | kinderen.geboorte.land |

  Abstract Scenario: 'geboorte' velden van kind is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.geboorte.inOnderzoek   |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'geboorte' gegevens
    | naam                                         | waarde                |
    | inOnderzoek.datum                            | <datum in onderzoek>  |
    | inOnderzoek.plaats                           | <plaats in onderzoek> |
    | inOnderzoek.land                             | <land in onderzoek>   |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                 |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01            |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002           |

    Voorbeelden:
    | gba in onderzoek waarde | datum in onderzoek | plaats in onderzoek | land in onderzoek |
    | 090000                  | true               | true                | true              |
    | 090300                  | true               | true                | true              |
    | 090310                  | true               |                     |                   |
    | 090320                  |                    | true                |                   |
    | 090330                  |                    |                     | true              |

  Abstract Scenario: 'geboortedatum (03.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboortedatum (03.10)           | 20200405                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.geboorte.datum         |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'geboorte' gegevens
    | naam                                         | waarde       |
    | datum.type                                   | Datum        |
    | datum.datum                                  | 2020-04-05   |
    | datum.langFormaat                            | 5 april 2020 |
    | inOnderzoek.datum                            | true         |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum        |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01   |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002  |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 090000                  |
    | 090300                  |
    | 090310                  |

  Abstract Scenario: 'geboorteplaats (03.20)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboorteplaats (03.20)          | 0344                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.geboorte.plaats        |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'geboorte' gegevens
    | naam                                         | waarde      |
    | plaats.code                                  | 0344        |
    | plaats.omschrijving                          | Utrecht     |
    | inOnderzoek.plaats                           | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 090000                  |
    | 090300                  |
    | 090320                  |

  Abstract Scenario: 'geboorteland (03.30)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboorteland (03.30)            | 6014                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.geboorte.land          |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'geboorte' gegevens
    | naam                                         | waarde                       |
    | land.code                                    | 6014                         |
    | land.omschrijving                            | Verenigde Staten van Amerika |
    | inOnderzoek.land                             | true                         |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                        |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                   |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                  |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 090000                  |
    | 090300                  |
    | 090330                  |

  Abstract Scenario: 'geboortedatum (03.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboortedatum (03.10)           | 20200405                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.geboorte.plaats        |
    Dan heeft de response een persoon met een 'kind' zonder 'geboorte' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 090310                  |

  Abstract Scenario: 'geboorteplaats (03.20)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboorteplaats (03.20)          | 0344                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.geboorte.land          |
    Dan heeft de response een persoon met een 'kind' zonder 'geboorte' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 090320                  |

  Abstract Scenario: 'geboorteland (03.30)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboorteland (03.30)            | 6014                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.geboorte.datum         |
    Dan heeft de response een persoon met een 'kind' zonder 'geboorte' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 090330                  |
