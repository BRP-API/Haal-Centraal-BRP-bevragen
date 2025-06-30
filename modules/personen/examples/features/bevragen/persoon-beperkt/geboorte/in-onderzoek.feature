#language: nl

Functionaliteit: Persoon beperkt: geboorte velden in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en geboorte wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | geslachtsnaam (02.40)           | Maassen                   |
    | geboortedatum (03.10)           | 19830526                  |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | geboorte                            |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam                                         | waarde      |
    | datum.type                                   | Datum       |
    | datum.datum                                  | 1983-05-26  |
    | datum.langFormaat                            | 26 mei 1983 |
    | inOnderzoek.datum                            | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | type                   |
    | 010000                  | hele categorie persoon |
    | 010300                  | hele groep geboorte    |
    | 010310                  | geboortedatum          |

  Abstract Scenario: '<type>' is in onderzoek en geboortedatum wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | geslachtsnaam (02.40)           | Maassen                   |
    | geboortedatum (03.10)           | 19830526                  |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | geboorte.datum                      |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam                                         | waarde      |
    | datum.type                                   | Datum       |
    | datum.datum                                  | 1983-05-26  |
    | datum.langFormaat                            | 26 mei 1983 |
    | inOnderzoek.datum                            | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | type                   |
    | 010000                  | hele categorie persoon |
    | 010300                  | hele groep geboorte    |
    | 010310                  | geboortedatum          |
