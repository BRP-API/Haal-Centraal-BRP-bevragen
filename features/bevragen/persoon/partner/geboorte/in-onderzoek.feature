# language: nl

Functionaliteit: Persoon: partner geboorte velden zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en alle 'geboorte' velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | voornamen (02.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | Merel             | <aanduiding in onderzoek>       | 20020701                       |
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
    | aanduiding in onderzoek | datum io | plaats io | land io | type                                               |
    | 050000                  | true     | true      | true    | hele categorie huwelijk/geregistreerd partnerschap |
    | 050300                  | true     | true      | true    | hele groep geboorte                                |
    | 050310                  | true     |           |         | geboortedatum                                      |
    | 050320                  |          | true      |         | geboorteplaats                                     |
    | 050330                  |          |           | true    | geboorteland                                       |

  Abstract Scenario: '<type>' is in onderzoek en '<field>' veld wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | voornamen (02.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | Merel             | <aanduiding in onderzoek>       | 20020701                       |
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
    | aanduiding in onderzoek | field  | type                                               |
    | 050000                  | datum  | hele categorie huwelijk/geregistreerd partnerschap |
    | 050300                  | datum  | hele groep geboorte                                |
    | 050310                  | datum  | geboortedatum                                      |
    | 050000                  | plaats | hele categorie huwelijk/geregistreerd partnerschap |
    | 050300                  | plaats | hele groep geboorte                                |
    | 050320                  | plaats | geboorteplaats                                     |
    | 050000                  | land   | hele categorie huwelijk/geregistreerd partnerschap |
    | 050300                  | land   | hele groep geboorte                                |
    | 050330                  | land   | geboorteland                                       |

  Abstract Scenario: '<type>' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | voornamen (02.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | Merel             | <aanduiding in onderzoek>       | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'partner' zonder 'geboorte' gegevens

    Voorbeelden:
    | aanduiding in onderzoek | type           | fields                   |
    | 050310                  | geboortedatum  | partners.geboorte.plaats |
    | 050320                  | geboorteplaats | partners.geboorte.land   |
    | 050330                  | geboorteland   | partners.geboorte.datum  |
