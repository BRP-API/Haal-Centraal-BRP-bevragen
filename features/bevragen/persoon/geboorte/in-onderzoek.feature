#language: nl

Functionaliteit: Persoon: geboorte velden in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en geboortedatum, plaats en land worden gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboortedatum (03.10)           | 19630405                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                       |
    | type                | RaadpleegMetBurgerservicenummer              |
    | burgerservicenummer | 000000152                                    |
    | fields              | geboorte.datum,geboorte.plaats,geboorte.land |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam                                         | waarde       |
    | datum.type                                   | Datum        |
    | datum.datum                                  | 1963-04-05   |
    | datum.langFormaat                            | 5 april 1963 |
    | inOnderzoek.datum                            | <datum io>   |
    | inOnderzoek.plaats                           | <plaats io>  |
    | inOnderzoek.land                             | <land io>    |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum        |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01   |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002  |

    Voorbeelden:
    | aanduiding in onderzoek | datum io | plaats io | land io | type                   |
    | 010000                  | true     | true      | true    | hele categorie persoon |
    | 010300                  | true     | true      | true    | hele groep geboorte    |
    | 010310                  | true     |           |         | geboortedatum          |
    | 010320                  |          | true      |         | geboorteplaats         |
    | 010330                  |          |           | true    | geboorteland           |

  Scenario: 'geboortedatum' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde   |
    | aanduiding in onderzoek (83.10) | 010310   |
    | datum ingang onderzoek (83.20)  | 20020701 |
    | geboortedatum (03.10)           | 19630405 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | geboorte.plaats                 |
    Dan heeft de response een persoon zonder 'geboorte' gegevens

  Scenario: 'geboorteplaats' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde   |
    | aanduiding in onderzoek (83.10) | 010320   |
    | datum ingang onderzoek (83.20)  | 20020701 |
    | geboorteplaats (03.20)          | 0518     |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | geboorte.land                   |
    Dan heeft de response een persoon zonder 'geboorte' gegevens

  Scenario: 'geboorteland' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde   |
    | aanduiding in onderzoek (83.10) | 010330   |
    | datum ingang onderzoek (83.20)  | 20020701 |
    | geboorteland (03.30)            | 6014     |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | geboorte.datum                  |
    Dan heeft de response een persoon zonder 'geboorte' gegevens

  Scenario: hele groep 'geboorte' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde   |
    | aanduiding in onderzoek (83.10) | 010300   |
    | datum ingang onderzoek (83.20)  | 20020701 |
    | geboorteland (03.30)            | 6014     |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | burgerservicenummer             |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000152 |
