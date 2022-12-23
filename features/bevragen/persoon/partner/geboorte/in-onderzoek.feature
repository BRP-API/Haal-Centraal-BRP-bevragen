# language: nl

Functionaliteit: Persoon: partner geboorte velden zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en alle 'geboorte' velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.geboorte               |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'geboorte' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.datum                            | <datum io>  |
    | inOnderzoek.plaats                           | <plaats io> |
    | inOnderzoek.land                             | <land io>   |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | datum io | plaats io | land io | type |
    | 050000                  | true     | true      | true    |      |
    | 050300                  | true     | true      | true    |      |
    | 050310                  | true     |           |         |      |
    | 050320                  |          | true      |         |      |
    | 050330                  |          |           | true    |      |

  Abstract Scenario: '<type>' is in onderzoek en '<field>' veld wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.geboorte.<field>       |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'geboorte' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.<field>                          | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | field  | type |
    | 050000                  | datum  |      |
    | 050300                  | datum  |      |
    | 050310                  | datum  |      |
    | 050000                  | plaats |      |
    | 050300                  | plaats |      |
    | 050320                  | plaats |      |
    | 050000                  | land   |      |
    | 050300                  | land   |      |
    | 050330                  | land   |      |

  Abstract Scenario: '<type>' is in onderzoek, maar veld '<veld naam>' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <gevraagde fields>              |
    Dan heeft de response een persoon met een 'partner' zonder 'geboorte' gegevens

    Voorbeelden:
    | aanduiding in onderzoek | type | veld naam      | gevraagde fields         |
    | 050310                  |      | geboortedatum  | partners.geboorte.plaats |
    | 050320                  |      | geboorteplaats | partners.geboorte.land   |
    | 050330                  |      | geboorteland   | partners.geboorte.datum  |
