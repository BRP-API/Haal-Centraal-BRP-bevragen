# language: nl

Functionaliteit: Persoon: ouder 'geboorte' velden zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en alle geboorte velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | burgerservicenummer (01.20)     | 000000401                 |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.geboorte                 |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'geboorte' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.datum                            | <datum io>  |
    | inOnderzoek.plaats                           | <plaats io> |
    | inOnderzoek.land                             | <land io>   |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | ouder aanduiding | aanduiding in onderzoek | datum io | plaats io | land io | type                   |
    | 1                | 020000                  | true     | true      | true    | hele categorie ouder 1 |
    | 1                | 020300                  | true     | true      | true    | hele groep geboorte    |
    | 1                | 020310                  | true     |           |         | geboortedatum          |
    | 1                | 020320                  |          | true      |         | geboorteplaats         |
    | 1                | 020330                  |          |           | true    | geboorteland           |
    | 2                | 030000                  | true     | true      | true    | hele categorie ouder 2 |
    | 2                | 030300                  | true     | true      | true    | hele groep geboorte    |
    | 2                | 030310                  | true     |           |         | geboortedatum          |
    | 2                | 030320                  |          | true      |         | geboorteplaats         |
    | 2                | 030330                  |          |           | true    | geboorteland           |

  Abstract Scenario: '<type>' is in onderzoek en '<field>' veld wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                            | waarde                    |
    | burgerservicenummer (01.20)     | 000000401                 |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.geboorte.<field>         |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'geboorte' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.<field>                          | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | ouder aanduiding | aanduiding in onderzoek | field  | type                   |
    | 1                | 020000                  | datum  | hele categorie ouder 1 |
    | 1                | 020300                  | datum  | hele groep geboorte    |
    | 1                | 020310                  | datum  | geboortedatum          |
    | 2                | 030000                  | datum  | hele categorie ouder 2 |
    | 2                | 030300                  | datum  | hele groep geboorte    |
    | 2                | 030310                  | datum  | geboortedatum          |
    | 1                | 020000                  | plaats | hele categorie ouder 1 |
    | 1                | 020300                  | plaats | hele groep geboorte    |
    | 1                | 020320                  | plaats | geboorteplaats         |
    | 2                | 030000                  | plaats | hele categorie ouder 2 |
    | 2                | 030300                  | plaats | hele groep geboorte    |
    | 2                | 030320                  | plaats | geboorteplaats         |
    | 1                | 020000                  | land   | hele categorie ouder 1 |
    | 1                | 020300                  | land   | hele groep geboorte    |
    | 1                | 020330                  | land   | geboorteland           |
    | 2                | 030000                  | land   | hele categorie ouder 2 |
    | 2                | 030300                  | land   | hele groep geboorte    |
    | 2                | 030330                  | land   | geboorteland           |

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
    Dan heeft de response een persoon met een 'ouder' zonder 'geboorte' gegevens

    Voorbeelden:
    | ouder aanduiding | aanduiding in onderzoek | type           | fields                 |
    | 1                | 020310                  | geboortedatum  | ouders.geboorte.plaats |
    | 2                | 030310                  | geboortedatum  | ouders.geboorte.plaats |
    | 1                | 020320                  | geboorteplaats | ouders.geboorte.land   |
    | 2                | 030320                  | geboorteplaats | ouders.geboorte.land   |
    | 1                | 020330                  | geboorteland   | ouders.geboorte.datum  |
    | 2                | 030330                  | geboorteland   | ouders.geboorte.datum  |
