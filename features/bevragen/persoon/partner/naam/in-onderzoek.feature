# language: nl

Functionaliteit: Persoon: partner naam velden zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en alle 'naam' velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.naam                   |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'naam' gegevens
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
    | aanduiding in onderzoek | voornamen io | adellijkeTitelPredicaat io | voorvoegsel io | geslachtsnaam io | voorletters io | type |
    | 050000                  | true         | true                       | true           | true             | true           |      |
    | 050200                  | true         | true                       | true           | true             | true           |      |
    | 050210                  | true         |                            |                |                  | true           |      |
    | 050220                  |              | true                       |                |                  |                |      |
    | 050230                  |              |                            | true           |                  |                |      |
    | 050240                  |              |                            |                | true             |                |      |

  Abstract Scenario: '<type>' is in onderzoek en '<field>' veld wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.naam.<field>           |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.<field>                          | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | field                   | type |
    | 050000                  | voornamen               |      |
    | 050200                  | voornamen               |      |
    | 050210                  | voornamen               |      |
    | 050000                  | adellijkeTitelPredicaat |      |
    | 050200                  | adellijkeTitelPredicaat |      |
    | 050220                  | adellijkeTitelPredicaat |      |
    | 050000                  | voorvoegsel             |      |
    | 050200                  | voorvoegsel             |      |
    | 050230                  | voorvoegsel             |      |
    | 050000                  | geslachtsnaam           |      |
    | 050200                  | geslachtsnaam           |      |
    | 050240                  | geslachtsnaam           |      |
    | 050000                  | voorletters             |      |
    | 050200                  | voorletters             |      |
    | 050210                  | voorletters             |      |

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
    Dan heeft de response een persoon met een 'partner' zonder 'naam' gegevens

    Voorbeelden:
    | aanduiding in onderzoek | type | veld naam               | gevraagde fields                      |
    | 050210                  |      | voornamen               | partners.naam.voorvoegsel             |
    | 050220                  |      | adellijkeTitelPredicaat | partners.naam.voornamen               |
    | 050230                  |      | voorvoegsel             | partners.naam.geslachtsnaam           |
    | 050240                  |      | geslachtsnaam           | partners.naam.adellijkeTitelPredicaat |
