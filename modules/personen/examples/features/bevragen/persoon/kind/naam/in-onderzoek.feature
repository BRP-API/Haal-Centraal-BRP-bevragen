# language: nl

Functionaliteit: Persoon: kind naam velden zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en alle 'naam' velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | burgerservicenummer (01.20) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 123456789                   | <aanduiding in onderzoek>       | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.naam                   |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'naam' gegevens
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
    | aanduiding in onderzoek | voornamen io | adellijkeTitelPredicaat io | voorvoegsel io | geslachtsnaam io | voorletters io | type                      |
    | 090000                  | true         | true                       | true           | true             | true           | hele categorie kind       |
    | 090200                  | true         | true                       | true           | true             | true           | hele groep naam           |
    | 090210                  | true         |                            |                |                  | true           | voornamen                 |
    | 090220                  |              | true                       |                |                  |                | adellijke titel/predicaat |
    | 090230                  |              |                            | true           |                  |                | voorvoegsel geslachtsnaam |
    | 090240                  |              |                            |                | true             |                | geslachtsnaam             |

  Abstract Scenario: '<type>' is in onderzoek en <field> wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | burgerservicenummer (01.20) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 123456789                   | <aanduiding in onderzoek>       | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.naam.<field>           |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.<field>                          | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | field                   | type                      |
    | 090000                  | voornamen               | hele categorie kind       |
    | 090200                  | voornamen               | hele groep naam           |
    | 090210                  | voornamen               | voornamen                 |
    | 090000                  | voorletters             | hele categorie kind       |
    | 090200                  | voorletters             | hele groep naam           |
    | 090210                  | voorletters             | voornamen                 |
    | 090000                  | adellijkeTitelPredicaat | hele categorie kind       |
    | 090200                  | adellijkeTitelPredicaat | hele groep naam           |
    | 090220                  | adellijkeTitelPredicaat | adellijke titel/predicaat |
    | 090000                  | voorvoegsel             | hele categorie kind       |
    | 090200                  | voorvoegsel             | hele groep naam           |
    | 090230                  | voorvoegsel             | voorvoegsel geslachtsnaam |
    | 090000                  | geslachtsnaam           | hele categorie kind       |
    | 090200                  | geslachtsnaam           | hele groep naam           |
    | 090240                  | geslachtsnaam           | geslachtsnaam             |

  Abstract Scenario: '<type>' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | burgerservicenummer (01.20) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 123456789                   | <aanduiding in onderzoek>       | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'kind' zonder 'naam' gegevens

    Voorbeelden:
    | aanduiding in onderzoek | type                      | fields                                |
    | 090210                  | voornamen                 | kinderen.naam.voorvoegsel             |
    | 090220                  | adellijke titel/predicaat | kinderen.naam.voornamen               |
    | 090230                  | voorvoegsel               | kinderen.naam.geslachtsnaam           |
    | 090240                  | geslachtsnaam             | kinderen.naam.adellijkeTitelPredicaat |
