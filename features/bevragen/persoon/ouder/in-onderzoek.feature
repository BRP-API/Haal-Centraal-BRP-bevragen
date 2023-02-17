# language: nl

Functionaliteit: Persoon: ouder velden zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en burgerservicenummer, geslacht en datumIngangFamilierechtelijkeBetrekking wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | burgerservicenummer (01.20)     | 000000401                 |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                    |
    | type                | RaadpleegMetBurgerservicenummer                                                           |
    | burgerservicenummer | 000000012                                                                                 |
    | fields              | ouders.burgerservicenummer,ouders.geslacht,ouders.datumIngangFamilierechtelijkeBetrekking |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam                                                | waarde                                          |
    | burgerservicenummer                                 | 000000401                                       |
    | inOnderzoek.burgerservicenummer                     | <burgerservicenummer io>                        |
    | inOnderzoek.geslacht                                | <geslacht io>                                   |
    | inOnderzoek.datumIngangFamilierechtelijkeBetrekking | <datum ingang familierechtelijke betrekking io> |
    | inOnderzoek.datumIngangOnderzoek.type               | Datum                                           |
    | inOnderzoek.datumIngangOnderzoek.datum              | 2002-07-01                                      |
    | inOnderzoek.datumIngangOnderzoek.langFormaat        | 1 juli 2002                                     |

    Voorbeelden:
    | ouder aanduiding | aanduiding in onderzoek | burgerservicenummer io | geslacht io | datum ingang familierechtelijke betrekking io | type                                       |
    | 1                | 020000                  | true                   | true        | true                                          | hele categorie ouder 1                     |
    | 1                | 020100                  | true                   |             |                                               | hele groep identificatienummers            |
    | 1                | 020120                  | true                   |             |                                               | burgerservicenummer                        |
    | 1                | 020400                  |                        | true        |                                               | hele groep geslacht                        |
    | 1                | 020410                  |                        | true        |                                               | geslachtsaanduiding                        |
    | 1                | 026200                  |                        |             | true                                          | hele groep familierechtelijke betrekking   |
    | 1                | 026210                  |                        |             | true                                          | datum ingang familierechtelijke betrekking |
    | 2                | 030000                  | true                   | true        | true                                          | hele categorie ouder 2                     |
    | 2                | 030100                  | true                   |             |                                               | hele groep identificatienummers            |
    | 2                | 030120                  | true                   |             |                                               | burgerservicenummer                        |
    | 2                | 030400                  |                        | true        |                                               | hele groep geslacht                        |
    | 2                | 030410                  |                        | true        |                                               | geslachtsaanduiding                        |
    | 2                | 036200                  |                        |             | true                                          | hele groep familierechtelijke betrekking   |
    | 2                | 036210                  |                        |             | true                                          | datum ingang familierechtelijke betrekking |

  Abstract Scenario: '<type>' is in onderzoek en burgerservicenummer wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | burgerservicenummer (01.20)     | 000000401                 |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.burgerservicenummer      |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam                                         | waarde      |
    | burgerservicenummer                          | 000000401   |
    | inOnderzoek.burgerservicenummer              | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | ouder aanduiding | aanduiding in onderzoek | type                            |
    | 1                | 020000                  | hele categorie ouder 1          |
    | 1                | 020100                  | hele groep identificatienummers |
    | 1                | 020120                  | burgerservicenummer             |
    | 2                | 030000                  | hele categorie ouder 2          |
    | 2                | 030100                  | hele groep identificatienummers |
    | 2                | 030120                  | burgerservicenummer             |

  Abstract Scenario: '<type>' is in onderzoek en geslacht wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | burgerservicenummer (01.20)     | 000000401                 |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.geslacht                 |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam                                         | waarde      |
    | inOnderzoek.geslacht                         | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | ouder aanduiding | aanduiding in onderzoek | type                   |
    | 1                | 020000                  | hele categorie ouder 1 |
    | 1                | 020400                  | hele groep geslacht    |
    | 1                | 020410                  | geslachtsaanduiding    |
    | 2                | 030000                  | hele categorie ouder 2 |
    | 2                | 030400                  | hele groep geslacht    |
    | 2                | 030410                  | geslachtsaanduiding    |

  Abstract Scenario: '<type>' is in onderzoek en datumIngangFamilierechtelijkeBetrekking wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | burgerservicenummer (01.20)     | 000000401                 |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                         |
    | type                | RaadpleegMetBurgerservicenummer                |
    | burgerservicenummer | 000000012                                      |
    | fields              | ouders.datumIngangFamilierechtelijkeBetrekking |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam                                                | waarde      |
    | inOnderzoek.datumIngangFamilierechtelijkeBetrekking | true        |
    | inOnderzoek.datumIngangOnderzoek.type               | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum              | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat        | 1 juli 2002 |

    Voorbeelden:
    | ouder aanduiding | aanduiding in onderzoek | type                                       |
    | 1                | 020000                  | hele categorie ouder 1                     |
    | 1                | 026200                  | hele groep familierechtelijke betrekking   |
    | 1                | 026210                  | datum ingang familierechtelijke betrekking |
    | 2                | 030000                  | hele categorie ouder 2                     |
    | 2                | 036200                  | hele groep familierechtelijke betrekking   |
    | 2                | 036210                  | datum ingang familierechtelijke betrekking |

  Abstract Scenario: '<type>' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | burgerservicenummer (01.20)     | 000000401                 |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.ouderAanduiding          |
    Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
    | naam            | waarde             |
    | ouderAanduiding | <ouder aanduiding> |

    Voorbeelden:
    | ouder aanduiding | aanduiding in onderzoek | type                                       |
    | 1                | 020120                  | burgerservicenummer                        |
    | 2                | 030120                  | burgerservicenummer                        |
    | 1                | 020400                  | hele groep geslacht                        |
    | 1                | 020410                  | geslachtsaanduiding                        |
    | 2                | 030400                  | hele groep geslacht                        |
    | 2                | 030410                  | geslachtsaanduiding                        |
    | 1                | 020200                  | hele groep familierechtelijke betrekking   |
    | 1                | 020210                  | datum ingang familierechtelijke betrekking |
    | 2                | 030200                  | hele groep familierechtelijke betrekking   |
    | 2                | 030210                  | datum ingang familierechtelijke betrekking |
