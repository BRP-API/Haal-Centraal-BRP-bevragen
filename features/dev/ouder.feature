# language: nl

Functionaliteit: Persoon: ouder

  Abstract Scenario: ouder heeft veld: 'burgerservicenummer (01.20)'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                        | waarde   |
    | burgerservicenummer (01.20) | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                            |
    | type                | RaadpleegMetBurgerservicenummer                   |
    | burgerservicenummer | 000000012                                         |
    | fields              | ouders.ouderAanduiding,ouders.burgerservicenummer |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam                | waarde             |
    | ouderAanduiding     | <ouder aanduiding> |
    | burgerservicenummer | <waarde>           |

    Voorbeelden:
    | ouder aanduiding | waarde    |
    | 1                | 000000013 |
    | 2                | 000000014 |

  Abstract Scenario: ouder heeft veld: 'geslachtsaanduiding (04.10)'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                        | waarde |
    | geslachtsaanduiding (04.10) | M      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000012                            |
    | fields              | ouders.ouderAanduiding,ouders.<naam> |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam                  | waarde             |
    | ouderAanduiding       | <ouder aanduiding> |
    | geslacht.code         | M                  |
    | geslacht.omschrijving | man                |

    Voorbeelden:
    | ouder aanduiding | naam                  |
    | 1                | geslacht              |
    | 2                | geslacht.omschrijving |

  Scenario: ouder heeft datum veld: 'datum ingang familierechtelijke betrekking (62.10)'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
    | naam                                               | waarde   |
    | datum ingang familierechtelijke betrekking (62.10) | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                         |
    | type                | RaadpleegMetBurgerservicenummer                |
    | burgerservicenummer | 000000012                                      |
    | fields              | ouders.datumIngangFamilierechtelijkeBetrekking |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam                                                | waarde      |
    | datumIngangFamilierechtelijkeBetrekking.type        | Datum       |
    | datumIngangFamilierechtelijkeBetrekking.datum       | 2002-07-01  |
    | datumIngangFamilierechtelijkeBetrekking.langFormaat | 1 juli 2002 |

  Scenario: persoon heeft een ouder '1' met voornamen in onderzoek en een ouder '2'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
    | naam                            | waarde   |
    | voornamen (02.10)               | Renée    |
    | aanduiding in onderzoek (83.10) | 020210   |
    | datum ingang onderzoek (83.20)  | 20220307 |
    En de persoon heeft een ouder '2' met de volgende gegevens
    | naam              | waarde |
    | voornamen (02.10) | Willy  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                         |
    | type                | RaadpleegMetBurgerservicenummer                |
    | burgerservicenummer | 000000012                                      |
    | fields              | ouders.ouderAanduiding,ouders.naam.voorletters |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam            | waarde |
    | ouderAanduiding | 1      |
    En heeft de 'ouder' de volgende 'naam' gegevens
    | naam                                         | waarde       |
    | voorletters                                  | R.           |
    | inOnderzoek.voorletters                      | true         |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum        |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |
    En heeft de persoon een 'ouder' met de volgende gegevens
    | naam             | waarde |
    | ouderAanduiding  | 2      |
    | naam.voorletters | W.     |

  Abstract Scenario: veld(en) van ouder <ouder aanduiding> is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.inOnderzoek              |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam                                                | waarde                                                    |
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

  Abstract Scenario: 'burgerservicenummer (01.20)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | burgerservicenummer (01.20)     | 000000013                 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.burgerservicenummer      |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam                                         | waarde      |
    | burgerservicenummer                          | 000000013   |
    | inOnderzoek.burgerservicenummer              | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde |
    | 1                | 020000                  |
    | 1                | 020100                  |
    | 1                | 020120                  |
    | 2                | 030000                  |
    | 2                | 030100                  |
    | 2                | 030120                  |

  Abstract Scenario: 'geslachtsaanduiding (04.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geslachtsaanduiding (04.10)     | O                         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.geslacht                 |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam                                         | waarde      |
    | geslacht.code                                | O           |
    | geslacht.omschrijving                        | onbekend    |
    | inOnderzoek.geslacht                         | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde |
    | 1                | 020000                  |
    | 1                | 020400                  |
    | 1                | 020410                  |
    | 2                | 030000                  |
    | 2                | 030400                  |
    | 2                | 030410                  |

  Abstract Scenario: 'datum ingang familierechtelijke betrekking (62.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                                               | waarde                    |
    | aanduiding in onderzoek (83.10)                    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)                     | 20020701                  |
    | datum ingang familierechtelijke betrekking (62.10) | 20020101                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                         |
    | type                | RaadpleegMetBurgerservicenummer                |
    | burgerservicenummer | 000000012                                      |
    | fields              | ouders.datumIngangFamilierechtelijkeBetrekking |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam                                                | waarde         |
    | datumIngangFamilierechtelijkeBetrekking.type        | Datum          |
    | datumIngangFamilierechtelijkeBetrekking.datum       | 2002-01-01     |
    | datumIngangFamilierechtelijkeBetrekking.langFormaat | 1 januari 2002 |
    | inOnderzoek.datumIngangFamilierechtelijkeBetrekking | true           |
    | inOnderzoek.datumIngangOnderzoek.type               | Datum          |
    | inOnderzoek.datumIngangOnderzoek.datum              | 2002-07-01     |
    | inOnderzoek.datumIngangOnderzoek.langFormaat        | 1 juli 2002    |

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde |
    | 1                | 020000                  |
    | 1                | 026200                  |
    | 1                | 026210                  |
    | 2                | 030000                  |
    | 2                | 036200                  |
    | 2                | 036210                  |

  Abstract Scenario: 'burgerservicenummer (01.20)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | burgerservicenummer (01.20)     | 000000013                 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.ouderAanduiding          |
    Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
    | naam            | waarde             |
    | ouderAanduiding | <ouder aanduiding> |

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde |
    | 1                | 020120                  |
    | 2                | 030120                  |

  Abstract Scenario: 'geslachtsaanduiding (04.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geslachtsaanduiding (04.10)     | <waarde>                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.ouderAanduiding          |
    Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
    | naam            | waarde             |
    | ouderAanduiding | <ouder aanduiding> |

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde | waarde |
    | 1                | 020400                  | M      |
    | 1                | 020410                  | V      |
    | 2                | 030400                  | O      |
    | 2                | 030410                  | M      |

  Abstract Scenario: 'datum ingang familierechtelijke betrekking (62.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                                               | waarde                    |
    | aanduiding in onderzoek (83.10)                    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)                     | 20020701                  |
    | datum ingang familierechtelijke betrekking (62.10) | 20020101                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.ouderAanduiding          |
    Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
    | naam            | waarde             |
    | ouderAanduiding | <ouder aanduiding> |

    Voorbeelden:
    | ouder aanduiding | gba in onderzoek waarde |
    | 1                | 020200                  |
    | 1                | 020210                  |
    | 2                | 030200                  |
    | 2                | 030210                  |
