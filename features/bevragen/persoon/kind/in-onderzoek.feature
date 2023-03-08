# language: nl

Functionaliteit: Persoon: kind velden zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en burgerservicenummer wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | geslachtsnaam (02.40) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | Vries                 | <aanduiding in onderzoek>       | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.burgerservicenummer    |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende gegevens
    | naam                                         | waarde                   |
    | inOnderzoek.burgerservicenummer              | <burgerservicenummer io> |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                    |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01               |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002              |

    Voorbeelden:
    | aanduiding in onderzoek | burgerservicenummer io | type                            |
    | 090000                  | true                   | hele categorie kind             |
    | 090100                  | true                   | hele groep identificatienummers |
    | 090120                  | true                   | burgerservicenummer             |

  Abstract Scenario: '<type>' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | burgerservicenummer (01.20) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 123456789                   | <aanduiding in onderzoek>       | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.naam                   |
    Dan heeft de response een persoon met een 'kind' zonder 'naam' gegevens

    Voorbeelden:
    | aanduiding in onderzoek | type                            |
    | 090100                  | hele groep identificatienummers |
    | 090120                  | burgerservicenummer             |
