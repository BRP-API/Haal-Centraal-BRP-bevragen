# language: nl

Functionaliteit: Persoon: partner naam velden zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en alle 'naam' velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | burgerservicenummer (01.20) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 123456789                   | <aanduiding in onderzoek>       | 20020701                       |
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
    | aanduiding in onderzoek | voornamen io | adellijkeTitelPredicaat io | voorvoegsel io | geslachtsnaam io | voorletters io | type                                               |
    | 050000                  | true         | true                       | true           | true             | true           | hele categorie huwelijk/geregistreerd partnerschap |
    | 050200                  | true         | true                       | true           | true             | true           | hele groep naam                                    |
    | 050210                  | true         |                            |                |                  | true           | voornamen                                          |
    | 050220                  |              | true                       |                |                  |                | adellijke titel/predicaat                          |
    | 050230                  |              |                            | true           |                  |                | voorvoegsel geslachtsnaam                          |
    | 050240                  |              |                            |                | true             |                | geslachtsnaam                                      |

  Abstract Scenario: '<type>' is in onderzoek en '<field>' veld wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | burgerservicenummer (01.20) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 123456789                   | <aanduiding in onderzoek>       | 20020701                       |
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
    | aanduiding in onderzoek | field                   | type                                               |
    | 050000                  | voornamen               | hele categorie huwelijk/geregistreerd partnerschap |
    | 050200                  | voornamen               | hele groep naam                                    |
    | 050210                  | voornamen               | voornamen                                          |
    | 050000                  | adellijkeTitelPredicaat | hele categorie huwelijk/geregistreerd partnerschap |
    | 050200                  | adellijkeTitelPredicaat | hele groep naam                                    |
    | 050220                  | adellijkeTitelPredicaat | adellijke titel/predicaat                          |
    | 050000                  | voorvoegsel             | hele categorie huwelijk/geregistreerd partnerschap |
    | 050200                  | voorvoegsel             | hele groep naam                                    |
    | 050230                  | voorvoegsel             | voorvoegsel geslachtsnaam                          |
    | 050000                  | geslachtsnaam           | hele categorie huwelijk/geregistreerd partnerschap |
    | 050200                  | geslachtsnaam           | hele groep naam                                    |
    | 050240                  | geslachtsnaam           | geslachtsnaam                                      |
    | 050000                  | voorletters             | hele categorie huwelijk/geregistreerd partnerschap |
    | 050200                  | voorletters             | hele groep naam                                    |
    | 050210                  | voorletters             | voornamen                                          |

  Abstract Scenario: '<type>' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | burgerservicenummer (01.20) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 123456789                   | <aanduiding in onderzoek>       | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'partner' zonder 'naam' gegevens

    Voorbeelden:
    | aanduiding in onderzoek | type                      | fields                                |
    | 050210                  | voornamen                 | partners.naam.voorvoegsel             |
    | 050220                  | adellijke titel/predicaat | partners.naam.voornamen               |
    | 050230                  | voorvoegsel geslachtsnaam | partners.naam.geslachtsnaam           |
    | 050240                  | geslachtsnaam             | partners.naam.adellijkeTitelPredicaat |
