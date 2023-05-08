# language: nl

Functionaliteit: Persoon: ouder naam velden zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en alle 'naam' velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | burgerservicenummer (01.20)     | 000000401                 |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.naam                     |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde                       |
    | inOnderzoek.voornamen                        | <voornamen io>               |
    | inOnderzoek.adellijkeTitelPredicaat          | <adellijkeTitelPredicaat io> |
    | inOnderzoek.voorvoegsel                      | <voorvoegsel io>             |
    | inOnderzoek.geslachtsnaam                    | <geslachtsnaam io>           |
    | inOnderzoek.voorletters                      | <voorletters io>             |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                        |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                   |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                  |

    Voorbeelden:
    | ouder aanduiding | aanduiding in onderzoek | voornamen io | adellijkeTitelPredicaat io | voorvoegsel io | geslachtsnaam io | voorletters io | type                      |
    | 1                | 020000                  | true         | true                       | true           | true             | true           | hele categorie ouder 1    |
    | 1                | 020200                  | true         | true                       | true           | true             | true           | hele groep naam           |
    | 1                | 020210                  | true         |                            |                |                  | true           | voornamen                 |
    | 1                | 020220                  |              | true                       |                |                  |                | adellijke titel/predicaat |
    | 1                | 020230                  |              |                            | true           |                  |                | voorvoegsel geslachtsnaam |
    | 1                | 020240                  |              |                            |                | true             |                | geslachtsnaam             |
    | 2                | 030000                  | true         | true                       | true           | true             | true           | hele categorie ouder 2    |
    | 2                | 030200                  | true         | true                       | true           | true             | true           | hele groep naam           |
    | 2                | 030210                  | true         |                            |                |                  | true           | voornamen                 |
    | 2                | 030220                  |              | true                       |                |                  |                | adellijke titel/predicaat |
    | 2                | 030230                  |              |                            | true           |                  |                | voorvoegsel geslachtsnaam |
    | 2                | 030240                  |              |                            |                | true             |                | geslachtsnaam             |

  Abstract Scenario: '<type>' is in onderzoek en <field> wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | burgerservicenummer (01.20)     | 000000401                 |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.naam.<field>             |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.<field>                          | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | ouder aanduiding | aanduiding in onderzoek | field                   | type                      |
    | 1                | 020000                  | voornamen               | hele categorie ouder 1    |
    | 1                | 020200                  | voornamen               | hele groep naam           |
    | 1                | 020210                  | voornamen               | voornamen                 |
    | 2                | 030000                  | voornamen               | hele categorie ouder 2    |
    | 2                | 030200                  | voornamen               | hele groep naam           |
    | 2                | 030210                  | voornamen               | voornamen                 |
    | 1                | 020000                  | voorletters             | hele categorie ouder 1    |
    | 1                | 020200                  | voorletters             | hele groep naam           |
    | 1                | 020210                  | voorletters             | voornamen                 |
    | 2                | 030000                  | voorletters             | hele categorie ouder 2    |
    | 2                | 030200                  | voorletters             | hele groep naam           |
    | 2                | 030210                  | voorletters             | voornamen                 |
    | 1                | 020000                  | adellijkeTitelPredicaat | hele categorie ouder 1    |
    | 1                | 020200                  | adellijkeTitelPredicaat | hele groep naam           |
    | 1                | 020220                  | adellijkeTitelPredicaat | adellijke titel/predicaat |
    | 2                | 030000                  | adellijkeTitelPredicaat | hele groep ouder 2        |
    | 2                | 030200                  | adellijkeTitelPredicaat | hele groep naam           |
    | 2                | 030220                  | adellijkeTitelPredicaat | adellijke titel/predicaat |
    | 1                | 020000                  | voorvoegsel             | hele categorie ouder 1    |
    | 1                | 020200                  | voorvoegsel             | hele groep naam           |
    | 1                | 020230                  | voorvoegsel             | voorvoegsel geslachtsnaam |
    | 2                | 030000                  | voorvoegsel             | hele categorie ouder 2    |
    | 2                | 030200                  | voorvoegsel             | hele groep naam           |
    | 2                | 030230                  | voorvoegsel             | voorvoegsel geslachtsnaam |
    | 1                | 020000                  | geslachtsnaam           | hele categorie ouder 1    |
    | 1                | 020200                  | geslachtsnaam           | hele groep naam           |
    | 1                | 020240                  | geslachtsnaam           | geslachtsnaam             |
    | 2                | 030000                  | geslachtsnaam           | hele groep ouder 2        |
    | 2                | 030200                  | geslachtsnaam           | hele groep naam           |
    | 2                | 030240                  | geslachtsnaam           | geslachtsnaam             |

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
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'ouder' zonder 'naam' gegevens

    Voorbeelden:
    | ouder aanduiding | aanduiding in onderzoek | type                      | fields                              |
    | 1                | 020210                  | voornamen                 | ouders.naam.voorvoegsel             |
    | 2                | 030210                  | voornamen                 | ouders.naam.voorvoegsel             |
    | 1                | 020220                  | adellijke titel/predicaat | ouders.naam.voornamen               |
    | 2                | 030220                  | adellijke titel/predicaat | ouders.naam.voornamen               |
    | 1                | 020230                  | voorvoegsel geslachtsnaam | ouders.naam.geslachtsnaam           |
    | 2                | 030230                  | voorvoegsel geslachtsnaam | ouders.naam.geslachtsnaam           |
    | 1                | 020240                  | geslachtsnaam             | ouders.naam.adellijkeTitelPredicaat |
    | 2                | 030240                  | geslachtsnaam             | ouders.naam.adellijkeTitelPredicaat |
