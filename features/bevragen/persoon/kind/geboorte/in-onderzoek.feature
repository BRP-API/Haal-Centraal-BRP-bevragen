# language: nl

Functionaliteit: Persoon: kind geboorte velden zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en alle 'geboorte' velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | burgerservicenummer (01.20) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 123456789                   | <aanduiding in onderzoek>       | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.geboorte               |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'geboorte' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.datum                            | <datum io>  |
    | inOnderzoek.plaats                           | <plaats io> |
    | inOnderzoek.land                             | <land io>   |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | datum io | plaats io | land io | type                |
    | 090000                  | true     | true      | true    | hele categorie kind |
    | 090300                  | true     | true      | true    | hele groep geboorte |
    | 090310                  | true     |           |         | geboortedatum       |
    | 090320                  |          | true      |         | geboorteplaats      |
    | 090330                  |          |           | true    | geboorteland        |

  Abstract Scenario: '<type>' is in onderzoek en '<field>' veld wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | burgerservicenummer (01.20) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 123456789                   | <aanduiding in onderzoek>       | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.geboorte.<field>       |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'geboorte' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.<field>                          | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | field  | type                    |
    | 090000                  | datum  | hele categorie kind     |
    | 090300                  | datum  | hele categorie geboorte |
    | 090310                  | datum  | geboortedatum           |
    | 090000                  | plaats | hele categorie kind     |
    | 090300                  | plaats | hele categorie geboorte |
    | 090320                  | plaats | geboorteplaats          |
    | 090000                  | land   | hele categorie kind     |
    | 090300                  | land   | hele categorie geboorte |
    | 090330                  | land   | geboorteland            |

  Abstract Scenario: '<type>' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | burgerservicenummer (01.20) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 123456789                   | <aanduiding in onderzoek>       | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'kind' zonder 'geboorte' gegevens

    Voorbeelden:
    | aanduiding in onderzoek | type           | fields                   |
    | 090310                  | geboortedatum  | kinderen.geboorte.plaats |
    | 090320                  | geboorteplaats | kinderen.geboorte.land   |
    | 090330                  | geboorteland   | kinderen.geboorte.datum  |
